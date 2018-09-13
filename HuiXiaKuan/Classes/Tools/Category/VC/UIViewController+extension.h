//
//  UIViewController+extension.h
//  RabiBird
//
//  Created by 拉比鸟 on 17/3/15.
//  Copyright © 2017年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (extension)
+ (UIViewController*)topViewController;
+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController;

+ (UIViewController*)secondViewController;

@end
