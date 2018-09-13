//
//  STEncry.h
//  StockCoreKit
//
//  Created by Jaykon on 14-12-15.
//  Copyright (c) 2014年 Guangzhou ZhangAoBo Software Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface STEncrypt : NSObject
/**
 *  MD5加密
 *
 *  @param string 加密字符串
 *
 *  @return 密文
 */
+ (NSString *)MD5WithString:(NSString *)string;

/**
 *  MD5加密(数组)
 *
 *  @param array  加密字符串数组
 *
 *  @return 密文
 */
+ (NSString *)MD5WithStringArray:(NSArray*)array;

/**
 *  自定义不可逆加密
 *
 *  @param string 加密字符串
 *
 *  @return 密文
 */
+ (NSString *)encryptWithString:(NSString*)string;

/**
 *  对称加密
 *
 *  @param value 加密明文
 *
 *  @return 密文
 */
+ (NSString *)AESEncryptWithSting:(NSString*)value;

/**
 *  对称解密
 *
 *  @param value 加密密文
 *
 *  @return 明文
 */
+ (NSString *)AESDecryptWithSting:(NSString*)value;
@end
