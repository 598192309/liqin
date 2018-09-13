//
//  AboutCustomView.h
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/4.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AboutItem;
@interface AboutCustomView : UIView
- (void)configUIWithItem:(AboutItem *)item finishi:(void(^)())finishBlock;
@end
