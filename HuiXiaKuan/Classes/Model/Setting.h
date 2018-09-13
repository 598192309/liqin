//
//  Setting.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/4.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <Foundation/Foundation.h>
//官方渠道
@interface WeChatItem : NSObject
@property (nonatomic,strong)NSString *qrcode;
@property (nonatomic,strong)NSString *account;

@end
//联系方式
@interface ContactItem : NSObject
/**通讯地址*/
@property (nonatomic,strong)NSString *address;
/**客服电话*/
@property (nonatomic,strong)NSString *customer_tel;
/**投诉监督电话*/
@property (nonatomic,strong)NSString *complaint_tel;
/**微信号*/
@property (nonatomic,strong)NSString *wechat;
/**客服邮箱*/
@property (nonatomic,strong)NSString *customer_email;
@end

@interface AboutItem : NSObject
@property (nonatomic,strong)NSString *bg;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)WeChatItem *wechat;
@property (nonatomic,strong)ContactItem *contact;
@property (nonatomic,strong)NSArray *photo;
@property (nonatomic,strong)NSString *logo;

@end
