//
//  InitApi.h
//  IUang
//  App初始化 接口
//  Created by jayden on 2018/4/24.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "BaseApi.h"
@class InitModel;
@interface InitApi : BaseApi
/******   初始化       ********/

+ (NetworkTask *)initialWithLat:(NSString *)lat  lang:(NSString *)lang accuracy:(NSString *)accuracy success:(void(^)(NSString *msg,NSInteger status, NSString *authorization))successBlock error:(ErrorBlock)errorBlock;


/******  公共接口     ********/



@end
