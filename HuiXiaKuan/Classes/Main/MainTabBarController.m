//
//  MainTabBarController.m
//  IUang
//
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "MainTabBarController.h"
#import "SDImageCache.h"
#import "BaseNavigationController.h"

#import "HomeViewController.h"
#import "MineViewController.h"
#import "LorginViewController.h"
#import "CustomAlertView.h"
#import "SettingViewController.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>
@property(nonatomic,strong)CustomAlertView *infoAlert;//弹窗

@end

@implementation MainTabBarController




// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *vc1 = [[HomeViewController alloc] init];
    [self addChildViewController:vc1 withImageName:@"home" selectedImageName:@"home" withTittle:lqLocalized(@"首页",nil)];
    
    MineViewController *vc2 = [[MineViewController alloc] init];
    [self addChildViewController:vc2 withImageName:@"user" selectedImageName:@"user" withTittle:lqLocalized(@"我的",nil)];
    
    SettingViewController *vc3 = [[SettingViewController alloc] init];
    [self addChildViewController:vc3 withImageName:@"setup" selectedImageName:@"setup" withTittle:lqStrings(@"设置")];
    
    [self setupBasic];
    self.delegate = self;
    
    //监听 多人登录 重新登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(relorgin:) name:KNotification_ReLorigin object:nil ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(relorginSuccessd:) name:KNotification_ReLoriginSuccess object:nil ];

}



-(void)setupBasic {
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    [self becomeFirstResponder];

}

-(void)dealloc {
    
}

#pragma mark - act
- (void)relorgin:(NSNotification *)notification{
//    UITabBarController *rootVC  = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    UINavigationController *mineVC = [rootVC.childViewControllers safeObjectAtIndex:rootVC.selectedIndex];
//    UIViewController *vc = mineVC.viewControllers.lastObject;
//    
//    NSDictionary *dict=[notification userInfo];
//    
//    
//    if (![[UIViewController topViewController] isKindOfClass:[ReLorginViewController class]] ) {
//        ReLorginViewController *relorginVc = [[ReLorginViewController alloc] init];
//        relorginVc.alertMsg = [dict safeObjectForKey:@"msg"];
//        [vc.navigationController pushViewController:relorginVc animated:NO];
//
//    }
    NSDictionary *dict=[notification userInfo];
    NSAttributedString *attr = [NSString attributeStringWithParagraphStyleLineSpace:Adaptor_Value(10) withString:[dict safeObjectForKey:@"msg"] Alignment:NSTextAlignmentLeft];
    [self.infoAlert refreshUIWithAttributeTitle:nil titleColor:[UIColor colorWithHexString:@"#222020"] titleFont:RegularFONT(17) titleAliment:NSTextAlignmentLeft attributeSubTitle:attr subTitleColor:[UIColor colorWithHexString:@"#303451"] subTitleFont:RegularFONT(15) subTitleAliment:NSTextAlignmentLeft firstBtnTitle:lqLocalized(@"重置密码", nil) firstBtnTitleColor:[UIColor colorWithHexString:@"#ff8183"] secBtnTitle:lqLocalized(@"立即登录", nil) secBtnTitleColor:[UIColor colorWithHexString:@"#222020"] singleBtnHidden:YES singleBtnTitle:@"" singleBtnTitleColor:nil];
//    [[UIApplication sharedApplication].keyWindow addSubview:self.infoAlert];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.infoAlert];

}
- (void)relorginSuccessd:(NSNotification *)notification{
    if (_infoAlert) {
        [self.infoAlert removeFromSuperview];
        self.infoAlert = nil;
    }
}
- (void)addChildViewController:(UIViewController *)controller withImageName:(NSString *)imageName selectedImageName:(NSString *)selectImageName withTittle:(NSString *)tittle{
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
    
    UIImage * image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [nav.tabBarItem setImage:image];
    [nav.tabBarItem setSelectedImage:selectImage];

    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:TitleBlackColor} forState:UIControlStateSelected];

    
    nav.tabBarItem.title = tittle;
    //        controller.navigationItem.title = tittle;
    //    controller.title = tittle;//这句代码相当于上面两句代码
    //    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    
    [self addChildViewController:nav];
}
#pragma mark <UITabBarControllerDelegate>
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == 1 && !RI.is_logined) {
        [AppDelegate presentLoginViewContrller];
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
}
#pragma mark - lazy
- (CustomAlertView *)infoAlert{
    if (_infoAlert == nil) {
        _infoAlert = [CustomAlertView instanceView];
        
        _infoAlert.lq_y = 0;
        _infoAlert.lq_x = 0;
        _infoAlert.lq_width = Main_Screen_Width;
        _infoAlert.lq_height = Main_Screen_Height;
        __weak __typeof(self) weakSelf = self;
        UITabBarController *rootVC  = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        NSInteger a = rootVC.selectedIndex;
        UINavigationController *mineVC = [rootVC.childViewControllers safeObjectAtIndex:rootVC.selectedIndex];
        UIViewController *vc = mineVC.viewControllers.lastObject;
    
        _infoAlert.CustomAlertViewBlock = ^(NSInteger index,NSString *str){
            if (index == 1) {//重置密码
                //跳转到忘记密码界面
//                LorginForgetPwdViewController *forgetVC = [[LorginForgetPwdViewController alloc] init];
//                forgetVC.relorgin = YES;
//                AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
//                BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:forgetVC];
//                [del.window.rootViewController presentViewController:nav animated:YES completion:nil];

            }else if(index == 2){//立即登录
//                AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
//
//                LorginViewController *lorginVC = [[LorginViewController alloc] init];
//                //                lorginVC.relorgin = YES;
//                BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:lorginVC];
//                [del.window.rootViewController presentViewController:nav animated:YES completion:nil];
                
                
            }else if(index == 4){//取消
//                [weakSelf.infoAlert removeFromSuperview];
                
            }
        };
    }
    
    return _infoAlert;
    
}
@end
