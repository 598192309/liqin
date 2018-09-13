//
//  ProjectInfo.h
//  supermarket
//  查看当前项目信息
//  Created by jayden on 2018/1/21.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectInfo : NSObject

/**
 得到当前项目版本

 @return 当前版本
 */
+ (NSString *)getProjectVersion;

/**
 包名

 @return 包名
 */
+(NSString*)getBundleId;

@end
