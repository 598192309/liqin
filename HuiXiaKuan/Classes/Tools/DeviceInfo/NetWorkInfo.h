//
//  NetWorkInfo.h
//  supermarket
//  网络信息
//  Created by jayden on 2018/1/21.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkInfo : NSObject
/**
 BSSID

 @return BSSID
 */
+(NSString*)getBSSID;
/**
 SSID

 @return SSID
 */
+(NSString*)getSSID;

/**
 MCC

 @return 移动国家代码
 */
+(NSString*)getMCC;

/**
 MNC

 @return 移动网络码
 */
+(NSString*)getMNC;

/**
 mac

 @return 网卡mac地址
 */
+(NSString*)getMacAddress;

/**
 wifiIp

 @return wifiIp
 */
+(NSString*)getWifiIp;
/**
  WIFI子网掩码

 @return  WIFI子网掩码
 */
+(NSString*)getWiftNetmask;

/**
 网络类型

 @return 网络类型
 */
+(NSString*)getNetconnType;

/**
 无线类型

 @return 无线类型
 */
+(NSString*)getRadioType;

/**
 网卡名称

 @return 网卡名称
 */
+(NSString*)getIpAddresses;

/**
 是否打开代理

 @return 是否打开代理
 */
+(NSString*)getIsProxyType;

/**
 DNS

 @return DNS
 */
+(NSString*)getOutPutDNSServers;

/**
 IP地址

 @return IP地址
 */
+(NSString*)getIPAddress;
@end
