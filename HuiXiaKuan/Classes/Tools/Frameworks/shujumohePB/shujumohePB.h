//
//  shujumohePB.h
//  shujumohePB
//
//  Created by wei wang on 2018/4/14.
//  Copyright © 2018年 wei wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PBBaseReq : NSObject
/** 渠道编码*/
@property (nonatomic, strong) NSString *channel_code;
/** 合作商标识符*/
@property (nonatomic, strong) NSString *partnerCode;
/** 渠道密匙*/
@property (nonatomic, strong) NSString *partnerKey;

/** 身份核验 - 身份证姓名*/
@property (nonatomic, strong) NSString *real_name;
/** 身份核验 - 身份证号码*/
@property (nonatomic, strong) NSString *identity_code;
/** 身份核验 - 常用手机号码*/
@property (nonatomic, strong) NSString *user_mobile;
/** 拓传参数 - 用于数据回调时使用*/
@property (nonatomic,strong)NSString *passback_params;
@end

@interface PBBaseSet : NSObject
/** SDK导航栏栏背景色 - 默认白色*/
@property (nonatomic, strong) UIColor *navBGColor;
/** SDK导航标题颜色 - 默认黑色*/
@property (nonatomic, strong) UIColor *navTitleColor;
/** SDK导航标题字体 - 默认16号字体*/
@property (nonatomic, strong) UIFont *navTitleFont;
/** SDK导航返回图片 - 默认三角图返回*/
@property (nonatomic, strong) UIImage *backBtnImage;
/** SDK导航返回按钮是否提示 - 默认为NO有alert提示，YES:没有提示*/
@property (nonatomic,assign) BOOL isCancelBackAlert;
@end

@protocol shujumoheDelegate <NSObject>
@optional
//@required
/*
 *@name thePBMissionWithCode:withMessage: - 任务成功或者失败的回调
 *@info  任务失败或者成功在次方法的回调code判断。
 *return code：任务code，具体分类参照对接文档。
 message：任务成功或失败的信息。
 */

- (void)thePBMissionWithCode:(NSString *)code withMessage:(NSString *)message;
@end

@interface shujumohePB : NSObject
//vc:当前视图控制器，delegate:协议，req（必传）:需要channel_code，partnerCode，partnerKey模型。set（可传空）:客户需要的基础设置
+ (void)openPBPluginAtViewController:(UIViewController *)VC
                        withDelegate:(id<shujumoheDelegate>)delegate
                             withReq:(PBBaseReq *)req
                         withBaseSet:(PBBaseSet *)set;

@end




