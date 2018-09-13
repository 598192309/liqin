//
//  CommonModel.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/29.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "CommonModel.h"
@implementation UserInfoItem

@end
@implementation SystemInfoItem

@end
@implementation LoanInfoItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             };
}
@end
@implementation CommonInfoItem

@end
@implementation CaseItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             };
}
@end
