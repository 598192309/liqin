//
//  BaseApi.h
//  IUang
//
//  Created by jayden on 2018/4/24.
//  Copyright © 2018年 jayden. All rights reserved.
//


#import <Foundation/Foundation.h>
typedef void(^NoParamsBlock)(void);
typedef void(^ErrorBlock)(NSError *error,id resultObject);
@interface BaseApi : NSObject
+(NetworkTask *)requestWithParam:(NSDictionary *)param;

@end
