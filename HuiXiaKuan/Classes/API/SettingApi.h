//
//  SettingApi.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/4.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "BaseApi.h"
@class  AboutItem;
@interface SettingApi : BaseApi
/**关于我们 */
+ (NetworkTask *)requestAboutInfoSuccess:(void(^)(AboutItem *aboutItem,NSString *msg,NSInteger status))successBlock error:(ErrorBlock)errorBlock;
@end
