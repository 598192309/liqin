//
//  BaseViewController.m
//  IUang
//
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


//右滑返回功能，默认开启（YES）
- (BOOL)gestureRecognizerShouldBegin{
    return YES;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    if([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
    {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _notFirstAppear = YES;
    
}

-(void)showErrorHUD:(id) resultObject{
    [self removeHUD];
    NSString * msg = [resultObject safeObjectForKey:@"msg"];
    if (!msg){
        msg = lqStrings(@"Silakan coba lagi");
    }
    [self showHUD:msg];
}

- (void)showHUDToViewMessage:(NSString *)msg{
    //防止重复点击 hud还没消失
    [self removeHUD];
    if (!self.hud) {
        self.hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //        self.hud.dimBackground = YES;
        if (msg==nil||[msg isEqualToString:@""]) {
            
        }else{
            self.hud.label.text= msg;
        }
        [self configurationHUD:self.hud];
    }
}
- (void)showHUDToWindowMessage:(NSString *)msg{
    if (!self.hud) {
        self.hud=[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        //        self.hud.dimBackground = YES;
        if (msg==nil||[msg isEqualToString:@""]) {
            
        }else{
            self.hud.label.text= msg;
        }
        [self configurationHUD:self.hud];
    }
}
-(void)showHUD:(NSString*)msg{
    [self removeHUD];
    if (msg.length == 0) {
        return;
    }
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.label.text = msg;
    self.hud.mode = MBProgressHUDModeText;
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.userInteractionEnabled = NO;
    [self configurationHUD:self.hud];
    [self.hud hideAnimated:YES afterDelay:1.5];
}
-(void)showHUDToWindow:(NSString*)msg{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[AppDelegate shareAppDelegate].rootTabbar.view animated:YES];
    hud.label.text = msg;
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    [self configurationHUD:hud];
    [hud hideAnimated:YES afterDelay:1.5];
}
- (void)removeHUD{
    if (self.hud) {
        [self.hud removeFromSuperview];
        self.hud=nil;
    }
}
-(void)configurationHUD:(MBProgressHUD*)hud{
    hud.label.font = RegularFONT(12);
    hud.label.textColor = RGBCOLOR(255, 255, 255);
    hud.label.numberOfLines = 0;
    hud.bezelView.color = RGBACOLOR(34, 32, 32, 0.9);
}


-(NSString *)backItemImageName{
    return @"back";
}

- (BOOL)shouldAutorotate{
    //是否允许转屏
    BOOL result = [super shouldAutorotate];
    return result;
}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    UIInterfaceOrientationMask result = [super supportedInterfaceOrientations];
//    //viewController所支持的全部旋转方向
//    return result;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    UIInterfaceOrientation result = [super preferredInterfaceOrientationForPresentation];
//    //viewController初始显示的方向
//    return result;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    [self.view endEditing:YES];
//}

//添加导航栏
-(void)addNavigationView{
    __weak __typeof(self) weakSelf = self;
    [self.view addSubview:self.navigationView];
    [self.navigationView addSubview:self.navigationBackButton];
//    [self.navigationView addSubview:self.navigationbackgroundLine];
    [self.navigationView addSubview:self.navigationTextLabel];
    
    [self.navigationView addSubview:self.navigationRightBtn];
    [self.navigationView addSubview:self.navigationRightSecBtn];

    
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo( 0);
        make.height.mas_equalTo(NavMaxY);
    }];
    [self.navigationBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.navigationView).with.offset(Adaptor_Value(10));
        make.top.mas_equalTo(weakSelf.navigationView).with.offset(IS_IPHONEX ? 35 : 20);
        make.size.mas_equalTo(CGSizeMake(Adaptor_Value(40), Adaptor_Value(40)));
    }];
//    [self.navigationbackgroundLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_equalTo(self.navigationView);
//        make.height.mas_equalTo(1);
//    }];
    [self.navigationTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.navigationView);
        make.centerY.mas_equalTo(weakSelf.navigationBackButton);
    }];
    
    [self.navigationRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.navigationView).with.offset(-Adaptor_Value(10));
        make.centerY.mas_equalTo(weakSelf.navigationTextLabel);

    }];
    [self.navigationRightSecBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.navigationRightBtn);
        make.right.mas_equalTo(weakSelf.navigationRightBtn.mas_left).offset(-Adaptor_Value(20));
    }];

}
-(void)backClick:(UIButton*)button{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)navigationRightBtnClick:(UIButton*)button{
    if ([[button titleForState:UIControlStateNormal] isEqualToString:lqLocalized(@"联系客服", nil)]) {
        if ([self canOpenQQ]) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",RI.customer_qq]];
            UIApplication *application = [UIApplication sharedApplication];
            if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [application openURL:url options:@{} completionHandler:nil];
            }else{
                [application openURL:url];
            }
        }else{
            [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"未安装QQ", nil)];
        }
    }
}
- (BOOL)canOpenQQ{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
}
-(void)navigationRightSecBtnClick:(UIButton*)button{
}
-(UIView *)navigationView{
    if (!_navigationView) {
        _navigationView = [UIView new];
        _navigationView.backgroundColor = [UIColor whiteColor];
    }
    return _navigationView;
}
-(UIButton *)navigationBackButton{
    if (!_navigationBackButton) {
        _navigationBackButton = [UIButton new];
        [_navigationBackButton setImage:[UIImage imageNamed:self.backItemImageName] forState:UIControlStateNormal];
        [_navigationBackButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navigationBackButton;
}
-(UIView *)navigationbackgroundLine{
    if (!_navigationbackgroundLine) {
        _navigationbackgroundLine = [UIView new];
        _navigationbackgroundLine.backgroundColor = HexRGB(0xECECEC);
    }
    return _navigationbackgroundLine;
}
-(UILabel *)navigationTextLabel{
    if (!_navigationTextLabel) {
        _navigationTextLabel = [UILabel new];
        _navigationTextLabel.font = SemiboldFONT(19);
    }
    return _navigationTextLabel;
}

-(UIButton *)navigationRightBtn{
    if (!_navigationRightBtn) {
        _navigationRightBtn = [UIButton new];
        [_navigationRightBtn addTarget:self action:@selector(navigationRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationRightBtn setTitleColor:TitleBlackColor forState:UIControlStateNormal];
        _navigationRightBtn.titleLabel.font = RegularFONT(14);


    }
    return _navigationRightBtn;
}
-(UIButton *)navigationRightSecBtn{
    if (!_navigationRightSecBtn) {
        _navigationRightSecBtn = [UIButton new];
        [_navigationRightSecBtn addTarget:self action:@selector(navigationRightSecBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationRightSecBtn setTitleColor:TitleBlackColor forState:UIControlStateNormal];
        _navigationRightSecBtn.titleLabel.font = RegularFONT(14);
    }
    return _navigationRightSecBtn;
}


@end
