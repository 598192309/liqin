//
//  MineLoanRecordCell.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/31.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoanRecordInfoItem;
@interface MineLoanRecordCell : UITableViewCell
- (void)configUIWithItem:(LoanRecordInfoItem *)item;
/** 查看协议label 点击*/
@property (nonatomic, copy)void(^mineLoanRecordCellCheckContractBlock)(UILabel *tapLable,NSDictionary *dict);

@end
