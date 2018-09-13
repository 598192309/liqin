//
//  NormalOneTitleCell.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/5.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoanPlatformItem;
@interface NormalOneTitleCell : UICollectionViewCell
- (void)configUIWithItem:(LoanPlatformItem *)item finishBlock:(void(^)())finishBlock;

@end
