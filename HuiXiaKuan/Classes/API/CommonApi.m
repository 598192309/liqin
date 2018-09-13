//
//  CommonApi.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/27.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "CommonApi.h"
#import "CommonModel.h"

@implementation CommonApi
/**  获取图形验证码 */
+ (NetworkTask *)requestTuxingSuccess:(void(^)(NSString *captcha))successBlock error:(ErrorBlock)errorBlock{
    
    return [NET POST:@"/api/captcha" parameters:@{@"from":@"ios"} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        
        NSString *captcha = [[resultObject safeObjectForKey:@"data"] safeObjectForKey:@"captcha"] ;
        if (successBlock) {
            successBlock(captcha);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
    
}

/**  获取通用信息 */
+ (NetworkTask *)requestCommonInfoSuccess:(void(^)(NSString *msg,NSInteger status,CommonInfoItem *commonInfoItem))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/info" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        CommonInfoItem *commonInfoItem = [CommonInfoItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];
        UserInfoItem *user = commonInfoItem.user;
        SystemInfoItem *system = commonInfoItem.system;
        LoanInfoItem *loan = commonInfoItem.loan;
        RI.is_logined = user.login;
        RI.real_name = user.real_name;
        RI.mobile = user.mobile;
        if (!(RI.quota > 0)) {
            RI.quota = user.quota;
        }
        RI.is_vest = system.is_vest;
        RI.customer_qq = system.customer_qq;
        RI.customer_qq_link = system.customer_qq_link;
        RI.saler_qq_link = system.saler_qq_link;
        RI.pre_service_tel = system.pre_service_tel;
        RI.tel = system.tel;
        RI.is_perfected = loan.is_perfected;
        RI.loanID = loan.ID;
        

        if (successBlock) {
            successBlock(msg,status,commonInfoItem);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];

    
    
}

/** 获取贷款案例 */
+ (NetworkTask *)requestLoanCaseSuccess:(void(^)(NSArray *caseItemArr,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/article/cases" parameters:nil  criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *caseItemArr = [CaseItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(caseItemArr,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}
@end
