//
//  LoanConfirmationContentCell.h
//  RabiBird
//
//  Created by Lqq on 2018/7/24.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoanTypeItem;
@interface LoanConfirmationContentCell : UICollectionViewCell
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) BOOL isDid;
//@property(nonatomic,assign)CGFloat cellHeight;
- (void)configUIWithItme:(LoanTypeItem *)item;

@end
