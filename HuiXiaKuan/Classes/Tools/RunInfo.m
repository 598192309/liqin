//
//  RunInfo.m
//  stock
//
//  Created by Jaykon on 14-2-9.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//



#import "RunInfo.h"

@interface RunInfo()

@end

@implementation RunInfo{
    BOOL _isSMSSDKRegisted;
    BOOL _isWeChatRegisted;
}




+ (RunInfo *)sharedInstance
{
    static dispatch_once_t t;
    static RunInfo *sharedInstance = nil;
    dispatch_once(&t, ^{
        sharedInstance = [[RunInfo alloc] init];
    });
    return sharedInstance;
}


- (id)init
{
    self = [super init];
    if (self){
        
       
        
        _is_logined = [[NSUserDefaults standardUserDefaults ] objectForKey:kUserSignIn] ? [[[NSUserDefaults standardUserDefaults ] objectForKey:kUserSignIn] boolValue] : false;
        _mobile = [[NSUserDefaults standardUserDefaults ] objectForKey:KMobile] ? [[NSUserDefaults standardUserDefaults ] objectForKey:KMobile] : @"";
        _real_name = [[NSUserDefaults standardUserDefaults ] objectForKey:KRealName] ? [[NSUserDefaults standardUserDefaults ] objectForKey:KRealName] : @"";
        _quota = [[NSUserDefaults standardUserDefaults ] objectForKey:KQuota] ? [[[NSUserDefaults standardUserDefaults ] objectForKey:KQuota] integerValue]: 0;
        _customer_qq = [[NSUserDefaults standardUserDefaults ] objectForKey:KCustomer_qq] ? [[NSUserDefaults standardUserDefaults ] objectForKey:KCustomer_qq] : @"";
        _customer_qq_link = [[NSUserDefaults standardUserDefaults ] objectForKey:KCustomer_qq_link] ? [[NSUserDefaults standardUserDefaults ] objectForKey:KCustomer_qq_link] : @"";
        _saler_qq_link = [[NSUserDefaults standardUserDefaults ] objectForKey:KSaler_qq_link] ? [[NSUserDefaults standardUserDefaults ] objectForKey:KSaler_qq_link] : @"";
        _pre_service_tel = [[NSUserDefaults standardUserDefaults ] objectForKey:KPre_service_tel] ? [[NSUserDefaults standardUserDefaults ] objectForKey:KPre_service_tel] : @"";
        _tel = [[NSUserDefaults standardUserDefaults ] objectForKey:KTel] ? [[NSUserDefaults standardUserDefaults ] objectForKey:KTel] : @"";
        _is_perfected = [[NSUserDefaults standardUserDefaults ] objectForKey:KIs_perfected] ? [[[NSUserDefaults standardUserDefaults ] objectForKey:KIs_perfected] boolValue] : false;
        _is_vest = [[NSUserDefaults standardUserDefaults ] objectForKey:KIs_vest] ? [[[NSUserDefaults standardUserDefaults ] objectForKey:KIs_vest] boolValue] : false;
        _loanID = [[NSUserDefaults standardUserDefaults ] objectForKey:KLoanID] ?[[[NSUserDefaults standardUserDefaults ] objectForKey:KLoanID] integerValue] : 0 ;




        
//        _quanxianAllowd = [[NSUserDefaults standardUserDefaults ] objectForKey:KQuanxianAllowed] ? [[[NSUserDefaults standardUserDefaults ] objectForKey:KQuanxianAllowed] boolValue] : false;
        _authorization = [[NSUserDefaults standardUserDefaults ] objectForKey:KAuthorization] ? [[NSUserDefaults standardUserDefaults ] objectForKey:KAuthorization] : @"";

        
    }
    return self;
}




-(void)setIs_logined:(BOOL)is_logined{
    _is_logined = is_logined;
    [[NSUserDefaults standardUserDefaults] setBool:is_logined forKey:kUserSignIn];
}
-(void)setMobile:(NSString *)mobile{
    _mobile = mobile;
    [[NSUserDefaults standardUserDefaults] setObject:mobile forKey:KMobile];
}







@end
