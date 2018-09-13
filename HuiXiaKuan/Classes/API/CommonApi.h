//
//  CommonApi.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/27.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "BaseApi.h"
/******  公共接口     ********/

@class CommonInfoItem,CaseItem;
@interface CommonApi : BaseApi
/**  获取图形验证码 */
+ (NetworkTask *)requestTuxingSuccess:(void(^)(NSString *captcha))successBlock error:(ErrorBlock)errorBlock;

/**  获取通用信息 */
+ (NetworkTask *)requestCommonInfoSuccess:(void(^)(NSString *msg,NSInteger status,CommonInfoItem *commonInfoItem))successBlock error:(ErrorBlock)errorBlock;
/** 获取贷款案例 */
+ (NetworkTask *)requestLoanCaseSuccess:(void(^)(NSArray *caseItemArr,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;

@end
