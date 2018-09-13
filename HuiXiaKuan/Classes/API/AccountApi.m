//
//  AccountApi.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/31.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "AccountApi.h"
#import "Account.h"
@implementation AccountApi
/** 贷款记录）*/
+ (NetworkTask *)requestLoanRecordWithPage:(NSString *)page  Success:(void(^)(AccountHomeItem *accountHomeItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/loan" parameters:@{@"page":SAFE_NIL_STRING(page)}  criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        AccountHomeItem *accountHomeItem = [AccountHomeItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(accountHomeItem,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/** 支付下款佣金*/
+ (NetworkTask *)requestXiakuanCommissionInfoWithLoan_id:(NSString *)loan_id commission_token:(NSString *)commission_token  Success:(void(^)(XiakuanCommissionItem *xiakuanCommissionItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/loan/commission" parameters:@{@"loan_id":SAFE_NIL_STRING(loan_id),@"commission_token":SAFE_NIL_STRING(commission_token)}  criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        XiakuanCommissionItem *xiakuanCommissionItem = [XiakuanCommissionItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(xiakuanCommissionItem,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}
@end
