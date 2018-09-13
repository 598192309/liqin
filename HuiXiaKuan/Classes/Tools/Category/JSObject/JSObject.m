//
//  JSObject.m
//  RabiBird
//
//  Created by 拉比鸟 on 17/3/22.
//  Copyright © 2017年 Lq. All rights reserved.
//  为了js交互的 中间对象  避免循环引用

#import "JSObject.h"

@implementation JSObject
- (void)mobileCallBack:(BOOL)para{
    if (_mobileCallBackBlock) {
        _mobileCallBackBlock(para);
    }
}

- (void)taobaoCallBack:(BOOL)para
{
    if (_taobaoCallBack) {
        _taobaoCallBack(para);
    }
}
-(void)shebaoCallBack:(BOOL)para{
    if (_shebaoCallBack) {
        _shebaoCallBack(para);
    }
}
- (void)gojekCallBack:(NSString *_Nullable)para
{
    if (_gojekCallBackBlock) {
        _gojekCallBackBlock(para);
    }
}
@end
