//
//  StorageInfo.h
//  supermarket
//  当前存储大小，包括内存存储和磁盘存储
//  Created by jayden on 2018/1/21.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageInfo : NSObject

/**
 手机内存容量

 @return 系统总内存空间
 */
+(NSString*)getTotalMemory;

/**
 手机可用空间容量

 @return 磁盘空闲空间
 */
+(NSString*)getFreeDiskSpace;

/**
 手机总空间容量

 @return 磁盘总空间
 */
+(NSString*)getTotalDiskSpace;
@end
