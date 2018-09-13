//
//  NSString+HTML.h
//  RabiBird
//
//  Created by 会下款 on 16/8/28.
//  Copyright © 2016年 Lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HTML)
+(NSString *)filterHTML:(NSString *)html;
+(NSString *)filterHTMLNo:(NSString *)html;//不换行的


//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile;
//正则运算 身份证号
+ (BOOL)validateIdentityCard: (NSString *)identityCard;
/** 判断是否全是数字*/
+ (BOOL)valiNumber:(NSString *)str;


/**
 *  精确的身份证号码有效性检测
 *
 *  @param value 身份证号
 */
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;

/**
 *  邮箱的有效性
 */
- (BOOL)isEmailAddress;


//json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


//字典转json格式字符串：

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;


//attributeString  label行间距
+ (NSAttributedString *)attributeStringWithParagraphStyleLineSpace:(CGFloat)space withString:(NSString *)str;

+ (NSAttributedString *)attributeStringWithParagraphStyleLineSpace:(CGFloat)space withString:(NSString *)str Alignment:(NSTextAlignment)alignment;

- (NSString *)URLEncodedString;


- (NSString *)dealChar:(NSString *)str;

@end
