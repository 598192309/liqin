//
//  SettingApi.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/4.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "SettingApi.h"
#import "Setting.h"
@implementation SettingApi
/**关于我们 */
+ (NetworkTask *)requestAboutInfoSuccess:(void(^)(AboutItem *aboutItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/article/about" parameters:nil  criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        AboutItem *aboutItem = [AboutItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(aboutItem,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}
@end
