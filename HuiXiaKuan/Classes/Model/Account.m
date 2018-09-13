//
//  Account.m
//  IUang
//
//  Created by Lqq on 2018/4/26.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "Account.h"

@implementation LoanRecordInfoItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             };
}
@end
@implementation PageItem
@end
@implementation AccountHomeItem
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list" :[LoanRecordInfoItem class],
             };
}
@end
@implementation XiakuanCommissionItem
@end
