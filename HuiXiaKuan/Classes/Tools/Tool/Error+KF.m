//
//  Error+KF.m
//  KlineFight
//

//

#import "Error+KF.h"

NSString * const ErrorDomainDataInterface = @"ErrorDomainDataInterface";

@implementation NSError(KF)
+(NSError*)errorWithMsg:(NSString*)msg
                 domain:(NSString *)domain
                   code:(NSInteger)code{
    if(msg==nil){
        msg=@"";
    }
    if(domain==nil){
        domain=@"";
    }
    return [NSError errorWithDomain:domain code:code userInfo:@{@"errorMsg":msg}];
}

-(NSString*)errorMsg{
    return SAFE_VALUE_FOR_KEY(self.userInfo, @"errorMsg");
}
@end
