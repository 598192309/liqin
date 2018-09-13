//
//  XMGSaveTool.h

//  存储业务

#import <Foundation/Foundation.h>

@interface SaveTool : NSObject



//  读取
+ (id)objectForKey:(NSString *)defaultName;

//  存储
+ (void)setObject:(id)value forKey:(NSString *)defaultName;

@end
