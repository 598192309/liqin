//
//  ProjectInfo.m
//  supermarket
//  
//  Created by jayden on 2018/1/21.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "ProjectInfo.h"
#import <UIKit/UIDevice.h>

@implementation ProjectInfo
//当前项目版本
+ (NSString *)getProjectVersion{
  // 获取最新的版本号
  NSDictionary *dictInfoDictionary =  [NSBundle mainBundle].infoDictionary;
  NSString *appVersion = dictInfoDictionary[@"CFBundleShortVersionString"];
  return appVersion;
}
//包名
+(NSString*)getBundleId{
  return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}
@end
