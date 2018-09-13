//
//  Account.h
//  IUang
//
//  Created by Lqq on 2018/4/26.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,KRefundStatus){//退款状态
    KRefundStatusNull = 0,//无退款

    KRefundStatusRefunding = 1,//退款中
    KRefundStatusRefunded = 2,//已退款
    KRefundStatusRefundFailed = 3,//退款失败

};
/**个人中心        贷款记录*/
@interface LoanRecordInfoItem : NSObject
@property (nonatomic,assign)NSInteger ID;
@property (nonatomic,strong) NSString *title;// 申请借款区间
@property (nonatomic,assign) NSInteger amount;// 标识区间金额
@property (nonatomic,assign) NSInteger true_amount;// 下款金额
@property (nonatomic,assign) NSInteger total_fee;// 居间服务费
@property (nonatomic, assign) NSInteger  deposit;// 订金
@property (nonatomic,assign) NSInteger service_fee;// 咨询服务费
@property (nonatomic,assign) BOOL is_current;// 是否当前贷款
@property (nonatomic,strong) NSString *status_desc;// 贷款状态描述
@property (nonatomic,assign) BOOL is_paid_service_fee;// 是否支付居间服务费
@property (nonatomic,assign) BOOL is_perfected;// 是否已完善信用信息
@property (nonatomic,assign) BOOL is_matched;// 是否生成贷款方案
@property (nonatomic,assign) BOOL is_loaned;// 是否下款
@property (nonatomic,assign) BOOL is_paid_commission;// 是否支付佣金
@property (nonatomic,assign) BOOL is_vest;// 是否马甲申请
@property (nonatomic,assign) KRefundStatus refund_status;// 退款状态
@property (nonatomic,strong) NSString *applied_at;// 申请日期
@property (nonatomic, assign) NSInteger paid_commission;// 已支付佣金
@property (nonatomic, assign) NSInteger unpaid_commission; // 待支付佣金
@property (nonatomic, strong) NSString * commission_token;// 支付佣金的token
@property (nonatomic, assign) NSInteger contract_id;//合同ID
@property (nonatomic, strong) NSString * status;//  借款进度
@property (nonatomic, strong) NSString * saler_im_link;// 

@end

@interface PageItem : NSObject
/**  */
@property(nonatomic,assign)NSInteger page;
/**  */
@property(nonatomic,assign)NSInteger pageSize;
/**  */
@property(nonatomic,assign)NSInteger recordCount;
/**  */
@property(nonatomic,assign)NSInteger allPages;
@end

//个人中心首页数据
@interface AccountHomeItem : NSObject
/**  */
@property(nonatomic,strong)PageItem *pager;
@property(nonatomic,strong)NSArray *list;

@end

/**支付下款佣金*/
@interface XiakuanCommissionItem : NSObject
@property (nonatomic,assign)NSInteger ID;
@property (nonatomic,strong) NSString *title;// 申请借款区间
@property (nonatomic,assign) NSInteger true_amount;// 下款金额
@property (nonatomic,assign) BOOL is_paid;// 是否支付佣金
@property (nonatomic,assign) BOOL is_vest;// 是否马甲申请
@property (nonatomic,strong) NSString *applied_at;// 申请日期
@property (nonatomic, strong) NSString * created_at;//  下款时间
@property (nonatomic,strong) NSString *real_name;// 申请日期
@property (nonatomic, strong) NSString * mobile;//  下款时间
@property (nonatomic,strong) NSString *commission_rate;// 申请日期
@property (nonatomic, strong) NSString * commission;//  下款时间

@end

