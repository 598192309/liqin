//
//  UIButton+BottomBtn.h
//  xskj
//
//  Copyright © 2016年 lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BottomBtn)
+ (instancetype)bottomButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backGroundColor:(UIColor *)color Target:(id)target action:(SEL)action;
/** 创建普通按钮 */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backGroundColor:(UIColor *)color Target:(id)target action:(SEL)action rect:(CGRect)rect;

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backGroundColor:(UIColor *)color normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage Target:(id)target action:(SEL)action rect:(CGRect)rect;
@end
