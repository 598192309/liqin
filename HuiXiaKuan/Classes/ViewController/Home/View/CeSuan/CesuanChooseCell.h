//
//  CesuanChooseCell.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/3.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CesuanChooseCell : UICollectionViewCell
- (void)configUIWithStr:(NSString *)str  selected:(BOOL)selected finishBlock:(void(^)())finishBlock;
@end
