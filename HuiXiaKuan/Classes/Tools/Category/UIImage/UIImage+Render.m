//
//  UIImage+Render.m

//
//  Created by Lqq on 16/1/20.
//  Copyright © 2016年 Lqq. All rights reserved.
//

#import "UIImage+Render.h"

@implementation UIImage (Render)
+ (UIImage *)imageNamedWithOriginalImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <=0 || size.height <=0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imagewithImage:(UIImage *)image
{
    
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat redius = ((width <= height) ? width : height)/2;
    CGRect  rect = CGRectMake(width/2-redius, height/2-redius, redius*2, redius*2);
    
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newImage.size.width, newImage.size.height), NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(newImage.size.width/2, newImage.size.height/2) radius:redius startAngle:0 endAngle:M_PI*2 clockwise:0];
    [path addClip];
    [newImage drawAtPoint:CGPointZero];
    UIImage *imageCut = UIGraphicsGetImageFromCurrentImageContext();
    
    return imageCut;
    
    //    CGFloat width = image.size.width;
    //    CGFloat height = image.size.height;
    //    CGFloat redius = ((width <= height) ? width : height)/2;
    //    UIGraphicsBeginImageContext(image.size);
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextSetLineWidth(context, 2);
    //    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    //    CGRect  rect = CGRectMake(width/2-redius, height/2-redius, redius*2, redius*2);
    //    CGContextAddEllipseInRect(context, rect);
    //    CGContextClip(context);
    //
    //    [image drawInRect:rect];
    //    CGContextAddEllipseInRect(context, rect);
    //    CGContextStrokePath(context);
    //    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    return newimg;
    
    
}
@end
