//
//  STEncry.m
//  StockCoreKit
//
//  Created by Jaykon on 14-12-15.
//  Copyright (c) 2014年 Guangzhou ZhangAoBo Software Technology Co., Ltd. All rights reserved.
//

#import "STEncrypt.h"
#import "AES256.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
@implementation STEncrypt
+ (NSString *)MD5WithString:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result );
    NSString *resulrString=[NSString stringWithFormat:
                            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                            result[0], result[1], result[2], result[3],
                            result[4], result[5], result[6], result[7],
                            result[8], result[9], result[10], result[11],
                            result[12], result[13], result[14], result[15]
                            ];
    resulrString=[resulrString lowercaseString];
    //NSLog(@"before md5:%@",str);
    //NSLog(@"after md5:%@",resulrString);
    return resulrString;
}

+ (NSString *)MD5WithStringArray:(NSArray*)array
{
    NSMutableString *temString=[[NSMutableString alloc] init];
    for (NSString *param in array) {
        [temString appendString:param];
        //NSLog(@"%@",param);
    }
    NSString *ressult=[NSString stringWithString:temString];
    return [[self MD5WithString:ressult] lowercaseString];
}

+ (NSString *)encryptWithString:(NSString*)string
{
    if(string==nil){
        return nil;
    }
    return [[self MD5WithStringArray:@[string,@"hzgpg"]] lowercaseString];
}

+ (NSString *)AESEncryptWithSting:(NSString*)value
{
//    return [AES256 encryptWithString:value praviteKey:RI.encrptyAndDecrptyKey];
    return @"";
}

+ (NSString *)AESDecryptWithSting:(NSString*)value
{
    //FANWE5LMUQC43P2P
//    NSString *returnStr=[AES256 decryptWithString:value praviteKey:RI.encrptyAndDecrptyKey];
    return @"";
}
@end
