//

//

#define UserDefaults [NSUserDefaults standardUserDefaults]
#import "SaveTool.h"

@implementation SaveTool

+ (id)objectForKey:(NSString *)defaultName
{
    return [UserDefaults objectForKey:defaultName];
}

+ (void)setObject:(id)value forKey:(NSString *)defaultName
{
     [UserDefaults setObject:value forKey:defaultName];
}

@end
