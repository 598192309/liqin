//
//  LoanConfirmationExtendView.m
//  RabiBird
//
//  Created by Lqq on 2018/7/23.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "LoanConfirmationExtendView.h"
#import "ProgressView.h"
#import "UICountingLabel.h"
#import "HomeModel.h"

@interface LoanConfirmationExtendView()
@property (nonatomic,strong) UIView * backgroundView;

@property (nonatomic,strong) UIView * topView;
@property (nonatomic,strong) UILabel * moneyTipLabel;
@property (nonatomic,strong) UILabel * moneyLabel;
@property (nonatomic,strong) UILabel * rateTipLabel;
@property (nonatomic,strong) UILabel * rateLabel;
@property (nonatomic,strong) UILabel * xiakuanNumTipLabel;
@property (nonatomic,strong) UILabel * xiakuanNumLabel;
@property (nonatomic,strong) UILabel * shenqingNumTipLabel;
@property (nonatomic,strong) UILabel * shenqingNumLabel;
@property (nonatomic,strong) UILabel * maxMoneyLabel;
@property (nonatomic, strong) UILabel * maxMoneyOwnerLabel;
@property (nonatomic, strong) UIButton * showBtn;


@property (nonatomic,strong) UIView * bottomView;
@property (nonatomic,strong) UILabel * bottomView_TipLabel;
@property (nonatomic,strong) UILabel * bottomView_moneyTipLabel1;
@property (nonatomic,strong) UILabel * bottomView_moneyTipLabel2;
@property (nonatomic,strong) UILabel * bottomView_moneyTipLabel3;
@property (nonatomic,strong) ProgressView * progressView1;
@property (nonatomic,strong) ProgressView * progressView2;
@property (nonatomic,strong) ProgressView * progressView3;
@property (nonatomic,strong) UICountingLabel * bottomView_PercentLabel1;
@property (nonatomic,strong) UICountingLabel * bottomView_PercentLabel2;
@property (nonatomic,strong) UICountingLabel * bottomView_PercentLabel3;
@property (nonatomic,strong) UILabel * bottomView_PercentCharLabel1;
@property (nonatomic,strong) UILabel * bottomView_PercentCharLabel2;
@property (nonatomic,strong) UILabel * bottomView_PercentCharLabel3;

//动画view
@property (nonatomic,strong) UIView *animationView;
@property (nonatomic,strong) UIImageView * animationView_imageV;
@property (nonatomic,strong) UILabel * animationView_subtitleLable;
@property (nonatomic,strong) UILabel * animationView_titleLable;

@property (nonatomic,strong)PayInfoItem *dataItem;

@property(nonatomic,assign)NSUInteger loanDealNum;

@property (nonatomic,strong)NSArray *animateDataArr;
@property (nonatomic,assign)NSInteger animateNum;




@end
@implementation LoanConfirmationExtendView
#pragma mark - 生命周期
#pragma mark - 生命周期
-(instancetype)init{
    if (self = [super init]) {
        [self configUI];
        _loanDealNum = 0;
        
    }
    return self;
}
#pragma mark - ui
-(void)configUI{
    _backgroundView = [UIView new];
    [self addSubview:_backgroundView];
        CGFloat H = [self.topView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    __weak __typeof(self) weakSelf = self;
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
        make.height.mas_equalTo(H);
    }];
    
    [_backgroundView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf.backgroundView);
//        make.bottom.mas_equalTo(weakSelf.backgroundView);

    }];

    /**
     *  1.通过CAGradientLayer 设置渐变的背景。
     */
    CAGradientLayer *layer1 = [CAGradientLayer new];
    //colors存放渐变的颜色的数组
    NSArray *colorArray = @[(__bridge id)[UIColor colorWithHexString:@"02c8b9"].CGColor,(__bridge id)[UIColor colorWithHexString:@"249aee"].CGColor];
    layer1.colors=colorArray;
    layer1.startPoint = CGPointMake(0.0, 0.0);
    layer1.endPoint = CGPointMake(0.6, 0);
    layer1.frame = CGRectMake(0, 0, LQScreemW, H);
    [self.topView.layer insertSublayer:layer1 atIndex:0];
    



    
    
    [self addSubview:self.animationView];
    [self.animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_right);
        make.top.mas_equalTo(Adaptor_Value(H - 50));
    }];

    
}

#pragma mark - 刷新UI
- (void)configUIWithItme:(PayInfoItem *)item{
    _dataItem = item;
    self.moneyTipLabel.text = item.a1;
    self.moneyLabel.text = item.a2;
    self.rateTipLabel.text = item.a6;
    self.rateLabel.text = item.a3;
    self.xiakuanNumTipLabel.text = item.a7;
    self.xiakuanNumLabel.text = item.a4;
    self.shenqingNumTipLabel.text = item.a8;
    self.shenqingNumLabel.text = item.a5;
    self.maxMoneyLabel.text = [NSString stringWithFormat:@"%@%@%@%@",item.a9,item.a10,item.a11,item.a12];
//    self.maxMoneyOwnerLabel.text = [NSString stringWithFormat:@"%@",todayItem.star];


    __weak __typeof(self) weakSelf = self;
    [_backgroundView insertSubview:self.bottomView belowSubview:self.topView];
    CGFloat bottomH = [self.bottomView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;

    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.backgroundView);
        make.bottom.mas_equalTo(weakSelf.backgroundView.mas_bottom).offset(-bottomH);

    }];
    //默认隐藏
    self.bottomView.hidden = YES;


    /**
     *  1.通过CAGradientLayer 设置渐变的背景。
     */
    //colors存放渐变的颜色的数组
    NSArray *colorArray = @[(__bridge id)[UIColor colorWithHexString:@"02c8b9"].CGColor,(__bridge id)[UIColor colorWithHexString:@"249aee"].CGColor];
    CAGradientLayer *layer2 = [CAGradientLayer new];
    layer2.colors=colorArray;
    layer2.startPoint = CGPointMake(0.0, 0.0);
    layer2.endPoint = CGPointMake(0.6, 0);
    layer2.frame = CGRectMake(0, 0, LQScreemW, bottomH);
    [self.bottomView.layer insertSublayer:layer2 atIndex:0];

}

- (void)setAnimationWithItemArr:(NSArray *)itemArr{
    if (itemArr.count == 0 ) {
        return;
    }
    _animateDataArr = itemArr;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animationViewDoAnimate];
    });
    
}

#pragma mark - 自定义
- (void)showBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    __weak __typeof(self) weakSelf = self;
    
    sender.userInteractionEnabled = NO;
    CGFloat H = [self.topView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGFloat bottomH = [self.bottomView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    if (sender.selected) {
        self.bottomView.hidden = NO;

        [weakSelf.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.backgroundView.mas_bottom);
        }];
        [UIView animateWithDuration:1.0 animations:^{
            [weakSelf.bottomView.superview layoutIfNeeded];
        } completion:^(BOOL finished) {
            sender.userInteractionEnabled = YES;
            
        }];
        CABasicAnimation *theAnimation;
        theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        theAnimation.duration= 0.5;
        theAnimation.removedOnCompletion = YES;
        theAnimation.fromValue = @(0);
        theAnimation.toValue = @(M_PI);
        [self.showBtn.layer addAnimation:theAnimation forKey:@"animateTransform"];
        PayInfoProgressItem *list0 = [self.dataItem.a14 safeObjectAtIndex:0];
        PayInfoProgressItem *list1 = [self.dataItem.a14 safeObjectAtIndex:1];
        PayInfoProgressItem *list2 = [self.dataItem.a14 safeObjectAtIndex:2];

        _progressView1.totalNum = list0.apply_num;
        _progressView2.totalNum = list1.apply_num;
        _progressView3.totalNum = list2.apply_num;

        _progressView1.progressNum = list0.loan_num;
        _progressView2.progressNum = list1.loan_num;
        _progressView3.progressNum = list2.loan_num;

        _progressView1.progressValue = [NSString stringWithFormat:@"%.2f",(list0.rate/100.0)];
        _progressView2.progressValue = [NSString stringWithFormat:@"%.2f",(list1.rate/100.0)];;
        _progressView3.progressValue = [NSString stringWithFormat:@"%.2f",(list2.rate/100.0)];;


        [_bottomView_PercentLabel1 countFrom:0 to:list0.rate];
        [_bottomView_PercentLabel2 countFrom:0 to:list1.rate];
        [_bottomView_PercentLabel3 countFrom:0 to:list2.rate];

        self.bottomView_moneyTipLabel1.text = list0.title;
        self.bottomView_moneyTipLabel2.text = list1.title;
        self.bottomView_moneyTipLabel3.text = list2.title;



    }else{
        
        [weakSelf.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.backgroundView.mas_bottom).offset(-bottomH);
        }];
        [UIView animateWithDuration:2.0 animations:^{
            [weakSelf.bottomView.superview layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            sender.userInteractionEnabled = YES;
            self.bottomView.hidden = YES;

        }];


        CABasicAnimation *theAnimation;
        theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        theAnimation.duration= 0.5;
        theAnimation.removedOnCompletion = YES;
        theAnimation.fromValue = @(M_PI) ;
        theAnimation.toValue = @(0);
        [self.showBtn.layer addAnimation:theAnimation forKey:@"animateTransform"];
        
        //复原
        [self.progressView1 recover];
        [self.progressView2 recover];
        [self.progressView3 recover];


    }
    
    if (self.loanConfirmationExtendViewChangeHeightBlock) {
        self.loanConfirmationExtendViewChangeHeightBlock(sender.selected ? H + bottomH : H);
    }
    
}

- (void)animationViewDoAnimate{
    __weak __typeof(self) weakSelf = self;
    if (_animateNum > (self.animateDataArr.count -1)) {
        _animateNum = 0;
    }
    LoanListItem *loanItem = [self.animateDataArr safeObjectAtIndex:_animateNum];
    [self.animationView_imageV sd_setImageWithURL:[NSURL URLWithString:loanItem.avatar] placeholderImage:[UIImage imageNamed:@"messegeIcon"]];
    self.animationView_subtitleLable.text = [NSString stringWithFormat:NSLocalizedString(@"%@·%@", nil),loanItem.time,loanItem.city];
    self.animationView_titleLable.text = [NSString stringWithFormat:NSLocalizedString(@"%@成功下款%@元!", nil),loanItem.name,loanItem.amount];
    CGFloat w = [self.animationView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].width;
    [weakSelf.animationView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_right).offset(-(w - Adaptor_Value(15)));
    }];
    [UIView animateWithDuration:1.5 animations:^{
        [weakSelf.animationView.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.animationView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(weakSelf.mas_right);
            }];
            [UIView animateWithDuration:1.5 animations:^{
                [weakSelf.animationView.superview layoutIfNeeded];
            } completion:^(BOOL finished) {
                weakSelf.animateNum ++;
                [weakSelf animationViewDoAnimate];
            }];

        });
    }];
}

#pragma mark - lazy


- (UIView *)topView{
    if (_topView == nil) {
        _topView = [UIView new];
        UIView *contentV = [UIView new];
        [_topView addSubview:contentV];
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_topView);
        }];

        
        __weak __typeof(self) weakSelf = self;
        [contentV addSubview:self.moneyTipLabel];
        [self.moneyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(Adaptor_Value(15));
        }];
        [contentV addSubview:self.moneyLabel];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.moneyTipLabel);
            make.top.mas_equalTo(weakSelf.moneyTipLabel.mas_bottom).offset(-Adaptor_Value(5));
        }];
        
        UIView *rateView = [UIView new];
//        rateView.backgroundColor = [UIColor redColor];
        UIView *xiakuanView = [UIView new];
//        xiakuanView.backgroundColor = [UIColor yellowColor];
        UIView *shenqingView = [UIView new];
//        shenqingView.backgroundColor = [UIColor purpleColor];
    
        [contentV addSubview:rateView];
        [contentV addSubview:xiakuanView];
        [contentV addSubview:shenqingView];
        [rateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.moneyLabel.mas_bottom);
            make.height.mas_equalTo(Adaptor_Value(90));
//            make.width.mas_equalTo(LQScreemW / 3.0);
        }];
        [xiakuanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.mas_equalTo(rateView);
            make.left.mas_equalTo(rateView.mas_right);

        }];
        [shenqingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.width.mas_equalTo(xiakuanView);
            make.left.mas_equalTo(xiakuanView.mas_right);
            make.right.mas_equalTo(contentV);
        }];
        
        [rateView addSubview:self.rateLabel];
        [rateView addSubview:self.rateTipLabel];
        [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(rateView);
            make.bottom.mas_equalTo(rateView.mas_centerY).offset(-Adaptor_Value(2.5));
        }];
        [self.rateTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(rateView);
            make.top.mas_equalTo(rateView.mas_centerY).offset(Adaptor_Value(2.5));
        }];
        
        [xiakuanView addSubview:self.xiakuanNumLabel];
        [xiakuanView addSubview:self.xiakuanNumTipLabel];
        [self.xiakuanNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(xiakuanView);
            make.bottom.mas_equalTo(xiakuanView.mas_centerY).offset(-Adaptor_Value(2.5));
        }];
        [self.xiakuanNumTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(xiakuanView);
            make.top.mas_equalTo(xiakuanView.mas_centerY).offset(Adaptor_Value(2.5));
        }];
        
        [shenqingView addSubview:self.shenqingNumLabel];
        [shenqingView addSubview:self.shenqingNumTipLabel];
        [self.shenqingNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(shenqingView);
            make.bottom.mas_equalTo(shenqingView.mas_centerY).offset(-Adaptor_Value(2.5));
        }];
        [self.shenqingNumTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(shenqingView);
            make.top.mas_equalTo(shenqingView.mas_centerY).offset(Adaptor_Value(2.5));
        }];
        


        [contentV addSubview:self.maxMoneyLabel];
        [self.maxMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(rateView.mas_bottom);
            make.centerX.mas_equalTo(contentV);
        }];
        
        [contentV addSubview:self.showBtn];
        [self.showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(Adaptor_Value(40));
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(self.maxMoneyLabel.mas_bottom).offset(Adaptor_Value(10));
            make.bottom.mas_equalTo(contentV);
        }];
        
        

        
    }
    return _topView;
}

-(UILabel *)moneyTipLabel{
    if (!_moneyTipLabel) {
        _moneyTipLabel = [UILabel new];
        _moneyTipLabel.textColor = [UIColor whiteColor];
        _moneyTipLabel.font = AdaptedFontSize(13);
        _moneyTipLabel.text = NSLocalizedString(@"今日下款总额(元)", nil);
    }
    return _moneyTipLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.font = AdaptedFontSize(45);
        _moneyLabel.text = @"0";
    }
    return _moneyLabel;
}
-(UILabel *)rateTipLabel{
    if (!_rateTipLabel) {
        _rateTipLabel = [UILabel new];
        _rateTipLabel.textColor = [UIColor whiteColor];
        _rateTipLabel.font = AdaptedFontSize(15);
        _rateTipLabel.text = NSLocalizedString(@"今日下款率", nil);

    }
    return _rateTipLabel;
}
-(UILabel *)rateLabel{
    if (!_rateLabel) {
        _rateLabel = [UILabel new];
        _rateLabel.textColor = [UIColor whiteColor];
        _rateLabel.font = AdaptedFontSize(18);
        _rateLabel.text = @"88%";
    }
    return _rateLabel;
}


-(UILabel *)xiakuanNumTipLabel{
    if (!_xiakuanNumTipLabel) {
        _xiakuanNumTipLabel = [UILabel new];
        _xiakuanNumTipLabel.textColor = [UIColor whiteColor];
        _xiakuanNumTipLabel.font = AdaptedFontSize(15);
        _xiakuanNumTipLabel.text = NSLocalizedString(@"今日下款总人数", nil);

    }
    return _xiakuanNumTipLabel;
}
-(UILabel *)xiakuanNumLabel{
    if (!_xiakuanNumLabel) {
        _xiakuanNumLabel = [UILabel new];
        _xiakuanNumLabel.textColor = [UIColor whiteColor];
        _xiakuanNumLabel.font = AdaptedFontSize(18);
        _xiakuanNumLabel.text = @"2008";

    }
    return _xiakuanNumLabel;
}
-(UILabel *)shenqingNumTipLabel{
    if (!_shenqingNumTipLabel) {
        _shenqingNumTipLabel = [UILabel new];
        _shenqingNumTipLabel.textColor = [UIColor whiteColor];
        _shenqingNumTipLabel.font = AdaptedFontSize(15);
        _shenqingNumTipLabel.text = NSLocalizedString(@"今日申请总人数", nil);

    }
    return _shenqingNumTipLabel;
}
-(UILabel *)shenqingNumLabel{
    if (!_shenqingNumLabel) {
        _shenqingNumLabel = [UILabel new];
        _shenqingNumLabel.textColor = [UIColor whiteColor];
        _shenqingNumLabel.font = AdaptedFontSize(18);
        _shenqingNumLabel.text = @"3000";

    }
    return _shenqingNumLabel;
}

-(UILabel *)maxMoneyLabel{
    if (!_maxMoneyLabel) {
        _maxMoneyLabel = [UILabel new];
        _maxMoneyLabel.textColor = [UIColor whiteColor];
        _maxMoneyLabel.font = AdaptedFontSize(15);
        _maxMoneyLabel.text = NSLocalizedString(@"今日下款最高额度:￥58500  借款人张*星", nil);

    }
    return _maxMoneyLabel;
}
-(UILabel *)maxMoneyOwnerLabel{
    if (!_maxMoneyOwnerLabel) {
        _maxMoneyOwnerLabel = [UILabel new];
        _maxMoneyOwnerLabel.textColor = [UIColor whiteColor];
        _maxMoneyOwnerLabel.font = AdaptedFontSize(13);
    }
    return _maxMoneyOwnerLabel;
}
- (UIButton *)showBtn{
    if (!_showBtn) {
        _showBtn = [UIButton buttonWithTitle:@"" titleColor:nil titleFont:nil backGroundColor:[UIColor clearColor] normalImage:[UIImage imageNamed:@"down"] selectedImage:[UIImage imageNamed:@"wrong"]  Target:self action:@selector(showBtnClick:) rect:CGRectZero];
    }
    return _showBtn;
}



- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [UIView new];
        __weak typeof(self)weakSelf = self;
        UIView *contentV = [UIView new];
        [_bottomView addSubview:contentV];
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.bottomView);
        }];
        
        [contentV addSubview:self.bottomView_TipLabel];
        [self.bottomView_TipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Adaptor_Value(10));
            make.left.mas_equalTo(Adaptor_Value(25));
        }];
        
        UIView *progressContentV1 = [UIView new];
        UIView *progressContentV2 = [UIView new];
        UIView *progressContentV3 = [UIView new];
        [contentV addSubview:progressContentV1];
        [contentV addSubview:progressContentV2];
        [contentV addSubview:progressContentV3];
        [progressContentV1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.bottomView_TipLabel.mas_bottom).offset(Adaptor_Value(20));
            make.left.right.mas_equalTo(contentV);
            make.height.mas_equalTo(Adaptor_Value(20));
        }];
        [progressContentV2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(progressContentV1.mas_bottom).offset(Adaptor_Value(20));
            make.left.right.mas_equalTo(contentV);
            make.height.mas_equalTo(progressContentV1);
        }];
        [progressContentV3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(progressContentV2.mas_bottom).offset(Adaptor_Value(20));
            make.left.right.mas_equalTo(contentV);
            make.height.mas_equalTo(progressContentV1);
        }];
        
        [progressContentV1 addSubview:self.bottomView_moneyTipLabel1];
#warning ceshi 计算宽度
        CGFloat w = [@"99%" sizeWithAttributes:@{NSFontAttributeName : AdaptedFontSize(15)}].width;
        CGFloat maxW = LQScreemW - Adaptor_Value(120) - Adaptor_Value(5) - w - Adaptor_Value(20);
        NSArray *listItemArr = self.dataItem.a14;
        //排序
        NSArray *sortDesc = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"apply_num" ascending:NO]];
        NSArray *sortedArr = [listItemArr sortedArrayUsingDescriptors:sortDesc];

        CGFloat progressView1W = (((PayInfoProgressItem *)[self.dataItem.a14 safeObjectAtIndex:0]).apply_num  * maxW )/  (((PayInfoProgressItem *)[sortedArr safeObjectAtIndex:0]).apply_num) ;

        CGFloat progressView2W = (((PayInfoProgressItem *)[self.dataItem.a14 safeObjectAtIndex:1]).apply_num  * maxW)/  (((PayInfoProgressItem *)[sortedArr safeObjectAtIndex:0]).apply_num);

        CGFloat progressView3W = (((PayInfoProgressItem *)[self.dataItem.a14 safeObjectAtIndex:2]).apply_num * maxW )/  (((PayInfoProgressItem *)[sortedArr safeObjectAtIndex:0]).apply_num) ;

        
        self.progressView1 = [[ProgressView alloc] initWithFrame:CGRectMake(0, 0, progressView1W, Adaptor_Value(20))];

        [progressContentV1 addSubview:self.progressView1];
        [progressContentV1 addSubview:self.bottomView_PercentLabel1];
        [progressContentV1 addSubview:self.bottomView_PercentCharLabel1];

        [self.bottomView_moneyTipLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(25));
            make.centerY.mas_equalTo(progressContentV1);
        }];
        [self.progressView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(120));
            make.top.bottom.mas_equalTo(progressContentV1);
            make.width.mas_equalTo(progressView1W);
        }];
        [self.bottomView_PercentLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.progressView1.mas_right).offset(Adaptor_Value(5));
            make.centerY.mas_equalTo(progressContentV1);
        }];
        [self.bottomView_PercentCharLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.bottomView_PercentLabel1.mas_right).offset(Adaptor_Value(0));
            make.centerY.mas_equalTo(weakSelf.bottomView_PercentLabel1);
        }];
        
        [progressContentV2 addSubview:self.bottomView_moneyTipLabel2];
        self.progressView2 = [[ProgressView alloc] initWithFrame:CGRectMake(0, 0, progressView2W, Adaptor_Value(20))];
        [progressContentV2 addSubview:self.progressView2];
        [progressContentV2 addSubview:self.bottomView_PercentLabel2];
        [progressContentV2 addSubview:self.bottomView_PercentCharLabel2];

        [self.bottomView_moneyTipLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(25));
            make.centerY.mas_equalTo(progressContentV2);
        }];
        [self.progressView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(120));
            make.top.bottom.mas_equalTo(progressContentV2);
            make.width.mas_equalTo(progressView2W);
        }];
        [self.bottomView_PercentLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.progressView2.mas_right).offset(Adaptor_Value(5));
            make.centerY.mas_equalTo(progressContentV2);
        }];
        
        [self.bottomView_PercentCharLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.bottomView_PercentLabel2.mas_right).offset(Adaptor_Value(0));
            make.centerY.mas_equalTo(weakSelf.bottomView_PercentLabel2);
        }];

        
        [progressContentV3 addSubview:self.bottomView_moneyTipLabel3];
//        self.progressView3 = [[ProgressView alloc] initWithFrame:CGRectMake(0, 0, progressView3W, Adaptor_Value(20))];z

        [progressContentV3 addSubview:self.progressView3];
        [progressContentV3 addSubview:self.bottomView_PercentLabel3];
        [progressContentV3 addSubview:self.bottomView_PercentCharLabel3];

        [self.bottomView_moneyTipLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(25));
            make.centerY.mas_equalTo(progressContentV3);
        }];
        [self.progressView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(120));
            make.top.bottom.mas_equalTo(progressContentV3);
            make.width.mas_equalTo(progressView3W);
        }];
        [self.bottomView_PercentLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.progressView3.mas_right).offset(Adaptor_Value(5));
            make.centerY.mas_equalTo(progressContentV3);
        }];

        [self.bottomView_PercentCharLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.bottomView_PercentLabel3.mas_right).offset(Adaptor_Value(0));
            make.centerY.mas_equalTo(weakSelf.bottomView_PercentLabel3);
        }];

        

        UILabel *shenqnumLabel = [UILabel lableWithText:NSLocalizedString(@"申请人数", nil) textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentRight numberofLines:0];
        [contentV addSubview:shenqnumLabel];
        [shenqnumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(progressContentV3.mas_bottom).offset(Adaptor_Value(25));
            make.right.mas_equalTo(contentV.mas_centerX).offset(-Adaptor_Value(15));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(20));
        }];
        UIView *radiusView1 = [UIView new];
        radiusView1.backgroundColor = [UIColor colorWithHexString:@"1b90c2"];
        ViewRadius(radiusView1, 5);
        [contentV addSubview:radiusView1];
        [radiusView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(shenqnumLabel);
            make.width.mas_equalTo(Adaptor_Value(20));
            make.height.mas_equalTo(Adaptor_Value(10));
            make.right.mas_equalTo(shenqnumLabel.mas_left).offset(-Adaptor_Value(2.5));
        }];
        
        UIView *radiusView2 = [UIView new];
        radiusView2.backgroundColor = [UIColor whiteColor];
        ViewRadius(radiusView2, 5);
        [contentV addSubview:radiusView2];
        [radiusView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(shenqnumLabel);
            make.width.mas_equalTo(Adaptor_Value(20));
            make.height.mas_equalTo(Adaptor_Value(10));
            make.left.mas_equalTo(contentV.mas_centerX).offset(Adaptor_Value(7.5));
        }];
        
        UILabel *xiazainumLabel = [UILabel lableWithText:NSLocalizedString(@"下载人数", nil) textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentRight numberofLines:0];
        [contentV addSubview:xiazainumLabel];
        [xiazainumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(shenqnumLabel);
            make.left.mas_equalTo(radiusView2.mas_right).offset(Adaptor_Value(2.5));
            
        }];

    }
    return _bottomView;
}

-(UILabel *)bottomView_TipLabel{
    if (!_bottomView_TipLabel) {
        _bottomView_TipLabel = [UILabel new];
        _bottomView_TipLabel.textColor = [UIColor whiteColor];
        _bottomView_TipLabel.font = AdaptedFontSize(15);
        _bottomView_TipLabel.text = NSLocalizedString(@"今日下款详情:", nil);

    }
    return _bottomView_TipLabel;
}
-(UILabel *)bottomView_moneyTipLabel1{
    if (!_bottomView_moneyTipLabel1) {
        _bottomView_moneyTipLabel1 = [UILabel new];
        _bottomView_moneyTipLabel1.textColor = [UIColor whiteColor];
        _bottomView_moneyTipLabel1.font = AdaptedFontSize(15);

    }
    return _bottomView_moneyTipLabel1;
}
-(UILabel *)bottomView_moneyTipLabel2{
    if (!_bottomView_moneyTipLabel2) {
        _bottomView_moneyTipLabel2 = [UILabel new];
        _bottomView_moneyTipLabel2.textColor = [UIColor whiteColor];
        _bottomView_moneyTipLabel2.font = AdaptedFontSize(15);

    }
    return _bottomView_moneyTipLabel2;
}
-(UILabel *)bottomView_moneyTipLabel3{
    if (!_bottomView_moneyTipLabel3) {
        _bottomView_moneyTipLabel3 = [UILabel new];
        _bottomView_moneyTipLabel3.textColor = [UIColor whiteColor];
        _bottomView_moneyTipLabel3.font = AdaptedFontSize(15);

    }
    return _bottomView_moneyTipLabel3;
}


-(UILabel *)bottomView_PercentCharLabel1{
    if (!_bottomView_PercentCharLabel1) {
        _bottomView_PercentCharLabel1 = [UILabel new];
        _bottomView_PercentCharLabel1.textColor = [UIColor whiteColor];
        _bottomView_PercentCharLabel1.font = AdaptedFontSize(15);
        _bottomView_PercentCharLabel1.text = @"%";

    }
    return _bottomView_PercentCharLabel1;
}
-(UILabel *)bottomView_PercentCharLabel2{
    if (!_bottomView_PercentCharLabel2) {
        _bottomView_PercentCharLabel2 = [UILabel new];
        _bottomView_PercentCharLabel2.textColor = [UIColor whiteColor];
        _bottomView_PercentCharLabel2.font = AdaptedFontSize(15);
        _bottomView_PercentCharLabel2.text = @"%";

    }
    return _bottomView_PercentCharLabel2;
}
-(UILabel *)bottomView_PercentCharLabel3{
    if (!_bottomView_PercentCharLabel3) {
        _bottomView_PercentCharLabel3 = [UILabel new];
        _bottomView_PercentCharLabel3.textColor = [UIColor whiteColor];
        _bottomView_PercentCharLabel3.font = AdaptedFontSize(15);
        _bottomView_PercentCharLabel3.text = @"%";

    }
    return _bottomView_PercentCharLabel3;
}

-(UICountingLabel *)bottomView_PercentLabel1{
    if (!_bottomView_PercentLabel1) {
        _bottomView_PercentLabel1 = [UICountingLabel new];
        _bottomView_PercentLabel1.textColor = [UIColor whiteColor];
        _bottomView_PercentLabel1.font = AdaptedFontSize(15);
        _bottomView_PercentLabel1.format = @"%d";
        _bottomView_PercentLabel1.animationDuration = 1.0;


    }
    return _bottomView_PercentLabel1;
}

-(UICountingLabel *)bottomView_PercentLabel2{
    if (!_bottomView_PercentLabel2) {
        _bottomView_PercentLabel2 = [UICountingLabel new];
        _bottomView_PercentLabel2.textColor = [UIColor whiteColor];
        _bottomView_PercentLabel2.font = AdaptedFontSize(15);
//        _bottomView_PercentLabel2.text = @"99%";
        _bottomView_PercentLabel2.format = @"%d";
        _bottomView_PercentLabel2.animationDuration = 1.0;


    }
    return _bottomView_PercentLabel2;
}
-(UICountingLabel *)bottomView_PercentLabel3{
    if (!_bottomView_PercentLabel3) {
        _bottomView_PercentLabel3 = [UICountingLabel new];
        _bottomView_PercentLabel3.textColor = [UIColor whiteColor];
        _bottomView_PercentLabel3.font = AdaptedFontSize(15);
//        _bottomView_PercentLabel3.text = @"99%";
        _bottomView_PercentLabel3.format = @"%d";
        _bottomView_PercentLabel3.animationDuration = 1.0;


    }
    return _bottomView_PercentLabel3;
}
- (ProgressView *)progressView1{
    if (_progressView1 == nil) {
        _progressView1 = [[ProgressView alloc] initWithFrame:CGRectMake(Adaptor_Value(120), 0, 0, Adaptor_Value(20))];
        _progressView1.bottomColor = [UIColor colorWithHexString:@"1b91c2"];
        _progressView1.progressColor = [UIColor whiteColor];
    }
    return _progressView1;
}

- (ProgressView *)progressView2{
    if (_progressView2 == nil) {
        _progressView2 = [[ProgressView alloc] initWithFrame:CGRectMake(Adaptor_Value(120), 0, 100, Adaptor_Value(20))];
        _progressView2.bottomColor = [UIColor colorWithHexString:@"1b91c2"];
        _progressView2.progressColor = [UIColor whiteColor];

    }
    return _progressView2;
}
- (ProgressView *)progressView3{
    if (_progressView3 == nil) {
        _progressView3 = [[ProgressView alloc] initWithFrame:CGRectMake(Adaptor_Value(120), 0, 100, Adaptor_Value(20))];
        _progressView3.bottomColor = [UIColor colorWithHexString:@"1b91c2"];
        _progressView3.progressColor = [UIColor whiteColor];

    }
    return _progressView3;
}

- (UIView *)animationView{
    if (!_animationView) {
        _animationView = [UIView new];
        UIView *contentV = [UIView new];
        contentV.backgroundColor = [UIColor whiteColor];
        ViewRadius(contentV, Adaptor_Value(40) * 0.5);

        [_animationView addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.animationView);
        }];
        _animationView_imageV = [[UIImageView alloc] init];
        [contentV addSubview:_animationView_imageV];
        [_animationView_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(Adaptor_Value(30));
            make.left.mas_equalTo(Adaptor_Value(10));
            make.top.mas_equalTo(Adaptor_Value(5));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(5));
        }];
        ViewRadius(_animationView_imageV, Adaptor_Value(15));
        _animationView_imageV.backgroundColor = [UIColor purpleColor];
        
        _animationView_subtitleLable = [UILabel lableWithText:@"aaaa" textColor:[UIColor colorWithHexString:@"bcbcbc"] fontSize:AdaptedFontSize(10) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_animationView_subtitleLable];
        [_animationView_subtitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.animationView_imageV.mas_right).offset(Adaptor_Value(5));
            make.top.mas_equalTo(Adaptor_Value(5));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10 + 15));
        }];

        _animationView_titleLable = [UILabel lableWithText:@"aaaa" textColor:[UIColor colorWithHexString:@"222020"] fontSize:[UIFont boldSystemFontOfSize:Adaptor_Value(13)] lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_animationView_titleLable];
        [_animationView_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.animationView_imageV.mas_right).offset(Adaptor_Value(5));
            make.top.mas_equalTo(weakSelf.animationView_subtitleLable.mas_bottom).offset(Adaptor_Value(2));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10 + 15));
        }];
        
    }
    return _animationView;
}
@end
