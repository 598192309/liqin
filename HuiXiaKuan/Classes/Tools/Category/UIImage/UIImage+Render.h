//
//  UIImage+Render.h
//
//  Created by Lqq on 16/1/20.
//  Copyright © 2016年 Lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Render)
+ (UIImage *)imageNamedWithOriginalImage:(NSString *)name;



// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

//将图片截成圆形图片
+ (UIImage *)imagewithImage:(UIImage *)image;
@end
