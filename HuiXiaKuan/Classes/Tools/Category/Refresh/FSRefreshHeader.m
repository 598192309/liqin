//
//  FSRefreshHeader.m
//  
//
//  Created by lqq on 16/10/31.
//  Copyright © 2016年 lqq. All rights reserved.
//


#define kFSLoadingWidth   10.0
#import "FSRefreshHeader.h"
#import "BaseNavigationController.h"
@interface FSRefreshHeader ()
@property (nonatomic, weak) FSRefreshHeaderIndicaterView *indicaterView;
@property (nonatomic, weak) UIImageView *animationImageView;
@property (nonatomic, weak) UIImageView *normalImageView;

@end
@implementation FSRefreshHeader

#pragma mark - 懒加载子控件
- (UIImageView *)normalImageView
{
    if (!_normalImageView) {
        UIImageView *normalImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loadingBird01"]];
        [self addSubview:_normalImageView = normalImageView];
    }
    return _normalImageView;
}
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 90;
    
//    FSRefreshHeaderIndicaterView *indicaterView = [[FSRefreshHeaderIndicaterView alloc] init];
//    indicaterView.backgroundColor = [UIColor clearColor];
//    [self addSubview:indicaterView];
//    self.indicaterView = indicaterView;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    NSMutableArray *animationImages = [NSMutableArray array];
    for (int i = 3 ;  i<= 4; i++) {
        NSString *imageName = [NSString stringWithFormat:@"loadingBird%02d",i];
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            [animationImages addObject:image];
        }
    }
    imageView.animationImages = animationImages;
    imageView.animationDuration = 0.3;
    self.animationImageView  = imageView;
    self.animationImageView.contentMode = UIViewContentModeScaleAspectFit;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];

    self.indicaterView.frame = CGRectMake(0, 0,kFSLoadingWidth, kFSLoadingWidth);
    self.indicaterView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
    self.animationImageView.frame = CGRectMake(0, 0, 60, 60);
    self.animationImageView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
    
    self.normalImageView.frame = CGRectMake(0, 0, 60, 60);
    self.normalImageView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);

}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    NSValue *oldValue = change[NSKeyValueChangeOldKey];
    
    CGPoint oldpoint = [oldValue CGPointValue];
    NSValue * newValue = change[NSKeyValueChangeNewKey];
    CGPoint newpoint = [newValue CGPointValue];

    UITabBarController *rootVC  = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
//    switch (state) {
//        case MJRefreshStateIdle:
//            self.indicaterView.hidden = NO;
//            self.indicaterView.progress = 1;
//          
//            self.animationImageView.hidden = YES;
//            break;
//        case MJRefreshStatePulling:
//            [self.animationImageView stopAnimating];
//
//            self.indicaterView.hidden = NO;
//            self.animationImageView.hidden = NO;
//            self.animationImageView.image = [UIImage imageNamed:@"loadingBird01"];
//            
//            break;
//            
//
//        case MJRefreshStateRefreshing:
//            self.indicaterView.hidden = YES;
//            self.animationImageView.hidden = NO;
//            [self.animationImageView startAnimating];
//            break;
//        default:
//            break;
//    }
    
//    UITabBarController *rootVC  = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    MainNavigationController *payOffNavVC = (MainNavigationController *)rootVC.childViewControllers[rootVC.selectedIndex];
//    PayOffViewController *vc = [payOffNavVC.childViewControllers safeObjectAtIndex:0];
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            self.normalImageView.image = [UIImage imageNamed:@"loadingBird01"];
            
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.animationImageView.alpha = 0.0;
                

            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                
                self.animationImageView.alpha = 1.0;
                [self.animationImageView stopAnimating];

                self.normalImageView.hidden = NO;
                

            }];
        } else {
            [self.animationImageView stopAnimating];
            self.normalImageView.hidden = NO;
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.normalImageView.image = [UIImage imageNamed:@"loadingBird01"];
            }];
        }
    } else if (state == MJRefreshStatePulling) {
        [self.animationImageView stopAnimating];
        self.normalImageView.hidden = NO;
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            self.normalImageView.image = [UIImage imageNamed:@"loadingBird02"];
        }];
        
//        if ([self.vctarget isKindOfClass:[PayOffViewController class]] && payOffNavVC.navShadowImageView.hidden) {
//            
//            
//            payOffNavVC.navShadowImageView.hidden = NO;
//            payOffNavVC.navShadowImageView.alpha = 0.1;
//            
//        }
    } else if (state == MJRefreshStateRefreshing) {
        self.animationImageView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.animationImageView startAnimating];
        self.normalImageView.hidden = YES;
        
//        if ([self.vctarget isKindOfClass:[PayOffViewController class]] && payOffNavVC.navShadowImageView.hidden) {
//            
//            
//            payOffNavVC.navShadowImageView.hidden = NO;
//            payOffNavVC.navShadowImageView.alpha = 0.1;
//            
//        }
    }
    


}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
//    NSLog(@"%f",pullingPercent);
    self.indicaterView.progress = pullingPercent;

}


@end





@implementation FSRefreshHeaderIndicaterView



- (void)setProgress:(CGFloat)progress
{
    if (progress < 0) {
        progress = 0;
    } else if (progress > 1) {
        progress = 1;
    }
    CGFloat ratio = 0.5;
    if (progress < ratio) {
        progress = 0;
    } else {
        progress = (progress - ratio) / (1 - ratio);
    }
    _progress = progress;
    
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(rect.size.width / 2, rect.size.height / 2)];
    [path addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2) radius:rect.size.height / 2 startAngle:-M_PI / 2 endAngle:-(2*M_PI)*_progress - M_PI / 2 clockwise:NO];
//    [[UIColor greenColor] setFill];
    [path fill];
    
}



@end
