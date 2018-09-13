//
//  UIBarButtonItem+Button.h
//  LQ 0120 BUDEJIE
//
//  Created by Lqq on 16/1/20.
//  Copyright © 2016年 Lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Button)
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image higlImage:(UIImage *)highImage target:target action:(SEL)action;

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:target action:(SEL)action;

+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:target action:(SEL)action;

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title  target:target action:(SEL)action;
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title  titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont target:target action:(SEL)action;
@end
