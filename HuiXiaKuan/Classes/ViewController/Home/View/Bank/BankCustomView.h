//
//  BankCustomView.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/4.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankCustomView : UIView
@property (nonatomic, copy)void(^bankCustomViewConfirmBtnClickBlock)(UIButton *sender,NSDictionary *dict);
@property (nonatomic,strong)NSString *moneyStr;
@end
