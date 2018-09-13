//
//  MineCustomView.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/30.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AccountHomeItem;
@interface MineCustomView : UIView
- (void)configUIWithItem:(AccountHomeItem *)item finishi:(void(^)())finishBlock;
/**点击确认按钮*/
@property (nonatomic, copy)void(^mineCustomViewConfirmBtnClickBlock)(UIButton *sender,NSDictionary *dict);
/** 查看协议label 点击*/
@property (nonatomic, copy)void(^mineCustomViewCheckContractBlock)(UILabel *tapLable,NSDictionary *dict);
/** 完善个人信息label 点击*/
@property (nonatomic, copy)void(^mineCustomViewCheckConsummateInfoBlock)(UILabel *tapLable,NSDictionary *dict);

@property (nonatomic,strong)UILabel *accountLabel;

@end
