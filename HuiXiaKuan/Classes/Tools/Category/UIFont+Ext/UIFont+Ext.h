//
//  UIFont+Ext.h
//  IUang
//
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Ext)

+ (UIFont *)systemAdaptorFontOfSize:(CGFloat)size;

+ (UIFont *)boldSystemAdaptorFontOfSize:(CGFloat)size;

+ (UIFont *)fontWithName:(NSString *)fontName systemAdaptorFontOfSize:(CGFloat)fontSize;


@end
