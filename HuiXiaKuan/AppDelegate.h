//
//  AppDelegate.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/22.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainTabBarController *rootTabbar;


+ (AppDelegate* )shareAppDelegate;

+ (void)presentLoginViewContrller;
@end

