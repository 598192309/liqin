//
//  LoanConfirmationContentView.h
//  RabiBird
//
//  Created by Lqq on 2018/7/24.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LoanConfirmationContentView : UIView

@property (nonatomic,assign) NSInteger row;//记录那个cell被点击了
/**下款按钮*/
@property (nonatomic, copy)void(^LoanConfirmationContentViewXiakuanBtnClickBlock)(UIButton *sender);
/**重新测算按钮*/
@property (nonatomic, copy)void(^LoanConfirmationContentViewCeSuanBtnClickBlock)();
/**服务合同点击*/
@property (nonatomic, copy)void(^LoanConfirmationContentViewDealBlock)(NSString *scope);

- (void)configUIWithItmeArr:(NSArray *)itemArr;
- (void)setYucelabelText:(NSString *)text;
@end
