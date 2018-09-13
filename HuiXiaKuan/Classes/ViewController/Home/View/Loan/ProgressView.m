//
//  ProgressView.m
//  IUang
//
//  Created by Lqq on 2018/4/19.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "ProgressView.h"
@interface ProgressView()
{
    UIView *viewTop;
    UIView *viewBottom;
    UILabel *tipLabel;

    CGFloat beginFloat;
}
@property (nonatomic, strong) NSTimer *timer;

@end
@implementation ProgressView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self configUI];
        
    }
    return self;
}
- (void)configUI
{
    
    viewBottom = [[UIView alloc]initWithFrame:self.bounds];
    viewBottom.backgroundColor =  [UIColor colorWithHexString:@"1b91c2"];
    //添加右边两个圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:viewBottom.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(20 * 0.5, 20 * 0.5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = viewBottom.bounds;
    maskLayer.path = maskPath.CGPath;
    viewBottom.layer.mask = maskLayer;
    [self addSubview:viewBottom];
    viewTop = [[UIView alloc]initWithFrame:CGRectMake(-10, 0, 0, viewBottom.frame.size.height)];
    viewTop.backgroundColor = [UIColor whiteColor];
    ViewRadius(viewTop, 10);

    [viewBottom addSubview:viewTop];
    
    tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(-10, 0, 0, viewBottom.frame.size.height)];
    [viewTop addSubview:tipLabel];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor colorWithHexString:@"222020"];
    tipLabel.font = AdaptedFontSize(15);

}

- (void)dealloc{
    
}

-(void)setTime:(float)time
{
    _time = time;
}
-(void)setProgressValue:(NSString *)progressValue
{
    if (!_time) {
        _time = 1.0f;
    }
    _progressValue = progressValue;
    [UIView animateWithDuration:_time animations:^{
        viewTop.frame = CGRectMake(viewTop.frame.origin.x, viewTop.frame.origin.y, (viewBottom.frame.size.width)*[progressValue floatValue] + 10, viewTop.frame.size.height);

        

    } completion:^(BOOL finished) {
    }];
    
    if ([progressValue floatValue] > 0) {
        [self.timer fireDate];
    }



}


-(void)setBottomColor:(UIColor *)bottomColor
{
    _bottomColor = bottomColor;
    viewBottom.backgroundColor = bottomColor;
}

-(void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;
    viewTop.backgroundColor = progressColor;
}


- (NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(freshTipLabel) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}
- (void)setTotalNum:(NSInteger)totalNum{
    _totalNum = totalNum;
}

- (void)freshTipLabel{
    beginFloat += ([_progressValue floatValue] / 10.0);
    if (beginFloat >= [_progressValue floatValue]) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
//    tipLabel.text = [NSString stringWithFormat:@"%.0f人",beginFloat * _totalNum];
    tipLabel.text = [NSString stringWithFormat:@"%ld人",(long)_progressNum];

    [tipLabel sizeToFit];
    CGFloat w = [tipLabel sizeThatFits:CGSizeMake(MAXFLOAT, viewBottom.frame.size.height)].width;
    tipLabel.lq_x = (( (viewBottom.frame.size.width)*[_progressValue floatValue] + 10 - w ) * 0.5 ) * beginFloat + 10;
    

}

/**恢复之前初始状态*/
- (void)recover{
    self.totalNum = 0;
    beginFloat = 0.0;
    self.progressValue = @"0";
    tipLabel.lq_x = -10;
    
}

- (void)setWidthW:(float)widthW{
    viewBottom.lq_width = widthW;


    
}
@end
