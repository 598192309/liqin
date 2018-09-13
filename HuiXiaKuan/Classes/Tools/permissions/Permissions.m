//
//  Permissions.m
//  IUang
//
//  Created by jayden on 2018/6/5.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "Permissions.h"
//权限
#import <AddressBookUI/AddressBookUI.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@implementation Permissions
+(BOOL)permissions{
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    if (status != kABAuthorizationStatusAuthorized) {//通讯录
        return NO;
    }
    CLAuthorizationStatus statu = [CLLocationManager authorizationStatus];//定位
    if (statu == kCLAuthorizationStatusAuthorizedAlways || statu == kCLAuthorizationStatusAuthorizedWhenInUse){
    }else{
        return NO;
    }
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0); //创建信号量
    __block BOOL notificationBool = YES;
    
    if (@available(iOS 10 , *)){//推送
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            
            if (settings.authorizationStatus != UNAuthorizationStatusAuthorized){
                notificationBool = NO;
            }
            dispatch_semaphore_signal(semaphore);   //发送信号
        }];
    }
    else if (@available(iOS 8 , *)){
        UIUserNotificationSettings * setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (setting.types == UIUserNotificationTypeNone) {
            return NO;
        }
    }
    else{
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if (type == UIUserNotificationTypeNone) {
            return NO;
        }
    }
    
    if (@available(iOS 10 , *)){
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);  //等待
    }
    return notificationBool;
}
@end
