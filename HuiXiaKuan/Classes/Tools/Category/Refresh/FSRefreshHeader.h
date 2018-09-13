//
//  FSRefreshHeader.h
//  
//
//  Created by lqq on 16/10/31.
//  Copyright © 2016年 lqq. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface FSRefreshHeader : MJRefreshHeader
@property(nonatomic,strong)id vctarget;

@end



@interface FSRefreshHeaderIndicaterView : UIView
@property (nonatomic, assign) CGFloat progress;
@end
