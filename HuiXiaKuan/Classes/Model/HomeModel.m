//
//  HomeModel.m
//  IUang
//
//  Created by jayden on 2018/4/26.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeDataItem

@end
@implementation LoanListItem

@end

@implementation LoanTypeItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"isSelected":@"is_selected"
             };
}
@end
@implementation PayInfoProgressItem

@end
@implementation PayInfoItem
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"a14" :[PayInfoProgressItem class],
             };
}

@end
@implementation ContractItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             };
}
@end
@implementation EDuThemeItem

@end

@implementation EDuQuestionItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             };
}
@end
@implementation PaytypeItem

@end
@implementation GoPayDetailItem

@end

@implementation RealNameInfoItem

@end
@implementation EducationItem

@end
@implementation BaseInfoItem

@end
@implementation CreditInfoItem
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"questions" :[EDuQuestionItem class],
             };
}
@end
@implementation LoanPlatformItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             };
}
@end
@implementation LoanBuildInfoItem
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"credit_info" :[CreditInfoItem class],
             @"loan_platform" :[LoanPlatformItem class],
             };
}
@end

@implementation ProvincesCityItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             };
}
@end
