//
//  UILabel+Extend.h
//  RabiBird
//
//  Created by 拉比鸟 on 16/12/20.
//  Copyright © 2016年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extend)
+ (UILabel *)lableWithText:(NSString *)text textColor:(UIColor *)color fontSize:(UIFont *)fontSize lableSize:(CGRect)rect  textAliment:(NSTextAlignment)alignment;
+ (UILabel *)lableWithText:(NSString *)text textColor:(UIColor *)color fontSize:(UIFont *)fontSize lableSize:(CGRect)rect  textAliment:(NSTextAlignment)alignment numberofLines:(NSInteger)lines;
@end
