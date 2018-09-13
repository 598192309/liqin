//
//  HomeCustomView.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/27.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeDataItem,CaseItem;
@interface HomeCustomView : UIView
- (void)configUIWithItem:(HomeDataItem *)item finishBlock:(void(^)())finishBlock;
- (void)setAnimationWithItemArr:(NSArray *)itemArr;
/**立即下款按钮点击*/
@property (nonatomic, copy)void(^homeCustomViewConfirmBtnClickBlock)(UIButton *sender,NSDictionary *dict);
/**获取短信验证码*/

@property (nonatomic, copy)void(^homeCustomViewCodeBtnClickBlock)(UIButton *sender,NSDictionary *dict);
/**图形验证码点击*/

@property (nonatomic, copy)void(^homeCustomViewTuxingImageVTapBlock)(UIImageView *imageV,NSDictionary *dict);
/**重新获取动画数组*/
@property (nonatomic, copy)void(^homeCustomViewReloadAnimateBlock)();


- (void)setCodeTFBackHidden:(BOOL)hidden;
- (void)refreshUIWithIsLorgin:(BOOL)islogin finishBlock:(void(^)())finishBlock;
@end
