//
//  HomeCustomView.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/27.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "HomeCustomView.h"
#import "HomeBottomCollectionViewCell.h"
#import "HomeModel.h"
#import "SDCycleScrollView.h"

@interface HomeCustomView()<UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>
//头部view
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UILabel *moneyTipLable;
@property (nonatomic,strong)UILabel *moneyLabel;
@property (nonatomic,strong)UILabel *rateTipLabel;
//动画view
@property (nonatomic,strong) UIView *animationView;
@property (nonatomic,strong) UIImageView * animationView_imageV;
@property (nonatomic,strong) UILabel * animationView_subtitleLable;
@property (nonatomic,strong) UILabel * animationView_titleLable;


//中间VIew
@property (nonatomic,strong)UIView *centerView;
@property (nonatomic,strong)UILabel *centerTipLable;
@property (nonatomic,strong)UILabel *centerTipSubLabel;
@property (nonatomic,strong)UIView *phoneTfBackView;
@property (nonatomic,strong)UITextField *phoneTf;
@property (nonatomic,strong)UIView *tuxingTfBackView;
@property (nonatomic,strong)UITextField *tuxingTf;
@property (nonatomic,strong)UIImageView *tuxingImageView;
@property (nonatomic,strong)UIView *codeTfBackView;
@property (nonatomic,strong)UITextField *codeTf;
@property (nonatomic,strong)UIButton *codeBtn;

@property (nonatomic,strong)CommonBtn *confirmBtn;
@property (nonatomic,strong)UILabel *progressTipLable;

//bottom VIew
@property (nonatomic,strong)UIView *bottomVIew;
//@property (nonatomic,strong)UICollectionView *bottomCollectionView;
@property (nonatomic,strong)UIImageView *imageV;
@property (nonatomic,strong)UILabel *bottomTipLable;
@property (nonatomic,strong)UILabel *bottomTipSubLabel;

@property (nonatomic,strong)HomeDataItem *dataModel;
@property (nonatomic,strong)NSArray *animateDataArr;
@property (nonatomic,assign)NSInteger animateNum;
@property (nonatomic,strong)SDCycleScrollView *infiniteView;
@end
@implementation HomeCustomView
#pragma mark - 生命周期
-(instancetype)init{
    if (self = [super init]) {
        
        [self configUI];

    }
    return self;
}
#pragma mark - ui
-(void)configUI{

    __weak __typeof(self) weakSelf = self;
    [self addSubview:self.header];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
    }];
    [self addSubview:self.animationView];
    [self.animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_right);
        make.bottom.mas_equalTo(weakSelf.header.mas_bottom).offset(-Adaptor_Value(20));
    }];
    
    [weakSelf addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.header);
        make.top.mas_equalTo(weakSelf.header.mas_bottom);
    }];
    [weakSelf addSubview:self.bottomVIew];

    [self.bottomVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.centerView);
        make.top.mas_equalTo(weakSelf.centerView.mas_bottom);
        make.bottom.mas_equalTo(weakSelf).offset(-TabbarH);
    }];

    
}

#pragma mark - refresh UI
- (void)configUIWithItem:(HomeDataItem *)item finishBlock:(void(^)())finishBlock{
    _dataModel = item;

    
    self.moneyTipLable.text = item.a1;
    self.moneyLabel.text = item.a2;
    self.rateTipLabel.text = item.a3;
    NSString *str = [NSString stringWithFormat:@"%@%@",item.a4,item.a5];
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange start  = [str rangeOfString:lqLocalized(@"人",nil)];
    if (start.length > 0) {
        NSRange rangel = NSMakeRange(0 , start.location);
        [textColor addAttribute:NSForegroundColorAttributeName value:BlueJianbian2 range:rangel];
        [textColor addAttribute:NSFontAttributeName value:SemiboldFONT(24) range:rangel];
        
    }
    _centerTipLable.attributedText = textColor;
    self.centerTipSubLabel.text = item.a6;
    [self.confirmBtn setTitle:item.a7 forState:UIControlStateNormal];
    self.progressTipLable.text = item.a8;
    self.bottomTipLable.text = item.a9;
    self.bottomTipSubLabel.text = item.a11;
//    if (item.a10.count > 2) {
//        [self.bottomCollectionView setContentOffset:CGPointMake((AdaptedWidth(250)-(LQScreemW - AdaptedWidth(250) - AdaptedWidth(10) * 3)*0.5), 0) animated:NO];
//    }else{
//        [self.bottomCollectionView setContentOffset:CGPointMake((LQScreemW - AdaptedWidth(250)) * 0.5, 0) animated:NO];
//    }
//    [self.bottomCollectionView reloadData];
    
    self.infiniteView.imageURLStringsGroup = item.a10;
    __weak __typeof(self) weakSelf = self;

    if (item.a10.count > 2) {
        [self.infiniteView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.infiniteView.superview).offset(-(AdaptedWidth(250)-(LQScreemW - AdaptedWidth(250) - AdaptedWidth(10) * 3)*0.5));
        }];
    }else{
        [self.infiniteView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.infiniteView.superview).offset(-(LQScreemW - AdaptedWidth(250)) * 0.5);
        }];
    }
    finishBlock();

}
- (void)setAnimationWithItemArr:(NSArray *)itemArr{
    _animateDataArr = itemArr;
    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animationViewDoAnimate];
    });

}

- (void)refreshUIWithIsLorgin:(BOOL)islogin finishBlock:(void(^)())finishBlock{
    __weak __typeof(self) weakSelf = self;
    [_phoneTfBackView mas_updateConstraints:^(MASConstraintMaker *make) {
   
        make.height.mas_equalTo(RI.is_logined ? Adaptor_Value(0) : Adaptor_Value(50));
    }];
    _phoneTfBackView.hidden = RI.is_logined;
    
    [_tuxingTfBackView mas_updateConstraints:^(MASConstraintMaker *make) {
    
        make.height.mas_equalTo(Adaptor_Value(0));
    }];
    //默认隐藏
    _tuxingTfBackView.hidden = YES;
    _codeTfBackView.hidden = YES;
    [_confirmBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.tuxingTfBackView.mas_bottom).offset(RI.is_logined ? Adaptor_Value(0) : Adaptor_Value(20));
    }];
    finishBlock();
    

}
#pragma mark - act
- (void)animationViewDoAnimate{
    __weak __typeof(self) weakSelf = self;
    
    if (_animateNum > (self.animateDataArr.count -1)) {
        _animateNum = 0;
        //重新获取数据
        if (self.homeCustomViewReloadAnimateBlock) {
            self.homeCustomViewReloadAnimateBlock();
        }
        return;

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

- (void)confirmBtnClick:(UIButton *)sender{
//    [LSVProgressHUD showInfoWithStatus:@"立即下款"];
    if (self.homeCustomViewConfirmBtnClickBlock) {
        if (!RI.is_logined) {
            if (!(self.phoneTf.text.length > 0)) {
                [LSVProgressHUD showInfoWithStatus:@"请填写正确的手机号码"];
                return;

            }
            if (self.tuxingTfBackView.hidden) {
                [self tuxingTap:nil];
            }else if (self.codeTfBackView.hidden) {
                if (self.tuxingTf.text.length > 0) {
                    [self codeBtnClick:self.codeBtn];
                }else{
                    [LSVProgressHUD showInfoWithStatus:@"请填写正确的图形验证码"];
                }
            }else{
                self.homeCustomViewConfirmBtnClickBlock(sender, @{@"mobile":SAFE_NIL_STRING(self.phoneTf.text),@"code":SAFE_NIL_STRING(self.codeTf.text),@"tuxing":SAFE_NIL_STRING(self.tuxingTf)});
                
            }
        }else{
            self.homeCustomViewConfirmBtnClickBlock(sender,nil);
        }
    }
}

- (void)codeBtnClick:(UIButton *)sender{
    [LSVProgressHUD showInfoWithStatus:@"获取验证码"];
    if (self.homeCustomViewCodeBtnClickBlock) {
        self.homeCustomViewCodeBtnClickBlock(sender, @{@"mobile":SAFE_NIL_STRING(self.phoneTf.text),@"captcha":SAFE_NIL_STRING(self.tuxingTf.text)});
    }

}
- (void)tuxingTap:(UITapGestureRecognizer *)gest{
    [LSVProgressHUD showInfoWithStatus:@"获取图形验证码"];
    self.tuxingTfBackView.hidden = NO;
    [self.tuxingTfBackView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(Adaptor_Value(50));
    }];
    if (self.homeCustomViewTuxingImageVTapBlock) {
        self.homeCustomViewTuxingImageVTapBlock(self.tuxingImageView, nil);
    }


}
- (void)setCodeTFBackHidden:(BOOL)hidden{
    self.codeTfBackView.hidden = hidden;
}

//#pragma mark collectionView代理方法

#pragma  mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
}
#pragma mark - lazy
-(UIView *)header{
    if (!_header) {
        _header = [UIView new];
        UIView *contentV = [UIView new];
        [_header addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.header);
        }];
        _moneyTipLable = [UILabel lableWithText:lqLocalized(@"已成功操作下款最高额度(元)", nil) textColor:[UIColor whiteColor] fontSize:SemiboldFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_moneyTipLable];
        [_moneyTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(17.5));
            make.top.mas_equalTo(Adaptor_Value(22.5));
            make.width.mas_equalTo(LQScreemW - Adaptor_Value(17.5) * 2);
        }];
        
        _moneyLabel = [UILabel lableWithText:lqLocalized(@"200000", nil) textColor:[UIColor whiteColor] fontSize:SemiboldFONT(50) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.moneyTipLable);
            make.top.mas_equalTo(weakSelf.moneyTipLable.mas_bottom).offset(Adaptor_Value(10));
        }];

        UIView *line = [UIView new];
        [contentV addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kOnePX);
            make.left.mas_equalTo(weakSelf.moneyTipLable);
            make.right.mas_equalTo(contentV.mas_centerX);
            make.top.mas_equalTo(weakSelf.moneyLabel.mas_bottom).offset(Adaptor_Value(20));
        }];
        
//        虚线
        CAShapeLayer *borderLayer = [CAShapeLayer layer];
        borderLayer.bounds = CGRectMake(0, 0, LQScreemW * 0.5 - Adaptor_Value(17.5), kOnePX);
        borderLayer.position = CGPointMake(CGRectGetMidX(borderLayer.bounds), CGRectGetMidY(borderLayer.bounds));
        borderLayer.lineWidth = kOnePX * 2;
        //虚线边框 线间距
        borderLayer.lineDashPattern = @[@2, @2];
        borderLayer.fillColor = nil;
        borderLayer.strokeColor = [UIColor whiteColor].CGColor;
        
        //  设置路径
        
        CGMutablePathRef path =CGPathCreateMutable();
        
        CGPathMoveToPoint(path,NULL, 0,0);
        
        CGPathAddLineToPoint(path,NULL,LQScreemW * 0.5 - Adaptor_Value(17.5),0);
        
        [borderLayer setPath:path];
        
        CGPathRelease(path);
        

        [line.layer addSublayer:borderLayer];

        _rateTipLabel = [UILabel lableWithText:lqLocalized(@"日利率0.05%起", nil) textColor:[UIColor whiteColor] fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_rateTipLabel];
        [_rateTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.moneyTipLable);
            make.top.mas_equalTo(line.mas_bottom).offset(Adaptor_Value(33));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(15));
        }];

        CGFloat H = [_header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;

        /**
         *  1.通过CAGradientLayer 设置渐变的背景。
         */
        CAGradientLayer *layer1 = [CAGradientLayer new];
        //colors存放渐变的颜色的数组
        NSArray *colorArray = @[(__bridge id)BlueJianbian1.CGColor,(__bridge id)BlueJianbian2.CGColor];
        layer1.colors=colorArray;
        layer1.startPoint = CGPointMake(0.0, 0.0);
        layer1.endPoint = CGPointMake(0.6, 0);
        layer1.frame = CGRectMake(0, 0, LQScreemW, H);
        [contentV.layer insertSublayer:layer1 atIndex:0];
    }
    return _header;
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

- (UIView *)centerView{
    if (!_centerView) {
        _centerView = [UIView new];
        UIView *contentV = [UIView new];
        contentV.backgroundColor = BackGrayColor;
        [_centerView addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.centerView);
        }];
        _centerTipLable = [UILabel lableWithText:@"101918人已下款 应急上岸首选" textColor:TitleBlackColor fontSize:SemiboldFONT(18) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_centerTipLable];
        [_centerTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Adaptor_Value(20));
            make.centerX.mas_equalTo(contentV);
        }];
       
        
        _centerTipSubLabel = [UILabel lableWithText:lqLocalized(@"大数据智能优选，让每一个人都能借到钱", nil) textColor:TitleBlackColor fontSize:RegularFONT(12) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_centerTipSubLabel];
        [_centerTipSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.centerTipLable.mas_bottom).offset(Adaptor_Value(10));
        }];
        
        _phoneTfBackView = [UIView new];
        _phoneTfBackView.backgroundColor = [UIColor whiteColor];
        [contentV addSubview:_phoneTfBackView];
        [_phoneTfBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(20));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(20));
            make.top.mas_equalTo(weakSelf.centerTipSubLabel.mas_bottom).offset(Adaptor_Value(20));
            make.height.mas_equalTo(RI.is_logined ? Adaptor_Value(0) : Adaptor_Value(50));
        }];
        _phoneTfBackView.hidden = RI.is_logined;
        ViewRadius(_phoneTfBackView, 5);
        _phoneTfBackView.layer.shadowColor = YinYingColor.CGColor;
        _phoneTfBackView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        _phoneTfBackView.layer.shadowOpacity = 0.5f;
        _phoneTfBackView.layer.shadowRadius = 5;
        _phoneTfBackView.layer.masksToBounds = NO;
        
        _phoneTf = [[UITextField alloc] init];
        [_phoneTfBackView addSubview:_phoneTf];
        [_phoneTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(20));
            make.top.bottom.right.mas_equalTo(weakSelf.phoneTfBackView);
        }];
        _phoneTf.placeholder = lqLocalized(@"请填写本人手机号码", nil);
        _phoneTf.keyboardType = UIKeyboardTypeNumberPad;
        
        _tuxingTfBackView = [UIView new];
        _tuxingTfBackView.backgroundColor = [UIColor whiteColor];
        [contentV addSubview:_tuxingTfBackView];
        [_tuxingTfBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(20));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(20));
            make.top.mas_equalTo(weakSelf.phoneTfBackView.mas_bottom).offset(Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(0));
        }];
        //默认隐藏
        _tuxingTfBackView.hidden = YES;
        ViewRadius(_tuxingTfBackView, 5);
        _tuxingTfBackView.layer.shadowColor = YinYingColor.CGColor;
        _tuxingTfBackView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        _tuxingTfBackView.layer.shadowOpacity = 0.5f;
        _tuxingTfBackView.layer.shadowRadius = 5;
        _tuxingTfBackView.layer.masksToBounds = NO;
        
        _tuxingTf = [[UITextField alloc] init];
        [_tuxingTfBackView addSubview:_tuxingTf];
        [_tuxingTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(20));
            make.top.bottom.right.mas_equalTo(weakSelf.tuxingTfBackView);
        }];
        _tuxingTf.placeholder = lqLocalized(@"请输入右侧数字", nil);
        _tuxingImageView = [UIImageView new];
        _tuxingImageView.backgroundColor = TitleGrayColor;
        [_tuxingTfBackView addSubview:_tuxingImageView];
        [_tuxingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.tuxingTfBackView).offset(-Adaptor_Value(5));
            make.top.mas_equalTo(Adaptor_Value(5));
            make.bottom.mas_equalTo(weakSelf.tuxingTfBackView).offset(-Adaptor_Value(5));
            make.width.mas_equalTo(Adaptor_Value(100));
        }];
        UITapGestureRecognizer *tuxingTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tuxingTap:)];
        _tuxingImageView.userInteractionEnabled = YES;
        [_tuxingImageView addGestureRecognizer:tuxingTap];
        
        
        UIView *codetextFBackView = [UIView new];
        _codeTfBackView = codetextFBackView;
        codetextFBackView.backgroundColor = [UIColor whiteColor];
        [contentV addSubview:codetextFBackView];
        [codetextFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.tuxingTfBackView);
        }];
        ViewRadius(codetextFBackView, 5);
        codetextFBackView.layer.shadowColor = YinYingColor.CGColor;
        codetextFBackView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        codetextFBackView.layer.shadowOpacity = 0.5f;
        codetextFBackView.layer.shadowRadius = 5;
        codetextFBackView.layer.masksToBounds = NO;
        //默认隐藏
        _codeTfBackView.hidden = YES;

        _codeTf = [[UITextField alloc] init];
        [codetextFBackView addSubview:_codeTf];
        [_codeTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(20));
            make.top.bottom.right.mas_equalTo(codetextFBackView);
        }];
        _codeTf.placeholder = lqLocalized(@"请输入短信验证码", nil);
        
        UIButton *codeBtn = [[UIButton alloc] init];
        _codeBtn = codeBtn;
        [codeBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        codeBtn.titleLabel.font = RegularFONT(15);
        [codeBtn setTitle:lqLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [codeBtn setTitleColor:[UIColor colorWithHexString:@"a4a4a4"] forState:UIControlStateNormal];
        [codetextFBackView addSubview:codeBtn];
        [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(50));
            make.right.mas_equalTo(codetextFBackView).offset(-Adaptor_Value(10));
            make.centerY.mas_equalTo(codetextFBackView);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor colorWithHexString:@"a4a4a4"];
        [codetextFBackView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(20));
            make.width.mas_equalTo(kOnePX);
            make.right.mas_equalTo(codeBtn.mas_left).offset(Adaptor_Value(-5));
            make.centerY.mas_equalTo(codetextFBackView);
        }];

        
        _confirmBtn = [[CommonBtn alloc] init];
        [_confirmBtn setTitle:lqLocalized(@"立即登录", nil) forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchDown];
        [contentV addSubview:_confirmBtn];
        _confirmBtn.CommonBtnEndLongPressBlock = ^(UIButton *sender){
            [weakSelf confirmBtnClick:sender];
        };
        [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(20));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(20));
            make.top.mas_equalTo(weakSelf.tuxingTfBackView.mas_bottom).offset(RI.is_logined ? Adaptor_Value(0) : Adaptor_Value(20));
            make.height.mas_equalTo(Adaptor_Value(50));
        }];
        UIView *btnShadow = [UIView new];
        btnShadow.backgroundColor = [UIColor whiteColor];
        [contentV insertSubview:btnShadow belowSubview:_confirmBtn];
        [btnShadow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(weakSelf.confirmBtn);
            make.width.mas_equalTo(weakSelf.confirmBtn).offset(-5);
            make.centerX.mas_equalTo(weakSelf.confirmBtn);
        }];
        //按钮阴影
        btnShadow.layer.shadowColor = [UIColor colorWithHexString:@"#ff0000" alpha:0.4].CGColor;
        btnShadow.layer.shadowOpacity = 0.5f;
        btnShadow.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);//和下方 配合偏移
        btnShadow.layer.shadowRadius = 10;
        btnShadow.layer.masksToBounds = NO;
        
        
        _progressTipLable = [UILabel lableWithText:lqLocalized(@"开通VIP会员 > 一对一服务 > 准确匹配贷款 > 成功下款", nil) textColor:TitleGrayColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_progressTipLable];
        [_progressTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.confirmBtn.mas_bottom).offset(Adaptor_Value(25));
            make.centerX.mas_equalTo(contentV);
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(17));
        }];
    }
    return _centerView;
}
- (UIView *)bottomVIew{
    if (!_bottomVIew) {
        _bottomVIew = [UIView new];
        UIView *contentV = [UIView new];
        [_bottomVIew addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.bottomVIew);

        }];
//        [contentV addSubview:self.bottomCollectionView];
//        [self.bottomCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(Adaptor_Value(155));
//            make.left.right.mas_equalTo(contentV);
//            make.top.mas_equalTo(contentV);
//        }];
        
        _infiniteView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Adaptor_Value(250), Adaptor_Value(155)) delegate:self placeholderImage:nil];
        _infiniteView.backgroundColor = [UIColor clearColor];
        _infiniteView.boworrWidth = AdaptedWidth(250);
        _infiniteView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
        _infiniteView.cellSpace = Adaptor_Value(10);

        [contentV addSubview:_infiniteView];
        [_infiniteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(155));
            make.left.right.mas_equalTo(contentV);
            make.top.mas_equalTo(contentV);
        }];
        
        _bottomTipLable = [UILabel lableWithText:lqLocalized(@"只要你想，我们就能帮你贷到!", nil) textColor:TitleBlackColor fontSize:RegularFONT(20) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTipLable];
        [_bottomTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.infiniteView.mas_bottom).offset(Adaptor_Value(35));
            make.centerX.mas_equalTo(contentV);
        }];
        
        _bottomTipSubLabel = [UILabel lableWithText:lqLocalized(@"借款服务由合作金融机构提供", nil) textColor:TitleGrayColor fontSize:RegularFONT(12) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTipSubLabel];
        [_bottomTipSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.bottomTipLable.mas_bottom).offset(Adaptor_Value(10));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(20));
        }];
        
    }
    return _bottomVIew;
}
//-(UICollectionView *)bottomCollectionView{
//    if (!_bottomCollectionView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        //设置collectionView滚动方向
//        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//
//        _bottomCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//        _bottomCollectionView.backgroundColor = [UIColor clearColor];
//        [_bottomCollectionView registerClass:[HomeBottomCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeBottomCollectionViewCell class])];
//        _bottomCollectionView.delegate = self;
//        _bottomCollectionView.dataSource = self;
//        _bottomCollectionView.showsVerticalScrollIndicator = NO;
//        _bottomCollectionView.showsHorizontalScrollIndicator = NO;
//
//    }
//    return _bottomCollectionView;
//}

@end
