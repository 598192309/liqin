//
//  LaunchingViewController.m
//  IUang
//
//  Created by jayden on 2018/4/24.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "LaunchingViewController.h"
#import <MapKit/MapKit.h>
#import "InitApi.h"
#import "InitModel.h"
#import "LorginViewController.h"
#import "CommonModel.h"
#import "CommonApi.h"


@interface LaunchingViewController ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic,assign)BOOL stop;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIAlertController *updateAlert;//更新提示
@property(nonatomic,strong)InitModel *dataModel;

@end

@implementation LaunchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImageView *backView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backView.image = [UIImage imageNamed:@"StartPage"];
    [self.view addSubview:backView];
    backView.center = self.view.center;
    _imageView = backView;
    backView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [backView addGestureRecognizer:tap];
    if (IS_IPHONEX) {
        backView.contentMode = UIViewContentModeScaleToFill;
    }else{
        backView.contentMode = UIViewContentModeScaleAspectFill;
    }

    
    UIButton * b = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 20, 20)];
    b.backgroundColor =[UIColor redColor];
//    [self.view addSubview:b];
//    [b addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self requestCommonInfo];
    
    [self initAPP];
    

}

- (void)dealloc{
    LQLog([NSString stringWithFormat:@"dealloc ---- %@",NSStringFromClass([self class])]);
    
}
#pragma mark - act
#pragma  mark - 自定义
- (void)tap:(UITapGestureRecognizer *)gest{
    if (_imageView.image) {
        if ([_dataModel.Init_ads.url hasPrefix:@"http"]) {
            UIApplication *application = [UIApplication sharedApplication];
            if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [application openURL:[NSURL URLWithString:_dataModel.Init_ads.url] options:@{} completionHandler:nil];
            }else{
                [application openURL:[NSURL URLWithString:_dataModel.Init_ads.url]];
                
            }
            
        }
    }
}


-(void)initAPP{
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.distanceFilter = 1;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 设置定位精度(精度越高越耗电)
        self.locationManager.delegate = self;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
    } else{
        [self requsetWithlat:@"" lang:@"" accuracy:@""];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *loc = [locations firstObject];
    //获得地理位置，把经纬度赋给我们定义的属性
    NSString * latitude = [NSString stringWithFormat:@"%f", loc.coordinate.latitude];
    NSString * longitude = [NSString stringWithFormat:@"%f", loc.coordinate.longitude];
    //将位置保存  后面正式提交申请的时候需要用到
    CLLocation *location = locations.lastObject;
    //    RI.location = location;
    
    NSTimeInterval locationAge = -[location.timestamp timeIntervalSinceNow];
    if (locationAge > 2.0) return;//以防多次调用
    [manager stopUpdatingLocation];

    
    if (!_stop) {
        [self requsetWithlat:latitude lang:longitude accuracy:[NSString stringWithFormat:@"%f",loc.altitude]];
    }

}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    LQLog(@"%@",error);
    [manager stopUpdatingLocation];
    if (!_stop) {
        [self requsetWithlat:@"" lang:@"" accuracy:@""];
    }
}
-(void)requsetWithlat:(NSString*)lat lang:(NSString*)lang accuracy:(NSString *)accuracy{
    __weak __typeof(self) weakSelf = self;
    weakSelf.stop = YES;
    [InitApi initialWithLat:lat lang:lang accuracy:accuracy success:^(NSString *msg, NSInteger status, NSString *authorization) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIViewController *vc2 = [UIViewController topViewController];
            if ( ![[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[MainTabBarController class]] && ! [vc2 isKindOfClass:[LorginViewController class]]) {
                APPDelegate.window.rootViewController = [AppDelegate shareAppDelegate].rootTabbar;
            }
        });
    } error:^(NSError *error, id resultObject) {
        [self showHUD:error.errorMsg];
        weakSelf.stop = NO;

    }];

}
//获取通用信息
- (void)requestCommonInfo{
    [CommonApi requestCommonInfoSuccess:^(NSString *msg, NSInteger status, CommonInfoItem *commonInfoItem) {
        
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
    }];
}

#pragma  mark - lazy
- (UIAlertController *)updateAlert{
    if (_updateAlert == nil) {
        __weak __typeof(self) weakSelf = self;
        // 获取最新的版本号
        NSDictionary *dict =  [NSBundle mainBundle].infoDictionary;
        NSString *appVersion = dict[@"CFBundleShortVersionString"];
        NSString *msg = [self.dataModel.version.upgrade_msg stringByReplacingOccurrencesOfString:@"{current_version}" withString:appVersion];
        NSString *msgFinall = [msg stringByReplacingOccurrencesOfString:@"{lastest_version}" withString:self.dataModel.version.lastest_version];
        _updateAlert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"版本升级", nil)
                                                           message:msgFinall
                                                    preferredStyle:UIAlertControllerStyleAlert];
        [_updateAlert addAction: [UIAlertAction actionWithTitle: NSLocalizedString(@"升级", nil) style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //去更新
            //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weakSelf.versionInfoItem.download_url]];
            
            
            UIApplication *application = [UIApplication sharedApplication];
            
            if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [application openURL:[NSURL URLWithString:weakSelf.dataModel.version.download_url] options:@{} completionHandler:nil];
            }else{
                [application openURL:[NSURL URLWithString:weakSelf.dataModel.version.download_url]];
            }
            
        }]];
        [_updateAlert addAction: [UIAlertAction actionWithTitle: NSLocalizedString(@"跳过", nil) style: UIAlertActionStyleCancel handler:nil]];
        
    }
    return _updateAlert;
    
}


@end
