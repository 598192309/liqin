//
//  LoanConfirmationExtendView.h
//  RabiBird
//
//  Created by Lqq on 2018/7/23.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PayInfoItem;
@interface LoanConfirmationExtendView : UIView
@property (nonatomic, copy)void(^loanConfirmationExtendViewChangeHeightBlock)(CGFloat height);
- (void)configUIWithItme:(PayInfoItem *)item;
- (void)setAnimationWithItemArr:(NSArray *)itemArr;

@end
