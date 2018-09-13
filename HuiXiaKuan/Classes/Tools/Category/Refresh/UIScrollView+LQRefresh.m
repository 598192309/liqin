//
//  UIScrollView+LQRefresh.m
//  
//
//  Copyright © 2016年 lq. All rights reserved.
//

#import "UIScrollView+LQRefresh.h"
#import "FSRefreshHeader.h"
#import "BaseNavigationController.h"
#import <objc/runtime.h>
@interface UIScrollView()
@property(nonatomic,strong)id vctarget;


@end
@implementation UIScrollView (LQRefresh)
static id vctargetKey;
- (void)setVctarget:(id)vctarget{

    objc_setAssociatedObject(self, &vctargetKey, vctarget,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (id)vctarget{

    return objc_getAssociatedObject(self, &vctargetKey);
}
/**
 *  添加下拉刷新
 *
 *  @param block 回调
 */
- (void)addHeaderWithRefreshingBlock:(void(^)(void))block
{
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
//    header.lastUpdatedTimeLabel.hidden = YES;
//    self.mj_header = header;
    
    FSRefreshHeader *header = [FSRefreshHeader headerWithRefreshingBlock:block];
    self.mj_header = header;
}
- (void)addHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
//    header.lastUpdatedTimeLabel.hidden = YES;
//    header.stateLabel.hidden = YES;
//    self.mj_header = header;
    
    FSRefreshHeader *header = [FSRefreshHeader headerWithRefreshingTarget:target refreshingAction:action];
    self.vctarget = target;
    header.vctarget = self.vctarget;
    self.mj_header = header;
    
}
/**
 *  开始下拉刷新
 */
-(void)beginHeaderRefreshing
{
    [self.mj_header beginRefreshing];
    

}

/**
 *  结束下拉刷新
 */
- (void)endHeaderRefreshing
{
    [self.mj_header endRefreshing];
//    UITabBarController *rootVC  = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    MainNavigationController *payOffNavVC = (MainNavigationController *)rootVC.childViewControllers[rootVC.selectedIndex];
//    if ([self.vctarget isKindOfClass:[PayOffViewController class]]) {
//        
//        
//        payOffNavVC.navShadowImageView.hidden = payOffNavVC.navShadowImageView.hidden;
//        payOffNavVC.navShadowImageView.alpha = 0.1;
//        
//        
//    }
}


/**
 *  添加上拉刷新
 *
 *  @param block 回调
 */
- (void)addFooterWithRefreshingBlock:(void(^)(void))block
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:block];
    footer.automaticallyHidden = YES;
    self.mj_footer = footer;
}
- (void)addFooterWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    footer.automaticallyHidden = YES;
    self.mj_footer = footer;
}

/**
 *  结束上拉刷新
 */
- (void)endFooterRefreshing
{
    [self.mj_footer endRefreshing];
}

/**
 *  没有更多数据
 */
- (void)endRefreshingWithNoMoreData
{
    [self.mj_footer endRefreshingWithNoMoreData];
}
@end
