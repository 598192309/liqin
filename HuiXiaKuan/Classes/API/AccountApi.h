//
//  AccountApi.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/31.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "BaseApi.h"
@class AccountHomeItem,XiakuanCommissionItem;
@interface AccountApi : BaseApi
/** 贷款记录）*/
+ (NetworkTask *)requestLoanRecordWithPage:(NSString *)page  Success:(void(^)(AccountHomeItem *accountHomeItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;

/** 支付下款佣金*/
+ (NetworkTask *)requestXiakuanCommissionInfoWithLoan_id:(NSString *)loan_id commission_token:(NSString *)commission_token  Success:(void(^)(XiakuanCommissionItem *xiakuanCommissionItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;

@end
