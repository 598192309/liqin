//
//  PersonalLoanCustomView.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/5.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoanBuildInfoItem;
@interface PersonalLoanCustomView : UIView
- (void)configUIWithItem:(LoanBuildInfoItem *)item finishBlock:(void(^)())finishBlock;
@property (nonatomic, strong)NSArray *provinceArr;
@property (nonatomic, strong)NSArray *cityArr;
@property (nonatomic, copy)void(^personalLoanCustomViewCityClickBlock)(UIButton *sender ,NSString *province);
- (void)cityShow;
@property (nonatomic, strong)NSDictionary *infoDict;

@end
