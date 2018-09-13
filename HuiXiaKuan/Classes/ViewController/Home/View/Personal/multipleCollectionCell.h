//
//  multipleCollectionCell.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/10.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDuQuestionItem;
/**cell 改成view*/
@interface multipleCollectionCell : UIView
@property (nonatomic, copy)void(^multipleCollectionCellClickBlock)(NSInteger index);
- (void)configUIWithItem:(EDuQuestionItem *)item index:(NSInteger)index finishBlock:(void(^)())finishBlock;
@end
