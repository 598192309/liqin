//
//  LogModel.h
//  IUang
//
//  Created by jayden on 2018/4/25.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogModel : NSObject
/**
 无返回值;
 dict:传入要转模型的字典;
 modelName:将字典转成的模型类名
 注:Number也是用NSString来处理
 */
+ (void)modelToolWithDictionary:(NSDictionary *)dict modelName:(NSString *)modelName;

@end
