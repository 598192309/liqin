//
//  UIFont+Ext.m
//  IUang
//
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "UIFont+Ext.h"

@implementation UIFont (Ext)
+ (UIFont *)systemAdaptorFontOfSize:(CGFloat)size {
    return [UIFont systemFontOfSize:size*([self fontMuit])];
}

+ (UIFont *)boldSystemAdaptorFontOfSize:(CGFloat)size {
    return [UIFont boldSystemFontOfSize:size*[self fontMuit]];
}

+ (UIFont *)fontWithName:(NSString *)fontName systemAdaptorFontOfSize:(CGFloat)fontSize {
    return [self fontWithName:fontName size:fontSize*[self fontMuit]];
}

+ (CGFloat)fontMuit {
    CGFloat muti = 0.9f;
    
    if(is4Inch_Laters) {
        muti = 1.0f;
    }
    else if (is5Inch_Laters) {
        muti = 1.05f;
    }
    
    return muti;
}
@end
