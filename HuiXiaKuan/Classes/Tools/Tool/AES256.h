//
//  AES256.h
//
//  Created by Jaykon on 13-7-29.
//  Copyright (c) 2013年 jaykon. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface AES256 : NSObject
+ (NSString *)encryptWithString:(NSString *)content praviteKey:(NSString*)aKey;
+ (NSString *)decryptWithString:(NSString *)content praviteKey:(NSString*)aKey;
@end
