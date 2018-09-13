//
//  ProgressView.h
//  IUang
//
//  Created by Lqq on 2018/4/19.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView
/**
 进度值
 */
@property (nonatomic,copy) NSString *progressValue;

/**
 进度条的颜色
 */
@property (nonatomic,strong) UIColor *progressColor;

/**
 进度条的背景色
 */
@property (nonatomic,strong) UIColor *bottomColor;

/**
 进度条的速度
 */
@property (nonatomic,assign) float time;

/**
 总共数额
 */
@property (nonatomic,assign) NSInteger totalNum;

/**
 实际到达数额
 */
@property (nonatomic,assign) NSInteger progressNum;

/**恢复之前初始状态*/
- (void)recover;
/**

 */
@property (nonatomic,assign) float widthW;

@end
