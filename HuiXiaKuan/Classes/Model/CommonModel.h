//
//  CommonModel.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/29.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UserInfoItem : NSObject
@property(nonatomic,strong)NSString *real_name; //
@property(nonatomic,strong)NSString *mobile; //
@property(nonatomic,assign)NSInteger quota; //额度
@property(nonatomic,assign)BOOL login; //
@end
@interface SystemInfoItem : NSObject
@property(nonatomic,assign)BOOL is_vest; //是否启用马甲 0否，1是
@property(nonatomic,strong)NSString *customer_qq; //
@property(nonatomic,strong)NSString *customer_qq_link; //
@property(nonatomic,strong)NSString *saler_qq_link; //
/**售前电话号码*/
@property(nonatomic,strong)NSString *pre_service_tel; //
/**客服电话*/
@property(nonatomic,strong)NSString *tel; //
@property(nonatomic,strong)NSString *time; //
@property(nonatomic,strong)NSString *wechat_qrcode; //
@end
@interface LoanInfoItem : NSObject
@property(nonatomic,assign)BOOL is_perfected; //是否已完善信用信息
@property(nonatomic,assign)NSInteger ID; //借款ID

@end

@interface CommonInfoItem : NSObject
@property (nonatomic,strong)UserInfoItem *user;
@property (nonatomic,strong)SystemInfoItem *system;
@property (nonatomic,strong)LoanInfoItem *loan;

@end


//贷款案例
@interface CaseItem : NSObject
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *keyword;
@property (nonatomic,strong) NSString *photo;
@property (nonatomic,strong) NSString *content;

@end

