//
//  XiakuanCommissionCustomView.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/11.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XiakuanCommissionItem;
@interface XiakuanCommissionCustomView : UIView
/**点击确认按钮*/
@property (nonatomic, copy)void(^xiakuanCommissionCustomViewConfirmBtnClickBlock)(UIButton *sender,NSDictionary *dict);
- (void)configUIWithItem:(XiakuanCommissionItem *)item finishBlock:(void(^)())finishBlock;
@end
