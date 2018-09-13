//
//  CeSuanViewBottomCell.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/31.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDuQuestionItem;
/**
 从cell变成View了
 */
@interface CeSuanViewBottomCell : UIView
- (void)configUIWithItem:(EDuQuestionItem *)item index:(NSInteger)index finishBlock:(void(^)())finishBlock;
@property (nonatomic, copy)void(^ceSuanViewBottomCellClickBlock)(NSInteger index);

@end
