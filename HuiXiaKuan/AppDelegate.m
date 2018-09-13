//
//  AppDelegate.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/22.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchingViewController.h"
#import "LorginViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "FMDeviceManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.rootViewController = self.rootTabbar = [[MainTabBarController alloc]init];
    self.rootTabbar = [[MainTabBarController alloc]init];
    self.window.rootViewController = [LaunchingViewController new];
    [self.window makeKeyAndVisible];
    
    //同盾
    [self FMDeviceManagerConfig];
    
    //IQKeyboardManager
    [self IQKeyboardManagerConfig];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
+ (AppDelegate* )shareAppDelegate {
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}
#pragma mark - 自定义
-(void)FMDeviceManagerConfig{
    //同盾指纹
    // 获取设备管理器实例
    FMDeviceManager_t *manager = [FMDeviceManager sharedManager];
    
    // 准备SDK初始化参数
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    
    /*
     * SDK具有防调试功能，当使用xcode运行时(开发测试阶段),请取消下面代码注释，
     * 开启调试模式,否则使用xcode运行会闪退。上架打包的时候需要删除或者注释掉这
     * 行代码,如果检测到调试行为就会触发crash,起到对APP的保护作用
     */
    
    //#ifdef DEBUG
    //上线Appstore的版本，请记得删除此行，否则将失去防调试防护功能！
    [options setValue:@"allowd" forKey:@"allowd"];  // TODO
    // 指定对接同盾的测试环境，正式上线时，请删除或者注释掉此行代码，切换到同盾生产环境
    [options setValue:@"sandbox" forKey:@"env"]; // TODO
    //#else
    //#endif
    // 此处替换为您的合作方标识
    [options setValue:@"rabibird" forKey:@"partner"];
    
    // 使用上述参数进行SDK初始化
    manager->initWithOptions(options);
    
}

-(void)IQKeyboardManagerConfig{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字
    keyboardManager.placeholderFont = RegularFONT(15); // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}
+ (void)presentLoginViewContrller
{
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    BaseNavigationController*nav = [[BaseNavigationController alloc] initWithRootViewController:[[LorginViewController alloc] init]];
    
    [del.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

@end
