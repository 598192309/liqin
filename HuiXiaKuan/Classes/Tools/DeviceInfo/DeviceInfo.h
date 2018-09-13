//
//  DeviceInfo.h
//  supermarket
//  获取设备的信息
//  Created by jayden on 2018/1/21.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DeviceInfo : NSObject

/**
 deviceId

 @return 设备ID
 */
+(NSString*)getDeviceId;


/**
 UUID

 @return UUID
 */
+(NSString*)getUUID;
/**
 IDFV

 @return 手机生产商的标识码
 */
+(NSString*)getIDFV;

/**
 设备名称
 
 @return 设备名称
 */
+(NSString*)getDeviceName;

/**
 设备型号
 
 @return 设备型号
 */
+(NSString*)getMachineToIdevice;

/**
 系统版本
 
 @return 系统版本
 */
+(NSString*)getSystemVersion;

/**
 国家码
 
 @return 国家码
 */
+(NSString*)getCountryIso;

/**
 是否越狱
 
 @return  是否越狱
 */
+(NSString*)getJailbreak;

/**
 运营商名称

 @return 运营商名称
 */
+(NSString*)getcarrierName;

/**
 系统启动时间

 @return 系统启动时间
 */
+(NSString*)getSystemUptime;

/**
 电池还剩电量

 @return 电池还剩电量
 */
+(NSString*)getBatteryLevel;


/**
 App获取位置的方式

 @return App获取位置的方式
 */
+(NSString*)getAuthorizationStatus;


/**
 GPS状态

 @return GPS状态
 */
+(NSString*)getLocationServicesEnabled;

/**
  语言

 @return  语言
 */
+(NSString*)getPreferredLanguage;

/**
 时区

 @return 时区
 */
+(NSString*)getSystemTimeZone;

/**
 当前时间

 @return 当前时间（时间戳+毫秒）
 */
+(NSString*)getCurrentTime;

/**
 手机屏幕亮度

 @return 手机屏幕亮度
 */
+(NSString*)getBrightness;


/**
 手机电池状态

 @return 手机电池状态
 */
+(NSString*)getBatteryStatus;

/**
内核版本

 @return 内核版本
 */
+(NSString*)getKernelVersion;
@end
