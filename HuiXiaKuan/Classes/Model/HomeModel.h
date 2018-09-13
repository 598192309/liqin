//
//  HomeModel.h
//  IUang
//  首页model 可申请借款状态 status == 1
//  Created by jayden on 2018/4/26.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@class LoanRecordInfoItem;

@interface HomeDataItem : NSObject
@property (nonatomic,strong) NSString *a1;
@property (nonatomic,strong) NSString *a2;
@property (nonatomic,strong) NSString *a3;
@property (nonatomic,strong) NSString *a4;
@property (nonatomic, strong) NSString * a5;
@property (nonatomic,strong) NSString *a6;
@property (nonatomic,strong) NSString *a7;
@property (nonatomic,strong) NSString *a8;
@property (nonatomic,strong) NSString *a9;
@property (nonatomic, strong) NSString * a11;
@property (nonatomic, strong) NSArray * a10;

@end

/**首页 动画 近期下款数据*/

@interface LoanListItem : NSObject
@property(nonatomic,strong)NSString *avatar;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *amount;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *time;
@end
/************************** 会员待支付页面*/
@interface  LoanTypeItem: NSObject
@property (nonatomic,strong)NSString *scope;
@property (nonatomic,assign)NSInteger amount;
@property (nonatomic,assign)NSInteger org_fee;
@property (nonatomic,assign)NSInteger total_fee;
@property (nonatomic,assign)NSInteger deposit;
@property (nonatomic,assign)NSInteger service_fee;
@property (nonatomic,strong)NSString *info;
@property (nonatomic,assign)BOOL isSelected;
@property (nonatomic,assign)BOOL is_effect;
@end
//会员待支付页面  上半部分的信息
@interface  PayInfoProgressItem: NSObject
@property (nonatomic,strong)NSString *title;
@property (nonatomic,assign)NSInteger apply_num;
@property (nonatomic,assign)NSInteger loan_num;
@property (nonatomic,assign)NSInteger rate;
@end

@interface PayInfoItem : NSObject
@property (nonatomic,strong) NSString *a1;
@property (nonatomic,strong) NSString *a2;
@property (nonatomic,strong) NSString *a3;
@property (nonatomic,strong) NSString *a4;
@property (nonatomic, strong) NSString * a5;
@property (nonatomic,strong) NSString *a6;
@property (nonatomic,strong) NSString *a7;
@property (nonatomic,strong) NSString *a8;
@property (nonatomic,strong) NSString *a9;
@property (nonatomic,strong) NSString *a10;
@property (nonatomic, strong) NSString * a11;
@property (nonatomic, strong) NSString * a12;
@property (nonatomic, strong) NSString * a13;
@property (nonatomic, strong) NSArray * a14;
@property (nonatomic, strong) NSString * a15;
@property (nonatomic, strong) NSString * a16;
@property (nonatomic, strong) NSString * a17;
@property (nonatomic, strong) NSString * a18;
@property (nonatomic, strong) NSString * a19;
/**合同ID*/
@property (nonatomic, assign) NSInteger  a20;//合同ID
@property (nonatomic, strong) NSString * a21;


@end

//借款合同
@interface  ContractItem: NSObject
@property (nonatomic,assign)NSInteger ID;
@property (nonatomic,assign)BOOL is_effect;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *created_at;
@property (nonatomic,strong)NSString *updated_at;
@end

/************************额度测试*/

//额度测试主题
@interface  EDuThemeItem: NSObject
@property (nonatomic,strong) NSString *a1;
@property (nonatomic,strong) NSString *a2;
@property (nonatomic,strong) NSString *a3;
@end

//额度测试问题
@interface  EDuQuestionItem: NSObject
@property (nonatomic,assign) NSInteger ID;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSArray *options;
@property (nonatomic,strong)NSString *selected;
@end


/************************支付*/
/**获取支付信息*/
@interface  PaytypeItem: NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *logo;
@property (nonatomic,strong) NSString *code;
@end

/**去支付*/
@interface  GoPayDetailItem: NSObject
/** 支付接口名*/
@property (nonatomic,strong) NSString *name;
/**支付宝收款二维码图片，base64二进制内容，可以直接输出到浏览器<img src="">上*/
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *client_type;
/**在线查询支付状态时要用到该key*/
@property (nonatomic,strong) NSString *key;
@property (nonatomic,strong) NSString *payment_info;
@property (nonatomic,assign) NSInteger payment_notice_id;


@end

/****************************个人信息 界面数据*/
@interface RealNameInfoItem : NSObject
/**  */
@property(nonatomic,strong)NSString *real_name;
@property(nonatomic,strong)NSString *bankcard;
@property(nonatomic,strong)NSString *idno;
@property(nonatomic,strong)NSString *mobile;

@end

@interface EducationItem : NSObject
/**  */
@property(nonatomic,strong)NSArray *list;

@property(nonatomic,strong)NSString *selected;

@end

@interface BaseInfoItem : NSObject
/**  */
@property(nonatomic,strong)NSString *zhima;
@property(nonatomic,strong)NSString *qq;
@property (nonatomic,strong)EducationItem *education;
/**毕业年数*/
@property(nonatomic,strong)NSString *graduation;
/**所在省ID*/
@property(nonatomic,strong)NSString *province;
/**所在市ID*/
@property(nonatomic,strong)NSString *city;
@end


@interface CreditInfoItem : NSObject
/**  */
@property(nonatomic,assign)NSInteger cat_id;
@property(nonatomic,strong)NSString *cat_name;
@property (nonatomic,strong)NSArray *questions;
@end

@interface LoanPlatformItem : NSObject
/**  */
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *logo;
@property(nonatomic,assign)BOOL isSelected;//用来记录被点击

@end

@interface LoanBuildInfoItem : NSObject
/**  */
@property(nonatomic,assign)LoanRecordInfoItem *loan;
@property(nonatomic,strong)RealNameInfoItem *real_name_info;
@property (nonatomic,strong)BaseInfoItem *base_info;
@property (nonatomic,strong)NSArray *credit_info;
@property (nonatomic,strong)NSArray *loan_platform;

@end


@interface ProvincesCityItem : NSObject
/**  */
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)BOOL selected;

@end
 
