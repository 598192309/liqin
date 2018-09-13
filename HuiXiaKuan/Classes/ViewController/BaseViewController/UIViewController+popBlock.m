//
//  UIViewController+popBlock.m
//  IUang
//
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "UIViewController+popBlock.h"
#import <objc/runtime.h>
static char popBlockKey;

@implementation UIViewController (popBlock)
-(void)setPopBlock:(PopBlock)popBlock{
    objc_setAssociatedObject(self, &popBlockKey, popBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(PopBlock)popBlock{
    
    PopBlock popBlock = objc_getAssociatedObject(self, &popBlockKey);
    
    return popBlock;
}

@end
