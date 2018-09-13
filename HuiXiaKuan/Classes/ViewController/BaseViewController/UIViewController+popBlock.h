//
//  UIViewController+popBlock.h
//  IUang
//
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^PopBlock)(UIBarButtonItem *backItem);

@interface UIViewController (popBlock)
@property(nonatomic,copy)PopBlock popBlock;

@end
