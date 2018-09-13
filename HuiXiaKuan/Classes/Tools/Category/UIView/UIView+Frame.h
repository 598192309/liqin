//
//  UIView+Frame.h
//
//  Created by xmg on 16/1/18.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property CGFloat lq_x;
@property CGFloat lq_y;
@property CGFloat lq_width;
@property CGFloat lq_height;
@property CGFloat lq_centerX;
@property CGFloat lq_centerY;
@property CGFloat lq_bottom;
//@property CGFloat lq_top;

@property CGFloat lq_right;
/**设置cornerRadius*/
- (void)setLayerCornerRadius:(CGFloat)cornerRadius;
@end
