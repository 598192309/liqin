//
//  LorginApi.h
//  IUang
//
//  Created by Lqq on 2018/4/25.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "BaseApi.h"
@class LorginModel;
@interface LorginApi : BaseApi
/**  登录  */

+ (NetworkTask *)loginWithMobile:(NSString *)mobile code:(NSString *)code success:(void(^)(LorginModel *loginItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock;
/**获取登录验证码  captcha是图片验证码内容*/
+(NetworkTask *)requsteLoginCodeWithMoblie:(NSString *)mobile captcha:(NSString *)captcha success:(void(^)(NSString *msg))successBlock error:(ErrorBlock)errorBlock;
/**  退出登录  */

+ (NetworkTask *)loginOutSuccess:(void(^)(NSString *msg))successBlock error:(ErrorBlock)errorBlock;


@end
