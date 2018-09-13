//
//  Error+KF.h
//  KlineFight
//

//  KF专用的Error

#import <Foundation/Foundation.h>



@interface NSError(KF)
+(NSError*)errorWithMsg:(NSString*)msg
                 domain:(NSString *)domain
                   code:(NSInteger)code;

-(NSString*)errorMsg;
@end
