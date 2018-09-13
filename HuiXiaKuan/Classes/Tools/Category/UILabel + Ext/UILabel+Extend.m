//
//  UILabel+Extend.m
//  RabiBird
//
//  Created by 拉比鸟 on 16/12/20.
//  Copyright © 2016年 Lq. All rights reserved.
//

#import "UILabel+Extend.h"

@implementation UILabel (Extend)
+ (UILabel *)lableWithText:(NSString *)text textColor:(UIColor *)color fontSize:(UIFont *)fontSize lableSize:(CGRect)rect  textAliment:(NSTextAlignment)alignment{
    UILabel *label = [[UILabel alloc] init];
    label.textColor =color;
    label.text = text;
    label.font = fontSize;
    label.textAlignment = alignment ? alignment : NSTextAlignmentLeft;
    if (rect.size.width > 0) {
        label.frame = rect;
    }else{
        [label sizeToFit];
    }
    
    return label;

}
+ (UILabel *)lableWithText:(NSString *)text textColor:(UIColor *)color fontSize:(UIFont *)fontSize lableSize:(CGRect)rect  textAliment:(NSTextAlignment)alignment numberofLines:(NSInteger)lines{
    UILabel *label = [[UILabel alloc] init];
    label.textColor =color;
    label.text = text;
    label.font = fontSize;
    label.textAlignment = alignment ? alignment : NSTextAlignmentLeft;
    if (rect.size.width > 0) {
        label.frame = rect;
    }else{
        [label sizeToFit];
    }
    label.numberOfLines = lines;
    return label;
    
    
}
@end
