//
//  BottomAlertView.h
//  RabiBird
//
//  Created by Lqq on 2018/7/25.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomAlertView : UIView
/**关闭点击*/
@property (nonatomic, copy)void(^bottomAlertViewCloseBlock)();
@property (nonatomic,strong)NSString *htmlStr;
@property (nonatomic,strong)NSString *titleStr;

@end
