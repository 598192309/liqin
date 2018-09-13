//
//  OptionSelectViewTool.h
//  IUang
//  弹框选择器
//  Created by jayden on 2018/5/11.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OptionSelectViewBlcok) (NSString * _Nullable title,NSInteger row);
typedef void(^OptionSelectViewHidenViewBlcok) (void);


@interface OptionSelectViewTool : UIView
@property (nonatomic,copy)OptionSelectViewBlcok _Nullable optionSelectViewCallBackBlock;
@property (nonatomic,copy)OptionSelectViewHidenViewBlcok _Nullable optionSelectViewHidenViewBlcok;

+(void)viewShowWhiteTitleArray:(NSArray*_Nullable)array block:(nullable void (^)(NSString * _Nullable title,NSInteger row))block viewHiden:(nullable void(^)(void))hidenBlock;

@end
