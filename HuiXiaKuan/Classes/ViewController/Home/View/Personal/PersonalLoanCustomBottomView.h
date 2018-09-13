//
//  PersonalLoanCustomBottomView.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/7.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoanBuildInfoItem;
@interface PersonalLoanCustomBottomView : UIView
- (void)configUIWithItem:(LoanBuildInfoItem *)item finishBlock:(void(^)())finishBlock;
@property (nonatomic, copy)void(^personalLoanCustomBottomViewConfirmBtnClickBlock)(UIButton *sender ,NSString *loan_platform);
@end
