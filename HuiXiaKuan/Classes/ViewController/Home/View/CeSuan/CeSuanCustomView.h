//
//  CeSuanCustomView.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/31.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDuThemeItem;
@interface CeSuanCustomView : UIView
/**点击cesuan按钮*/
@property (nonatomic, copy)void(^ceSuanCustomViewCesuanBtnClickBlock)(UIButton *sender,NSDictionary *dict);
- (void)configUIWithItem:(EDuThemeItem *)item eduQuestionList:(NSArray *)eduQuestionList finishBlock:(void(^)())finishBlock;

@property (nonatomic, copy)void(^CeSuanCustomViewChangeHeightBlock)();

- (void)setEduLable:(NSInteger)count;
@end
