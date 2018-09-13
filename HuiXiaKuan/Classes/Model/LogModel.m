//
//  LogModel.m
//  IUang
//
//  Created by jayden on 2018/4/25.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "LogModel.h"

@implementation LogModel
+ (void)modelToolWithDictionary:(NSDictionary *)dict modelName:(NSString *)modelName{
    printf("\n@interface %s : NSObject\n",modelName.UTF8String);
    
    for (NSString *key in dict) {
        if ([dict[key] isKindOfClass:[NSString class]]) { // 字符串类型
            NSString *type = @"NSString";
            printf("@property (nonatomic,strong) %s *%s;\n",type.UTF8String,key.UTF8String);
        }else if ([dict[key] isKindOfClass:[NSNull class]]){ // 空类型
            NSString *type = @"NSString";
            printf("@property (nonatomic,strong) %s *%s;  //null类型 \n",type.UTF8String,key.UTF8String);
        } else if ([dict[key] isKindOfClass:[NSArray class]]){ // 数组类型
            NSString *type = @"NSArray";
            printf("@property (nonatomic,strong) %s *%s;\n",type.UTF8String,key.UTF8String);
        }else if ([dict[key] isKindOfClass:[NSDictionary class]]){ // 字典类型
            NSString *type = @"NSDictionary";
            printf("@property (nonatomic,strong) %s *%s;\n",type.UTF8String,key.UTF8String);
        }
        
        else if ([dict[key] isKindOfClass:[NSNumber class]]) { //NSNumber
            NSNumber *number = (NSNumber *)dict[key];
            if (strcmp(number.objCType, @encode(int)) == 0) {
                printf("@property (nonatomic,assign) NSInteger %s;\n",key.UTF8String);
            }else if (strcmp(number.objCType, @encode(Boolean)) == 0) {
                printf("@property (nonatomic,assign) BOOL %s;\n",key.UTF8String);
            }else if (strcmp(number.objCType, @encode(float)) == 0) {
                printf("@property (nonatomic,assign) CGFloat %s;\n",key.UTF8String);
            }else if (strcmp(number.objCType, @encode(double)) == 0) {
                printf("@property (nonatomic,assign) double %s;\n",key.UTF8String);
            }else if (strcmp(number.objCType, @encode(long)) == 0) {
                printf("@property (nonatomic,assign) long %s;\n",key.UTF8String);
            }
        }else if ([dict[key] isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
            printf("@property (nonatomic,assign) BOOL %s;\n",key.UTF8String);
        }
        
//        else if ([dict[key] isKindOfClass:[NSNumber class]]){   // 整形
//            //            NSString *type = @"NSNumber";
//            //            printf("@property (nonatomic,assign) %s *%s;\n",type.UTF8String,key.UTF8String);
//            // 整形也用字符串接收
//            NSString *type = @"NSString";
//            printf("@property (nonatomic,copy) %s *%s;\n",type.UTF8String,key.UTF8String);
//        }
    }
    
    
    printf("@end\n");
}

@end
