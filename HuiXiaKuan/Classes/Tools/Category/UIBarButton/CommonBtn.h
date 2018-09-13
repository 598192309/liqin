//
//  CommonBtn.h
//  IUang
//
//  Created by Lqq on 2018/4/20.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonBtn : UIButton
@property (nonatomic,assign)BOOL btnEnable;
@property (nonatomic,assign)BOOL btnSeleted;

@property (nonatomic, copy)void(^CommonBtnEndLongPressBlock)(UIButton *sender);

@end
