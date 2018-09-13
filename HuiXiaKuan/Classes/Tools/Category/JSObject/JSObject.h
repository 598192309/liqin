//
//  JSObject.h
//  RabiBird
//
//  Created by 拉比鸟 on 17/3/22.
//  Copyright © 2017年 Lq. All rights reserved.
//  为了js交互的 中间对象  避免循环引用

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol JSObjectProtocol <JSExport>
- (void)mobileCallBack:(BOOL)para;
- (void)taobaoCallBack:(BOOL)para;
- (void)shebaoCallBack:(BOOL)para;
- (void)gojekCallBack:(NSString *_Nullable)para;

@end


@interface JSObject : NSObject <JSObjectProtocol>
@property (nullable , copy) void(^mobileCallBackBlock)(BOOL para);
@property (nullable , copy) void(^taobaoCallBack)(BOOL para);
@property (nullable , copy) void(^shebaoCallBack)(BOOL para);
@property (nullable , copy) void(^gojekCallBackBlock)(NSString * _Nullable para);

@end
