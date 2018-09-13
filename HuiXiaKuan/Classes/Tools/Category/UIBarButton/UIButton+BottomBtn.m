//
//  UIButton+BottomBtn.m
//  xskj
//
//  Copyright © 2016年 lq. All rights reserved.
//

#import "UIButton+BottomBtn.h"

@implementation UIButton (BottomBtn)
+ (instancetype)bottomButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backGroundColor:(UIColor *)color Target:(id)target action:(SEL)action{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
//    CGFloat btnH = 49;
//    CGFloat btnW = LQScreemW;
//    btn.frame = CGRectMake(0, LQScreemH - btnH, btnW, btnH);
    btn.backgroundColor = color;
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void)setHighlighted:(BOOL)highlighted{

}

/** 创建普通按钮 */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backGroundColor:(UIColor *)color Target:(id)target action:(SEL)action rect:(CGRect)rect{
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = titleFont;
    btn.backgroundColor = color;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (rect.size.width == 0) {
        [btn sizeToFit];
    }else{
        btn.frame = rect;
    }
    return btn;
}

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backGroundColor:(UIColor *)color normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage Target:(id)target action:(SEL)action rect:(CGRect)rect{

    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = titleFont;
    btn.backgroundColor = color;
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (rect.size.width == 0) {
        [btn sizeToFit];
    }else{
        btn.frame = rect;
    }
    return btn;

}


@end
