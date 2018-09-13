//
//  HomeApi.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/27.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "BaseApi.h"
@class HomeDataItem,LoanListItem,PayInfoItem,ContractItem,EDuThemeItem,EDuQuestionItem,PaytypeItem,GoPayDetailItem,LoanBuildInfoItem;
@interface HomeApi : BaseApi
/** 首页主题  */
+ (NetworkTask *)requestHomeDataSuccess:(void(^)(HomeDataItem *homeDataItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;
/** 获取下款数据列表 */
+ (NetworkTask *)requestLoanListSuccess:(void(^)(NSArray *loanListArr,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;

/** 会员页面 获取借款类型 下半部分View*/
+ (NetworkTask *)requestLoanTypeListSuccess:(void(^)(NSArray *loanTypeListArr,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;
/** 会员页面 获取付款主题  上半部分VIew */
+ (NetworkTask *)requestLoanTypePayInfoSuccess:(void(^)(PayInfoItem *payInfoItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;

/** 会员页面 获取借款合同  apply_loan_id:借款ID（选择目标金额支付服务费的页面，不用传入该参数）*/
+ (NetworkTask *)requestLoanContractWithID:(NSString *)ID borrow_amount:(NSString *)borrow_amount apply_loan_id:(NSString *)apply_loan_id Success:(void(^)(ContractItem *contractItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;

/************************额度测试*/
/** 额度测算主题*/
+ (NetworkTask *)requestEDuThemeSuccess:(void(^)(EDuThemeItem *eDuThemeItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;

/** 额度测算问题*/
+ (NetworkTask *)requestEDuQuestionListSuccess:(void(^)(NSArray *eDuQuestionItemArr,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;
/** 额度测算 提交测评*/
+ (NetworkTask *)submitEDuQuestionListWithOptions:(NSString *)options success:(void(^)(NSInteger quota,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;
/************************z支付*/
/** 提交申请 */
+ (NetworkTask *)sumbmitLoanWithAmount:(NSString *)amount Success:(void(^)(NSString *loan_id,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;
/** 获取支付信息*/
+ (NetworkTask *)requestPayTypesSuccess:(void(^)(NSArray *paytypeItemArr,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;
/**去支付
 "type": "service",  service为支付居间服务费，commission为支付佣金
 "commission_token":  支付佣金的token（支付佣金时必填）
 "payment_notice_id": 支付单号，可以为空
 "verify_code": 快捷支付的支付验证码，可以为空
 */
+ (NetworkTask *)gopayWithLoan_id:(NSString *)loan_id  mobile:(NSString *)mobile type:(NSString *)type bankcard:(NSString *)bankcard idno:(NSString *)idno real_name:(NSString *)real_name commission_token:(NSString *)commission_token payment_code:(NSString *)payment_code payment_notice_id:(NSInteger)payment_notice_id verify_code:(NSString *)verify_code   success:(void(^)(GoPayDetailItem *goPayDetailItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;

/**
支付结果查询  （支付宝不适应此接口）
 */
+ (NetworkTask *)queryPaymentResultWithkey:(NSString *)key success:(void(^)(NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;


/************************获取借款信用信息*/
+ (NetworkTask *)requestLoanBuildInfoWithLoan_id:(NSString *)loan_id success:(void(^)(LoanBuildInfoItem * loanBuildInfoItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;

/**获取省份列表*/
+ (NetworkTask *)requestProvinceListSuccess:(void(^)(NSArray * provinceList,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;
/**获取城市列表*/
+ (NetworkTask *)requestCityListWithProvice:(NSString *)province success:(void(^)(NSArray * cityList,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;
/**提交借款信用信息*/
+ (NetworkTask *)requestLoanBuildInfoWithLoan_id:(NSString *)loan_id real_name:(NSString *)real_name bankcard:(NSString *)bankcard idno:(NSString *)idno  mobile:(NSString *)mobile zhima:(NSString *)zhima qq:(NSString *)qq education:(NSString *)education graduation:(NSString *)graduation province:(NSString *)province city:(NSString *)city credit_info:(NSMutableDictionary *)credit_info loan_platform:(NSString *)loan_platform    addresslist:(NSArray *)addresslist   success:(void(^)(NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;
@end
