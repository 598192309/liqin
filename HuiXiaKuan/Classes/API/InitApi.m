//
//  InitApi.m
//  IUang
//
//  Created by jayden on 2018/4/24.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "InitApi.h"
#import "InitModel.h"
#import "ProjectInfo.h"
#import "StorageInfo.h"
#import "NetWorkInfo.h"
#import "DeviceInfo.h"
@implementation InitApi
+ (NetworkTask *)initialWithLat:(NSString *)lat  lang:(NSString *)lang accuracy:(NSString *)accuracy success:(void(^)(NSString *msg,NSInteger status, NSString *authorization))successBlock error:(ErrorBlock)errorBlock
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setValue:@"iOS" forKey:@"client_type"]; // 每个客户端类型都必须带这个标识
    
    [dict setValue:[ProjectInfo getProjectVersion] forKey:@"appVersion"];// 客户端的版本号
    
    [dict setValue:[StorageInfo getTotalMemory] forKey:@"memory"];//手机内存容量  系统总内存空间
    [dict setValue:[StorageInfo getFreeDiskSpace] forKey:@"freeSpace"];// 手机可用空间容量 磁盘空闲空间
    [dict setValue:[StorageInfo getTotalDiskSpace] forKey:@"totalSpace"];// 手机总空间容量 磁盘总空间
    
    [dict setValue:[NetWorkInfo getBSSID] forKey:@"bssid"];// wifi接入热点的设备的mac地址 F0:B4:29:8D:56:B9
    [dict setValue:[NetWorkInfo getBSSID] forKey:@"ssid"];// 无线SSID F0:B4:29:8D:56:B9
    
    [dict setValue:[NetWorkInfo getMCC] forKey:@"mcc"];// 移动国家代码 460
    [dict setValue:[NetWorkInfo getMNC] forKey:@"mnc"];// 移动网络码 00
    
    [dict setValue:[DeviceInfo getDeviceId] forKey:@"deviceId"];// 设备ID 1260456C-7648-4A22-80FD-A0B8B8DC882B
    [dict setValue:[DeviceInfo getUUID] forKey:@"uuid"];
    [dict setValue:[DeviceInfo getIDFV] forKey:@"idfv"];// 手机生产商的标识码 8B764CDF-A573-44BA-B71E-534B480384D1
    
    [dict setValue:[DeviceInfo getDeviceName] forKey:@"deviceName"];// 设备名称 iPhone
    
    [dict setValue:[NetWorkInfo getMacAddress] forKey:@"mac"];// 网卡mac地址 02:00:00:00:00:00
    
    [dict setValue:[DeviceInfo getMachineToIdevice] forKey:@"platform"];// 平台名称 无需转换，统一由后台处理 iPhone7,2
    
    [dict setValue:[DeviceInfo getSystemVersion] forKey:@"osVersion"];// 系统版本 11.1.2
    
    [dict setValue:[NetWorkInfo getWifiIp] forKey:@"wifiIp"];// WIFI的IP 192.168.31.180
    [dict setValue:[NetWorkInfo getWiftNetmask] forKey:@"wifiNetmask"]; // WIFI子网掩码 255.255.255.0
    
    [dict setValue:[DeviceInfo getCountryIso] forKey:@"countryIso"];// 国家码 CN
    
    [dict setValue:[DeviceInfo getJailbreak] forKey:@"jailbreak"];// 是否越狱 0
    
    [dict setValue:[NetWorkInfo getNetconnType] forKey:@"networkType"];// 网络类型 Wifi
    
    [dict setValue:[DeviceInfo getcarrierName] forKey:@"carrier"];// 运营商名称 中国移动
    
    [dict setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"StartTime"] forKey:@"timeCost" ]; // App启动时间 1.1105760335922241
    [dict setValue:[DeviceInfo getSystemUptime] forKey:@"bootTime"];// 系统启动时间 1516171572
    
    [dict setValue:[DeviceInfo getBatteryLevel] forKey:@"batteryLevel"];// 电池还剩电量
    
    [dict setValue:[DeviceInfo getAuthorizationStatus] forKey:@"gpsAuthStatus"];// App获取位置的方式
    
    [dict setValue:[DeviceInfo getLocationServicesEnabled] forKey:@"gpsSwitch"];// GPS状态
    
    [dict setValue:@"iOS" forKey:@"os"];// 手机系统
    
    [dict setValue:[NetWorkInfo getIpAddresses] forKey:@"networkNames"];// 网卡名称 en2
    
    [dict setValue:[DeviceInfo getPreferredLanguage] forKey:@"languages"];// 语言 zh-Hans-CN
    
    [dict setValue:[NetWorkInfo getIsProxyType] forKey:@"proxyType"];// 代理 0
    [dict setValue:[NetWorkInfo getOutPutDNSServers] forKey:@"dns"];// DNS 114.114.115.115,114.114.114.114
    
    [dict setValue:[ProjectInfo getBundleId] forKey:@"bundleId"];// APP的包名 org.reactjs.native.example.supermarket
    
    [dict setValue:[DeviceInfo getSystemTimeZone] forKey:@"timeZone"];// 时区
    
    [dict setValue:[DeviceInfo getCurrentTime] forKey:@"currentTime"];
    
    [dict setValue:[DeviceInfo getBrightness] forKey:@"brightness"];// 手机屏幕亮度
    
    [dict setValue:[DeviceInfo getBatteryStatus] forKey:@"batteryStatus"];// 手机电池状态
    
    [dict setValue:[DeviceInfo getKernelVersion] forKey:@"kernelVersion"];// 内核版本
    
    [dict setValue:[NetWorkInfo getRadioType] forKey:@"radioType"];// 无线类型
    [dict setValue:@"" forKey:@"tureIP"];// IP地址
    
    NSDictionary *langDict = @{@"lat":SAFE_NIL_STRING(lat),
                               @"lang":SAFE_NIL_STRING(lang),
                               @"accuracy":accuracy,
                               @"time":[DeviceInfo getCurrentTime]};
    [dict setValue:langDict forKey:@"gpsLocation"];// 经纬度、高度和GPS时间戳


    return  [NET POST:@"/api/token" parameters:@{@"device_info":dict} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {

            NSString * msg = [resultObject safeObjectForKey:@"msg"];
            NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
            NSString *authorization = [[resultObject safeObjectForKey:@"data"] safeObjectForKey:@"authorization"];
        

           if (!(authorization.length > 0)) {
               if (msg.length == 0) {
                   msg = NSLocalizedString(@"异常了，请重新打开APP", nil);
               }
               UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:msg preferredStyle:UIAlertControllerStyleAlert];
               
               [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                   exit(0);
                   
               }]];
               AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
               [delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
           }

        if (![authorization isEqualToString:RI.authorization] && authorization.length > 0  ) {
            RI.authorization = authorization;
            [[NSUserDefaults standardUserDefaults] setObject:authorization forKey:KAuthorization];
        }
    
           if (successBlock) {
               successBlock(msg,status,authorization);
               
           }
       } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
           if (errorBlock) {
               errorBlock(error,resultObject);
           }
           if ([[resultObject safeObjectForKey:@"status"] integerValue] == 0) {
               NSString * msg = [resultObject safeObjectForKey:@"msg"];
               if (msg.length == 0) {
                   msg = NSLocalizedString(@"异常了，请重新打开APP", nil);
               }
               UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:msg preferredStyle:UIAlertControllerStyleAlert];
               
               [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                   //                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"labiniao2017://"]];
                   exit(0);
               }]];
               AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
               [delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
           }
       }];
    
}



@end
