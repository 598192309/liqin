//
//  UIViewController+extension.m
//  RabiBird
//
//  Created by 拉比鸟 on 17/3/15.
//  Copyright © 2017年 Lq. All rights reserved.
//

#import "UIViewController+extension.h"

@implementation UIViewController (extension)
/**
 获取最顶层的视图控制器
 不论中间采用了 push->push->present还是present->push->present,或是其它交互
 */
+ (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}
+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* nav = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:nav.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

+ (UIViewController*)secondViewController{
    return [self secondViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];

}

+ (UIViewController*)secondViewControllerWithRootViewController:(UIViewController*)rootViewController  {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
        MainTabBarController *rootVC =(MainTabBarController *)del.window.rootViewController;
        UINavigationController *firstTabNav = [rootVC childViewControllers][rootVC.selectedIndex];
        UIViewController *vc = [firstTabNav.childViewControllers safeObjectAtIndex:(firstTabNav.childViewControllers.count -2)];
        return vc;
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* nav = (UINavigationController*)rootViewController;
        UIViewController *vc = [nav.childViewControllers safeObjectAtIndex:nav.childViewControllers.count - 2];
        return [self topViewControllerWithRootViewController:vc];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

@end
