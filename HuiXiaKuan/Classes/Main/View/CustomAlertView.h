//
//  CustomAlertView.h
//  RabiBird
//
//  Created by 拉比鸟 on 17/1/4.
//  Copyright © 2017年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView
@property(nonatomic,copy)void(^CustomAlertViewBlock)(NSInteger index,NSString *str);
+ (instancetype)instanceView;
-(void)refreshUIWithTitle:(NSString *)title subTitle:(NSString *)subTitle firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle singleBtnHidden:(BOOL)hidden singleBtnTitle:(NSString*)singleBtnTitle;

-(void)refreshUIWithTitle:(NSString *)title  subTitle:(NSString *)subTitle firstBtnTitle:(NSString *)firstBtnTitle firstBtnTitleColor:(UIColor *)firstBtnTitleColor secBtnTitle:(NSString *)secBtnTitle secBtnTitleColor:(UIColor *)secBtnTitleColor singleBtnHidden:(BOOL)hidden singleBtnTitle:(NSString*)singleBtnTitle singleBtnTitleColor:(UIColor *)singleBtnTitleColor;
-(void)refreshUIWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont*)titleFont  titleAliment:(NSTextAlignment)titleAliment subTitle:(NSString *)subTitle  subTitleColor:(UIColor *)subTitleColor subTitleFont:(UIFont*)subTitleFont  subTitleAliment:(NSTextAlignment)subTitleAliment firstBtnTitle:(NSString *)firstBtnTitle firstBtnTitleColor:(UIColor *)firstBtnTitleColor secBtnTitle:(NSString *)secBtnTitle secBtnTitleColor:(UIColor *)secBtnTitleColor singleBtnHidden:(BOOL)hidden singleBtnTitle:(NSString*)singleBtnTitle singleBtnTitleColor:(UIColor *)singleBtnTitleColor;

-(void)refreshUIWithAttributeTitle:(NSAttributedString *)attributeTitle titleColor:(UIColor *)titleColor titleFont:(UIFont*)titleFont  titleAliment:(NSTextAlignment)titleAliment attributeSubTitle:(NSAttributedString *)attributeSubTitle  subTitleColor:(UIColor *)subTitleColor subTitleFont:(UIFont*)subTitleFont  subTitleAliment:(NSTextAlignment)subTitleAliment firstBtnTitle:(NSString *)firstBtnTitle firstBtnTitleColor:(UIColor *)firstBtnTitleColor secBtnTitle:(NSString *)secBtnTitle secBtnTitleColor:(UIColor *)secBtnTitleColor singleBtnHidden:(BOOL)hidden singleBtnTitle:(NSString*)singleBtnTitle singleBtnTitleColor:(UIColor *)singleBtnTitleColor;

@property (nonatomic, strong)UIView *customCoverView;

@end
