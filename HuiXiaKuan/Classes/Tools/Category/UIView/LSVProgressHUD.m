//
//  LSVProgressHUD.m
//  xskj
//
//  Created by 黎芹 on 16/5/9.
//  Copyright © 2016年 lq. All rights reserved.
//

#import "LSVProgressHUD.h"
#import "GIFImage.h"
@implementation LSVProgressHUD

+ (void)load{
//    [self setMinimumDismissTimeInterval:1.0];
    [self setMinimumDismissTimeInterval:MAXFLOAT];
    
    [self setDefaultStyle:SVProgressHUDStyleCustom];
    
//    [self setBackgroundLayerColor:[UIColor colorWithHexString:viewBackgroundColor alpha:1.0]];
    [self setForegroundColor:[UIColor blackColor]];
    //设置不可交换 
//    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    //设置可交互
    [LSVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [self setInfoImage:nil];
    
    [self setDefaultStyle:SVProgressHUDStyleDark];
}

+ (void)showError:(NSError *)error{
    NSString *errStr = [error.userInfo safeObjectForKey:@"errorMsg"];
    if (errStr.length > 0 && ![errStr isEqualToString:NSLocalizedString(@"任务被取消", nil)]  && ![errStr isEqualToString:NSLocalizedString(@"已取消", nil)] && ![errStr containsString:NSLocalizedString(@"如非本人操作", nil)]) {
        [self showInfoWithStatus:[error.userInfo safeObjectForKey:@"errorMsg"]];
        [self dismissTime];
    }else{
        [self dismiss];
    }
}
+(void)showGIFImage{
    [SVProgressHUD showImage:[[GIFImage shareInstance] gifImage] status:nil];
}
+(void)showInfoWithStatus:(NSString *)status{
    [super showInfoWithStatus:status];
    [self dismissTime];
}
+(void)showWithStatus:(NSString *)status{
    [super showWithStatus:status];
    [self dismissTime];
}
+(void)showErrorWithStatus:(NSString *)status{
    [super showErrorWithStatus:status];
    [self dismissTime];
}
+(void)dismissTime{
    [self dismissWithDelay:1.f];
}
@end
