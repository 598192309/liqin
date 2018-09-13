//
//  BaseApi.m
//  IUang
//
//  Created by jayden on 2018/4/24.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "BaseApi.h"

@implementation BaseApi
+(NetworkTask *)requestWithParam:(NSDictionary *)param
{
    return [NET POSTWithParameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id  _Nonnull resultObject) {
    }];
}@end
