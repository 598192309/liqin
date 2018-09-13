//
//  Network.h
//  KlineFight
//
//  Created by lq on 15/10/22.
//  Copyright © 2015年 Guangzhou ZhangAoBo Software Technology Co., Ltd. All rights reserved.
//  基于 AFNetworking 2.x~3.x with NSURLSession

#import <Foundation/Foundation.h>

#define NET [Network shareInstance]

/**
 *  一个网络请求任务
 */
@interface NetworkTask : NSObject
+ (nullable instancetype)netWorkWithSessionDataTask:(nullable NSURLSessionDataTask*)task;
- (void)cancel;
- (void)suspend;
- (void)resume;
@end



@interface Network : NSObject
#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000) || (defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED >= 1090) || TARGET_OS_WATCH

NS_ASSUME_NONNULL_BEGIN
@property(copy,nonatomic,nullable)NSString *accessToken;

+(instancetype)shareInstance;
//lqq
- (nullable NetworkTask *)GETWithParameters:(nullable id)parameters
                      success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                      failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error, id resultObject))failure;

- (nullable NetworkTask *)POSTWithParameters:(nullable id)parameters
                       success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error, id resultObject))failure;

//JK
- (nullable NetworkTask *)GET:(NSString *)URLString
                   parameters:(nullable id)parameters
                criticalValue:(nullable NSDictionary*)criticalValue
                      success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                      failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error, id resultObject))failure;

- (nullable NetworkTask *)POST:(NSString *)URLString
                    parameters:(nullable id)parameters
                 criticalValue:(nullable NSDictionary*)criticalValue
                       success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error, id resultObject))failure;

-(void)setCookie:(NSString*)key
           value:(NSString*)value;

-(void)switchHost:(nullable  NSString*)host;

-(void)setauthorization:(NSString *)authorization;
NS_ASSUME_NONNULL_END

#endif


@end
