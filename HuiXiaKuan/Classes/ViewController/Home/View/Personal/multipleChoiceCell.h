//
//  multipleChoiceCell.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/6.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CreditInfoItem;
@interface multipleChoiceCell : UITableViewCell
@property (nonatomic,strong)NSMutableArray *optionsArr;

- (void)configUIWithItem:(CreditInfoItem *)item  finishBlock:(void(^)())finishBlock;
@property (nonatomic, copy)void(^multipleChoiceCellChooseBlock)(NSInteger seletedOptionIndex,NSInteger row);

@end
