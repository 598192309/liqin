//
//  CustomTextfieldView.h
//  IUang
//
//  Created by Lqq on 2018/4/27.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CustomPasswordViewBlock)(NSString *password);

@interface CustomPasswordView : UIView
@property (nonatomic,copy)CustomPasswordViewBlock completionBlock;
/** 更新输入框数据 */
- (void)updateLabelBoxWithText:(NSString *)text;

/** 抖动输入框 */
- (void)startShakeViewAnimation;

- (void)didInputPasswordError;

@property (nonatomic,assign)CGFloat space;//两个label之间的距离
@end


@protocol CustomTextfieldViewDelegate <NSObject>

- (void)didPasswordInputFinished:(NSString *)password;
- (void)didAuthBtnClick;
- (void)didClose;

@end

@interface CustomTextfieldView : UIView
@property (nonatomic, weak) id <CustomTextfieldViewDelegate> delegate;

- (void)showPayPopView;
- (void)hidePayPopView;
- (void)didInputPayPasswordError;
- (void)remove;

@property (nonatomic,strong)NSString *mobile;
/**倒计时*/

- (void)countdowm;

@end
