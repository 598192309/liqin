//
//  HomeApi.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/27.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "HomeApi.h"
#import "HomeModel.h"

@implementation HomeApi
/** 首页主题  */
+ (NetworkTask *)requestHomeDataSuccess:(void(^)(HomeDataItem *homeDataItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/theme" parameters:nil  criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        HomeDataItem *homeDataItem = [HomeDataItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(homeDataItem,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];

}


/** 获取下款数据列表 */
+ (NetworkTask *)requestLoanListSuccess:(void(^)(NSArray *loanListArr,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/loan/latest" parameters:nil  criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *loanListArr = [LoanListItem mj_objectArrayWithKeyValuesArray:[[resultObject safeObjectForKey:@"data"] safeObjectForKey:@"list"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(loanListArr,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/** 会员待支付页面 获取借款类型 下半部分VIew */
+ (NetworkTask *)requestLoanTypeListSuccess:(void(^)(NSArray *loanTypeListArr,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/loan/loantype" parameters:nil  criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *loanTypeListArr = [LoanTypeItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(loanTypeListArr,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/** 会员页面 获取付款主题  上半部分VIew */
+ (NetworkTask *)requestLoanTypePayInfoSuccess:(void(^)(PayInfoItem *payInfoItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/theme/pay" parameters:nil  criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        PayInfoItem *payInfoItem = [PayInfoItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(payInfoItem,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];

}

/** 会员页面 获取借款合同 */
+ (NetworkTask *)requestLoanContractWithID:(NSString *)ID borrow_amount:(NSString *)borrow_amount apply_loan_id:(NSString *)apply_loan_id Success:(void(^)(ContractItem *contractItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/article/contract" parameters:@{@"id":SAFE_NIL_STRING(ID),@"borrow_amount":SAFE_NIL_STRING(borrow_amount),@"apply_loan_id":SAFE_NIL_STRING(apply_loan_id)}  criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        ContractItem *contractItem = [ContractItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(contractItem,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/************************额度测试*/
/** 额度测算主题*/
+ (NetworkTask *)requestEDuThemeSuccess:(void(^)(EDuThemeItem *eDuThemeItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/theme/quota" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        EDuThemeItem *eDuThemeItem = [EDuThemeItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(eDuThemeItem,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/** 额度测算问题*/
+ (NetworkTask *)requestEDuQuestionListSuccess:(void(^)(NSArray *eDuQuestionItemArr,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/quota/questions" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        EDuQuestionItem *eDuQuestionItemArr = [EDuQuestionItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(eDuQuestionItemArr,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/** 额度测算 提交测评*/
+ (NetworkTask *)submitEDuQuestionListWithOptions:(NSString *)options success:(void(^)(NSInteger quota,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/quota/calculate" parameters:@{@"options":SAFE_NIL_STRING(options)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger quota = [[[resultObject safeObjectForKey:@"data"] safeObjectForKey:@"quota"] integerValue];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(quota,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/************************z支付页面*/
/** 提交申请 */
+ (NetworkTask *)sumbmitLoanWithAmount:(NSString *)amount Success:(void(^)(NSString *loan_id,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/loan/apply" parameters:@{@"amount":SAFE_NIL_STRING(amount)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSString *loan_id = [[resultObject safeObjectForKey:@"data"] safeObjectForKey:@"loan_id"];

        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(loan_id,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}
/** 获取支付信息*/
+ (NetworkTask *)requestPayTypesSuccess:(void(^)(NSArray *paytypeItemArr,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/payment/types" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *paytypeItemArr = [PaytypeItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(paytypeItemArr,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/**去支付
 "type": "service",  service为支付居间服务费，commission为支付佣金
 "commission_token":  支付佣金的token（支付佣金时必填）
 "payment_notice_id": 支付单号，可以为空
 "verify_code": 快捷支付的支付验证码，可以为空
 */
+ (NetworkTask *)gopayWithLoan_id:(NSString *)loan_id mobile:(NSString *)mobile type:(NSString *)type bankcard:(NSString *)bankcard idno:(NSString *)idno real_name:(NSString *)real_name commission_token:(NSString *)commission_token payment_code:(NSString *)payment_code payment_notice_id:(NSInteger )payment_notice_id verify_code:(NSString *)verify_code   success:(void(^)(GoPayDetailItem *goPayDetailItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/payment" parameters:
  @{@"loan_id":SAFE_NIL_STRING(loan_id),@"mobile":SAFE_NIL_STRING(mobile),@"type":SAFE_NIL_STRING(type),@"bankcard":SAFE_NIL_STRING(bankcard),@"idno":SAFE_NIL_STRING(idno),@"real_name":SAFE_NIL_STRING(real_name),@"commission_token":SAFE_NIL_STRING(commission_token),@"payment_code":SAFE_NIL_STRING(payment_code),@"client_type":@"wap",@"payment_notice_id":@(payment_notice_id),@"verifycode":SAFE_NIL_STRING(verify_code)}
       criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        GoPayDetailItem *goPayDetailItem = [GoPayDetailItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(goPayDetailItem,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
   
    }];
}

/**
 支付结果查询  （支付宝不适应此接口）
 */
+ (NetworkTask *)queryPaymentResultWithkey:(NSString *)key success:(void(^)(NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/payment/result" parameters:@{@"key":SAFE_NIL_STRING(key)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];

}

/************************获取借款信用信息*/
+ (NetworkTask *)requestLoanBuildInfoWithLoan_id:(NSString *)loan_id success:(void(^)(LoanBuildInfoItem * loanBuildInfoItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/loan/buildinfo" parameters:@{@"loan_id":loan_id} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        LoanBuildInfoItem *loanBuildInfoItem = [LoanBuildInfoItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];

        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(loanBuildInfoItem,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
    
}


/**获取省份列表*/
+ (NetworkTask *)requestProvinceListSuccess:(void(^)(NSArray * provinceList,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/region/provinces" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray * provinceList = [ProvincesCityItem mj_objectArrayWithKeyValuesArray:[[resultObject safeObjectForKey:@"data"] safeObjectForKey:@"list"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(provinceList,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];

}
/**获取城市列表*/
+ (NetworkTask *)requestCityListWithProvice:(NSString *)province success:(void(^)(NSArray * cityList,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/region/cities" parameters:@{@"province" : SAFE_NIL_STRING(province)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray * cityList = [ProvincesCityItem mj_objectArrayWithKeyValuesArray:[[resultObject safeObjectForKey:@"data"] safeObjectForKey:@"list"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(cityList,msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];

}
/**提交借款信用信息*/
+ (NetworkTask *)requestLoanBuildInfoWithLoan_id:(NSString *)loan_id real_name:(NSString *)real_name bankcard:(NSString *)bankcard idno:(NSString *)idno  mobile:(NSString *)mobile zhima:(NSString *)zhima qq:(NSString *)qq education:(NSString *)education graduation:(NSString *)graduation province:(NSString *)province city:(NSString *)city credit_info:(NSMutableDictionary *)credit_info loan_platform:(NSString *)loan_platform  addresslist:(NSArray *)addresslist  success:(void(^)(NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/app2/loan/submitinfo" parameters:
            @{@"loan_id" : SAFE_NIL_STRING(loan_id),
              @"real_name" : SAFE_NIL_STRING(real_name),
              @"bankcard" : SAFE_NIL_STRING(bankcard),
              @"idno" : SAFE_NIL_STRING(idno),
              @"mobile" : SAFE_NIL_STRING(mobile),
              @"zhima" : SAFE_NIL_STRING(zhima),
              @"qq" : SAFE_NIL_STRING(qq),
              @"education" : SAFE_NIL_STRING(education),
              @"graduation" : SAFE_NIL_STRING(graduation),
              @"province" : SAFE_NIL_STRING(province),
              @"city" : SAFE_NIL_STRING(city),
              @"credit_info" : credit_info,
              @"loan_platform" : SAFE_NIL_STRING(loan_platform),
              @"addresslist" : addresslist
              }
       criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        if (successBlock) {
            successBlock(msg,status);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];

}
@end
