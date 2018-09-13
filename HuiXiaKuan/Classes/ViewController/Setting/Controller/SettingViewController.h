//
//  SettingViewController.h
//  RabiBird
//
//  Created by Lqq on 16/8/12.
//  Copyright © 2016年 Lq. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingViewController : BaseViewController
@property(nonatomic,assign)BOOL shiming;
@property(nonatomic,strong)NSString *realName;//实名  姓名
@property(nonatomic,strong)NSString *idno;//实名  身份证


+ (instancetype)instanceController;

@end
