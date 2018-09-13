//
//  GIFImage.m
//  RabiBird
//
//  Created by jayden on 2018/3/27.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "GIFImage.h"
#import "UIImage+GIF.h"
@implementation GIFImage
+ (GIFImage *)shareInstance{
    static GIFImage *shareManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[GIFImage alloc] init];
//        NSString * path = [[NSBundle mainBundle]pathForResource:@"loading" ofType:@"gif"];
//        NSData * data = [NSData dataWithContentsOfFile:path];
//        UIImage * image =   [UIImage sd_animatedGIFWithData:data];
//        shareManager.gifImage = image;
        shareManager.gifImage = [UIImage sd_animatedGIFNamed:@"loading"];
    });
    return shareManager;
}
@end
