//
//  UIScrollView+LQRefresh.h
//  
//
//  Copyright © 2016年 lq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@interface UIScrollView (LQRefresh)
/**
 *  添加下拉刷新
 *
 *  @param block 回调
 */
- (void)addHeaderWithRefreshingBlock:(void(^)(void))block;
- (void)addHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/**
 *  开始下拉刷新
 */
-(void)beginHeaderRefreshing;

/**
 *  结束下拉刷新
 */
- (void)endHeaderRefreshing;


/**
 *  添加上拉刷新
 *
 *  @param block 回调
 */
- (void)addFooterWithRefreshingBlock:(void(^)(void))block;
- (void)addFooterWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/**
 *  结束上拉刷新
 */
- (void)endFooterRefreshing;

/**
 *  没有更多数据
 */
- (void)endRefreshingWithNoMoreData;
@end
