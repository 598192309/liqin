//
//  NetWorkInfo.m
//  supermarket
//
//  Created by jayden on 2018/1/21.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NetWorkInfo.h"
//网络WiFi SSID 是否开启代理
#import <SystemConfiguration/CaptiveNetwork.h>
//移动 mcc mnc
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
// mac地址需要导入的头文件
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
// WIFI的IP和子网掩码
#import <ifaddrs.h>
#import <arpa/inet.h>
// 网络类型
#import "Reachability.h"
//获取本机DNS服务器
#import "resolv.h"

@implementation NetWorkInfo
//BSSID
+(NSString*)getBSSID{
  return [self standardFormateMAC:[[self fetchSSIDInfo] objectForKey:@"BSSID"]];
}
//SSID
+(NSString*)getSSID{
  return [[self fetchSSIDInfo] objectForKey:@"SSID"];
}
//MCC
+(NSString*)getMCC{
  CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
  CTCarrier *carrier = [netInfo subscriberCellularProvider];
  NSString *mcc = [carrier mobileCountryCode];
  return mcc ? mcc : @"";
}
//MNC
+(NSString*)getMNC{
  CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
  CTCarrier *carrier = [netInfo subscriberCellularProvider];
  NSString *mnc = [carrier mobileNetworkCode];
  return mnc ? mnc : @"";
}
//网卡mac地址
+(NSString*)getMacAddress{
  int                    mib[6];
  size_t                len;
  char                *buf;
  unsigned char        *ptr;
  struct if_msghdr    *ifm;
  struct sockaddr_dl    *sdl;
  mib[0] = CTL_NET;
  mib[1] = AF_ROUTE;
  mib[2] = 0;
  mib[3] = AF_LINK;
  mib[4] = NET_RT_IFLIST;
  if ((mib[5] = if_nametoindex("en0")) == 0) {
    printf("Error: if_nametoindex error/n");
    return NULL;
  }
  if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
    printf("Error: sysctl, take 1/n");
    return NULL;
  }
  if ((buf = malloc(len)) == NULL) {
    printf("Could not allocate memory. error!/n");
    return NULL;
  }
  if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
    printf("Error: sysctl, take 2");
    return NULL;
  }
  ifm = (struct if_msghdr *)buf;
  sdl = (struct sockaddr_dl *)(ifm + 1);
  ptr = (unsigned char *)LLADDR(sdl);
  NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
  free(buf);
  return [outstring uppercaseString];
}
//WIfiIp
+(NSString*)getWifiIp{
  return [[self getCurrentLocalIP] objectForKey:@"wifiIp"];
}
//WIFI子网掩码
+(NSString*)getWiftNetmask{
  return [[self getCurrentLocalIP] objectForKey:@"wifiNetmask"];
}
//网络类型
+(NSString*)getNetconnType{
  NSString *netconnType = @"";
  Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
  switch ([reach currentReachabilityStatus]) {
    case NotReachable:{// 没有网络
      netconnType = @"no network";
    }
      break;
    case ReachableViaWiFi:{// Wifi
      netconnType = @"Wifi";
    }
      break;
    case ReachableViaWWAN:{// 手机自带网络
      [self getRadioType];
    }
      break;
    default:
      break;
  }
  return netconnType;
}
+(NSString*)getRadioType{
  NSString *netconnType = @"";
  // 获取手机网络类型
  CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
  NSString *currentStatus = info.currentRadioAccessTechnology;
  if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
    netconnType = @"GPRS";
  }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
    netconnType = @"2.75G EDGE";
  }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
    netconnType = @"3G";
  }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
    netconnType = @"3.5G HSDPA";
  }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
    netconnType = @"3.5G HSUPA";
  }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
    netconnType = @"2G";
  }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
    netconnType = @"3G";
  }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
    netconnType = @"3G";
  }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
    netconnType = @"3G";
  }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
    netconnType = @"HRPD";
  }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
    netconnType = @"4G";
  }
  return netconnType;
}

//网卡名称
+(NSString*)getIpAddresses{
  NSString * networkNames = @"";
  struct ifaddrs *interfaces = NULL;
  struct ifaddrs *temp_addr = NULL;
  @try {
    // retrieve the current interfaces - returns 0 on success
    NSInteger success = getifaddrs(&interfaces);
    //NSLog(@"%@, success=%d", NSStringFromSelector(_cmd), success);
    if (success == 0) {
      // Loop through linked list of interfaces
      temp_addr = interfaces;
      while(temp_addr != NULL) {
        if(temp_addr->ifa_addr->sa_family == AF_INET) {
          // Get NSString from C String
          NSString* ifaName = [NSString stringWithUTF8String:temp_addr->ifa_name];
          //          NSString* address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_addr)->sin_addr)];
          //          NSString* mask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_netmask)->sin_addr)];
          //          NSString* gateway = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_dstaddr)->sin_addr)];
          networkNames = ifaName;
        }
        temp_addr = temp_addr->ifa_next;
      }
    }
  }
  @catch (NSException *exception) {
    NSLog(@"Exception: %@", exception);
  }
  @finally {
    // Free memory
    freeifaddrs(interfaces);
  }
  return networkNames;
}
//是否打开代理
+(NSString*)getIsProxyType{
  NSString * proxyType = @"0";
  CFDictionaryRef proxySettings = CFNetworkCopySystemProxySettings();
  NSDictionary *dictProxy = (__bridge_transfer id)proxySettings;
  //是否开启了http代理
  if ([[dictProxy objectForKey:@"HTTPEnable"] boolValue]) {
    //    NSString *proxyAddress = [dictProxy objectForKey:@"HTTPProxy"]; //代理地址
    //    NSInteger proxyPort = [[dictProxy objectForKey:@"HTTPPort"] integerValue];  //代理端口号
    //    NSLog(@"%@:%ld",proxyAddress,(long)proxyPort);
    proxyType = @"1";
  }
  return @"0";
}
//DNS
+(NSString*)getOutPutDNSServers{
  //导入 libresolv.dylib或libresolv.9.dylib
  res_state res = malloc(sizeof(struct __res_state));
  int result  = res_ninit(res);
  NSMutableArray *dnsArray = @[].mutableCopy;
  if ( result == 0 ){
    for ( int i = 0; i < res->nscount; i++ )  {
      NSString *s = [NSString stringWithUTF8String :  inet_ntoa(res->nsaddr_list[i].sin_addr)];
      [dnsArray addObject:s];
    }
  }
  else{
    NSLog(@"%@",@" res_init result != 0");
  }
  res_nclose(res);
  return [dnsArray componentsJoinedByString:@","];//分隔符逗号
}
//IP地址
+(NSString*)getIPAddress{
  NSError *error;
  NSURL *ipURL = [NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"];
  NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
  //判断返回字符串是否为所需数据
  if ([ip hasPrefix:@"var returnCitySN = "]) {
    //对字符串进行处理，然后进行json解析
    //删除字符串多余字符串
    NSRange range = NSMakeRange(0, 19);
    [ip deleteCharactersInRange:range];
    NSString * nowIp =[ip substringToIndex:ip.length-1];
    //将字符串转换成二进制进行Json解析
    NSData * data = [nowIp dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return [dict objectForKey:@"cip"];
  }
  return @"";
}




// WIFI的IP和子网掩码
+ (NSDictionary*)getCurrentLocalIP{
  NSString *address = nil;
  
  NSString *wifiNetmask = @"";
  
  struct ifaddrs *interfaces = NULL;
  struct ifaddrs *temp_addr = NULL;
  int success = 0;
  // retrieve the current interfaces - returns 0 on success
  success = getifaddrs(&interfaces);
  if (success == 0) {
    // Loop through linked list of interfaces
    temp_addr = interfaces;
    while(temp_addr != NULL) {
      if(temp_addr->ifa_addr->sa_family == AF_INET) {
        // Check if interface is en0 which is the wifi connection on the iPhone
        if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
          // Get NSString from C String
          address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];//WIFI的IP
          wifiNetmask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)];//WIFI子网掩码
        }
      }
      temp_addr = temp_addr->ifa_next;
    }
  }
  // Free memory
  freeifaddrs(interfaces);
  return @{@"wifiIp":address ? address : @"",@"wifiNetmask":wifiNetmask ? wifiNetmask : @""};
}

//获取SSID的字典
+ (id)fetchSSIDInfo {
  NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
  id info = nil;
  for (NSString *ifnam in ifs) {
    info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
    //    NSLog(@"%@ => %@", ifnam, info);  //单个数据info[@"SSID"]; info[@"BSSID"];
    if (info && [info count]) { break; }
  }
  return info;
}
//BSSID 正确格式是 00:04:c3:a1:2b:22 但是输出以后却是0:4:c3:a1:2b:22 少了头0，可用一下方法补0
+ (NSString *)standardFormateMAC:(NSString *)MAC {
  NSArray * subStr = [MAC componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":-"]];
  NSMutableArray * subStr_M = [[NSMutableArray alloc] initWithCapacity:0];
  for (NSString * str in subStr) {
    if (1 == str.length) {
      NSString * tmpStr = [NSString stringWithFormat:@"0%@", str];
      [subStr_M addObject:tmpStr];
    } else {
      [subStr_M addObject:str];
    }
  }
  NSString * formateMAC = [subStr_M componentsJoinedByString:@":"];
  return [formateMAC uppercaseString];
}
@end
