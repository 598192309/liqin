//
//  LorginApi.m
//  IUang
//
//  Created by Lqq on 2018/4/25.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "LorginApi.h"
#import "LorginModel.h"

@implementation LorginApi
/**  登录  */
+ (NetworkTask *)loginWithMobile:(NSString *)mobile code:(NSString *)code success:(void(^)(LorginModel *loginItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/user/login" parameters:@{@"mobile":SAFE_NIL_STRING(mobile),@"code":SAFE_NIL_STRING(code)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        LorginModel *loginItem = [LorginModel mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        RI.is_logined = YES;
        if (successBlock) {
            successBlock(loginItem,msg);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}
/**获取登录验证码*/
+(NetworkTask *)requsteLoginCodeWithMoblie:(NSString *)mobile captcha:(NSString *)captcha success:(void(^)(NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/verifycode" parameters:@{@"mobile":SAFE_NIL_STRING(mobile),@"captcha":SAFE_NIL_STRING(captcha),@"from":@"ios"} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
    
}

/**  退出登录  */

+ (NetworkTask *)loginOutSuccess:(void(^)(NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/user/logout" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        RI.is_logined = NO;
        //更换账号 还原一下测试额度
        RI.quota = 0;
        [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:KQuota];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}


@end
