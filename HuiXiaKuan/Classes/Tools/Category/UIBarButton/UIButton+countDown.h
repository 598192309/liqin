//
//  UIButton+countDown.h
//  LiquoriceDoctorProject
//
//  Created by HenryCheng on 15/12/4.
//  Copyright © 2015年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (countDown)
//@property(nonatomic,strong)dispatch_source_t atimer;

/**
 *  倒计时按钮
 *
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title
 *  @param subTitle 倒计时中的子名字，如时、分
 *  @param mColor   还没倒计时的颜色
 *  @param color    倒计时中的颜色
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

/**
 *  倒计时按钮
 *
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title
 *  @param subTitle 倒计时中的子名字，如时、分
 *  @param cColor   倒计时的文字的颜色

 *  @param mColor   还没倒计时的按钮颜色
 *  @param color    倒计时中的按钮颜色
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title titleColor:(UIColor *)tColor countDownTitle:(NSString *)subTitle countDownTitleColor:(UIColor *)cColor mainColor:(UIColor *)mColor countColor:(UIColor *)color;


- (void)countBtnReset;
@end
