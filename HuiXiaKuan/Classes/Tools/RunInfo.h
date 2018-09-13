//
//  RunInfo.h
//  stock
//
//  Created by Jaykon on 14-2-9.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>


#define RI ([RunInfo sharedInstance])
@class CommonInfoItem;
extern NSString* const STAPPErrorDomain;
@interface RunInfo : NSObject

@property (nonatomic,assign) BOOL ios_released;// IOS是否已上架的开关，用于控制购买优惠券相关功能及页面的显示（或以后其他规避审核时使用）
/**
 iOS是否已上架
 主要还是靠这个，以后后台可能会换key
 1、用于全局截图的通知
 2、申请流程前获取位置、通讯录的权限
 */

@property(nonatomic,assign)BOOL is_logined;//是否登录 以这个为标准判断 不以上面判断

@property (strong,nonatomic  ) NSString *mobile;//手机号
@property (strong,nonatomic  )NSString * real_name;//
@property (assign,nonatomic  )NSInteger  quota;//

@property (nonatomic, assign)BOOL quanxianAllowd;//获取权限成功

@property (nonatomic,strong)NSString *authorization;//在客户端第一次被打开的时候，需要主动获取JWT的Token信息。获取成功后，将返回的JWT保存到本地，之后每次请求都需要在Request的Header上添加验证信息。在服务器上Response的Header，每次都会返回JWT信息，因为这个JWT信息在一定时间会有变化，所以，客户端每次手动Response的时候，都应该拿来与本地的JWT比较一下，如果存在不同，则需要更新本地的JWT。
@property (nonatomic, assign)BOOL is_vest;//是否马甲
@property (strong,nonatomic  )NSString * customer_qq;//保存QQ号，用于截屏跳转 及单个联系客服qq挑转
@property (strong,nonatomic  )NSString * customer_qq_link;//客服QQ链接
@property (strong,nonatomic  )NSString * saler_qq_link;//转化销售QQ链接
@property (strong,nonatomic  )NSString * pre_service_tel;// 售前电话号码
@property (strong,nonatomic  )NSString * tel;// 客服电话
@property (nonatomic,assign)NSInteger loanID;//借款ID 如果大于0  就代表 有支付服务费
@property (nonatomic, assign)BOOL is_perfected;//是否已完善信用信息

@property (nonatomic,strong)CommonInfoItem *commonInfoItem;

+ (RunInfo *)sharedInstance;
//检测是否需要自动登录
- (void)checkLogin;
//登录
- (void)loginWithMobile:(NSString *)mobile pwd:(NSString *)pwd;
//退出
- (void)loginOut;

//跟新用户信息
- (void)updateUserInfo;


@end
