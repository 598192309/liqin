//
//  StorageInfo.m
//  supermarket
//
//  Created by jayden on 2018/1/21.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "StorageInfo.h"

@implementation StorageInfo
//手机内存容量
+(NSString*)getTotalMemory{
  int64_t totalMemory = [[NSProcessInfo processInfo] physicalMemory];
  if (totalMemory < -1) totalMemory = -1;
  return @(totalMemory).stringValue;
}
//手机可用空间容量
+(NSString*)getFreeDiskSpace{
  NSError *error = nil;
  NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
  if (error) return @(-1).stringValue;
  int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
  if (space < 0) space = -1;
  return @(space).stringValue;
}
//手机总空间容量
+(NSString*)getTotalDiskSpace{
  NSError *error = nil;
  NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
  if (error) return @(-1).stringValue;
  int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
  if (space < 0) space = -1;
  return @(space).stringValue;
}
@end
