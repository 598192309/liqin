//
//  PersonalLoanCustomView.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/5.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "PersonalLoanCustomView.h"
#import "OptionSelectViewTool.h"
#import "CeSuanViewBottomCell.h"
#import "NormalOneTitleCell.h"
#import "HomeModel.h"
#import "Account.h"


@interface PersonalLoanCustomView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UIImageView *topTipImageV;
@property (nonatomic,strong)UIView *cornerView;
@property (nonatomic,strong)UILabel *topTipLable;
@property (nonatomic,strong)UILabel *moneyTipLabel;
@property (nonatomic,strong)UILabel *moneyLable;
@property (nonatomic,strong)UILabel *feeTipLabel;
@property (nonatomic,strong)UILabel *feeLabel;
@property (nonatomic,strong)UILabel *payTimeTipLable;
@property (nonatomic,strong)UILabel *payTimeLable;
@property (nonatomic,strong)UILabel *detailTipLable;
@property (nonatomic,strong)UILabel *kefuTipLable;


@property (nonatomic,strong)UIView *infoView;
@property (nonatomic,strong)UILabel *infoViewTipLable1;
@property (nonatomic,strong)UILabel *infoViewTipSubLabel1;
@property (nonatomic,strong)UITextField *nameTextF;
@property (nonatomic,strong)UITextField *idcardTextF;
@property (nonatomic,strong)UITextField *bankcardTextF;
@property (nonatomic,strong)UITextField *phoneTextF;
@property (nonatomic,strong)UILabel *infoViewTipLable2;
@property (nonatomic,strong)UILabel *infoViewTipSubLabel2;
@property (nonatomic,strong)UITextField *zhimaTextF;
@property (nonatomic,strong)UITextField *qqTextF;
@property (nonatomic,strong)UITextField *xueliTextF;
@property (nonatomic,strong)UITextField *graduationTextF;
@property (nonatomic,strong)UITextField *provinceTextF;
@property (nonatomic,strong)UITextField *cityTextF;

@property (nonatomic,strong)UIView *chooseView;
@property (nonatomic,strong)UILabel *chooseTipLable1;
@property (nonatomic,strong)UILabel *chooseTipSubLable1;
//@property (nonatomic,strong)UICollectionView *chooseCollectionView1;
@property (nonatomic,strong)UILabel *chooseTipLable2;
@property (nonatomic,strong)UILabel *chooseTipSubLable2;
//@property (nonatomic,strong)UICollectionView *chooseCollectionView2;




@property (nonatomic,strong)LoanBuildInfoItem *loanBuildInfoItem;
@property (nonatomic,strong)NSString *provice;
@property (nonatomic,strong)NSString *cityID;
@property (nonatomic,strong)NSString *educationID;


@end
@implementation PersonalLoanCustomView
#pragma mark - setter
- (void)setProvinceArr:(NSArray *)provinceArr{
    _provinceArr = provinceArr;
}
- (void)setCityArr:(NSArray *)cityArr{
    _cityArr = cityArr;
}

- (NSDictionary *)infoDict{
    return @{@"real_name":self.nameTextF.text,@"idno":self.idcardTextF.text,@"bankcard":self.bankcardTextF.text,@"mobile":self.phoneTextF.text,@"zhima":self.zhimaTextF.text,@"qq":self.qqTextF.text,@"education":SAFE_NIL_STRING(self.educationID),@"graduation":self.graduationTextF.text,@"province":SAFE_NIL_STRING(self.provice),@"city":SAFE_NIL_STRING(self.cityID)};
}
#pragma mark - 生命周期
-(instancetype)init{
    if (self = [super init]) {
        [self configUI];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
#pragma mark - ui
-(void)configUI{
    [self addSubview:self.header];
    [self addSubview:self.infoView];
//    [self addSubview:self.chooseView];
    __weak __typeof(self) weakSelf = self;
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf);
    }];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.header.mas_bottom);
        
    }];
//    [self.chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(weakSelf);
//        make.top.mas_equalTo(weakSelf.infoView.mas_bottom).offset(Adaptor_Value(10));
//    }];

}

#pragma mark - refresh ui
- (void)configUIWithItem:(LoanBuildInfoItem *)item finishBlock:(void(^)())finishBlock{
    _loanBuildInfoItem = item;
    if (!RI.is_vest) {
        _topTipLable.text = lqLocalized(@"完善个人信息 > 开始一对一服务 > 成功下款", nil);
        _moneyTipLabel.text = lqLocalized(@"目标金额", nil);
        _feeTipLabel.text = lqLocalized(@"已付服务费", nil);
        _payTimeTipLable.text = lqLocalized(@"付款时间", nil);
        _detailTipLable.text = lqLocalized(@"为精准匹配合适的贷款产品，请完善以下信息", nil);
        _kefuTipLable.text = lqLocalized(@"请求客服协助", nil);
        
        _infoViewTipLable1.text = lqLocalized(@"1.实名信息", nil);
        _infoViewTipSubLabel1.text = lqLocalized(@"绑定您的银行卡，用于下款不成功时的渠道管理费返还", nil);
        _infoViewTipLable2.text = lqLocalized(@"2.基本信息", nil);
        _infoViewTipSubLabel2.text = lqLocalized(@"若因资料不实导致下款失败，渠道管理费将不予退还。", nil);

        _chooseTipLable1.text = lqLocalized(@"3.选择题1", nil);
        _chooseTipSubLable1.text = lqLocalized(@"若因资料不实导致下款失败，渠道管理费将不予退还。", nil);
        _chooseTipLable2.text = lqLocalized(@"4.选择题2", nil);
        _chooseTipSubLable2.text = lqLocalized(@"若因资料不实导致下款失败，渠道管理费将不予退还。", nil);
        
    }
    LoanRecordInfoItem * loanItem = item.loan;
//    self.moneyLable.text =  loanItem.title;
    NSString *str = [NSString stringWithFormat:@"￥%@",loanItem.title];
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    NSRange range = [str rangeOfString:NSLocalizedString(@"￥", nil)];
    if (range.length > 0) {
        [attribtStr addAttribute:NSFontAttributeName value:SemiboldFONT(36) range:NSMakeRange(range.location + 1, str.length - range.location - range.length)];
        
    }
    self.moneyLable.attributedText = attribtStr;
    self.feeLabel.text = [NSString stringWithFormat:@"￥%ld",loanItem.total_fee] ;
    self.payTimeLable.text =  loanItem.applied_at;

    RealNameInfoItem *nameItem = item.real_name_info;
    self.nameTextF.text =  nameItem.real_name;
    self.idcardTextF.text =  nameItem.idno;
    self.bankcardTextF.text =  nameItem.bankcard;
    self.phoneTextF.text =  nameItem.mobile;

    BaseInfoItem *infoItem = item.base_info;
    self.zhimaTextF.text =  infoItem.zhima;
    self.qqTextF.text =  infoItem.qq;
    self.graduationTextF.text =  infoItem.graduation;
    self.cityTextF.text =  infoItem.graduation;
    
    
    EducationItem *educationItem = infoItem.education;
    if (educationItem.selected.length > 0) {
        self.xueliTextF.text =  [educationItem.list safeObjectAtIndex:[educationItem.selected integerValue]];
    }

    if (infoItem.province.length > 0) {
        for (ProvincesCityItem *placeItem in self.provinceArr) {
            if (placeItem.selected) {
                self.provinceTextF.text =  placeItem.name;
            }
        }
    }
    self.provice = infoItem.province;
    
    if (infoItem.city.length > 0) {
        for (ProvincesCityItem *placeItem in self.cityArr) {
            if (placeItem.selected) {
                self.cityTextF.text =  placeItem.name;
            }
        }
    }

    CGFloat h = [_cornerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    /**
     *  1.通过CAGradientLayer 设置渐变的背景。
     */
    CAGradientLayer *layer1 = [CAGradientLayer new];
    //colors存放渐变的颜色的数组
    NSArray *colorArray = @[(__bridge id)BlueJianbian1.CGColor,(__bridge id)BlueJianbian2.CGColor];
    layer1.colors=colorArray;
    layer1.startPoint = CGPointMake(0.0, 0.0);
    layer1.endPoint = CGPointMake(0.6, 0);
    layer1.frame = CGRectMake(0, 0, LQScreemW - AdaptedWidth(25)*2, h);
    [_cornerView.layer insertSublayer:layer1 atIndex:0];
    [_cornerView setLayerCornerRadius:11];
    
    
    finishBlock();
}
#pragma mark - act
- (void)confirmBtnClick:(UIButton *)sender{

    
}
- (void)xuelichoose:(UIButton *)sender{
    __weak __typeof(self) weakSelf = self;
    [OptionSelectViewTool viewShowWhiteTitleArray:self.loanBuildInfoItem.base_info.education.list block:^(NSString * _Nullable title,NSInteger row) {
        weakSelf.xueliTextF.text = title;
        weakSelf.educationID = [NSString stringWithFormat:@"%ld",row];
    } viewHiden:^{
    }];
}
- (void)graduationchoose:(UIButton *)sender{
    NSArray *arr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    __weak __typeof(self) weakSelf = self;
    [OptionSelectViewTool viewShowWhiteTitleArray:arr block:^(NSString * _Nullable title,NSInteger row) {
        weakSelf.graduationTextF.text = title;

    } viewHiden:^{
    }];
}
- (void)provincechoose:(UIButton *)sender{
    __weak __typeof(self) weakSelf = self;
    NSMutableArray *arr = [NSMutableArray array];
    for (ProvincesCityItem * item in self.provinceArr) {
        [arr addObject:item.name];
    }
    [OptionSelectViewTool viewShowWhiteTitleArray:arr block:^(NSString * _Nullable title,NSInteger row) {
        weakSelf.provinceTextF.text = title;
        ProvincesCityItem *item = [self.provinceArr safeObjectAtIndex:row];
        weakSelf.provice = [NSString stringWithFormat:@"%ld",item.ID];
    } viewHiden:^{
    }];
}
- (void)citychoose:(UIButton *)sender{
    
    if (self.cityArr.count > 0 && self.loanBuildInfoItem.base_info.city.length > 0) {
        __weak __typeof(self) weakSelf = self;
        NSMutableArray *arr = [NSMutableArray array];
        for (ProvincesCityItem * item in self.cityArr) {
            [arr addObject:item.name];
        }

        [OptionSelectViewTool viewShowWhiteTitleArray:arr block:^(NSString * _Nullable title,NSInteger row) {
            weakSelf.cityTextF.text = title;
            ProvincesCityItem *item = [self.cityArr safeObjectAtIndex:row];
            weakSelf.cityID = [NSString stringWithFormat:@"%ld",item.ID];

        } viewHiden:^{
        }];

    }else{
        if (self.personalLoanCustomViewCityClickBlock) {
            self.personalLoanCustomViewCityClickBlock(sender,self.provice);
        }
    }
}
- (void)cityShow{
    __weak __typeof(self) weakSelf = self;
    NSMutableArray *arr = [NSMutableArray array];
    for (ProvincesCityItem * item in self.cityArr) {
        [arr addObject:item.name];
    }
    
    [OptionSelectViewTool viewShowWhiteTitleArray:arr block:^(NSString * _Nullable title,NSInteger row) {
        weakSelf.cityTextF.text = title;
        ProvincesCityItem *item = [self.cityArr safeObjectAtIndex:row];
        weakSelf.cityID = [NSString stringWithFormat:@"%ld",item.ID];

        
    } viewHiden:^{
    }];
}

- (void)kefuTap:(UITapGestureRecognizer *)gest{
    if ([self canOpenQQ]) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",RI.customer_qq]];
        UIApplication *application = [UIApplication sharedApplication];
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [application openURL:url options:@{} completionHandler:nil];
        }else{
            [application openURL:url];
        }
    }else{
        [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"未安装QQ", nil)];
    }
}



- (BOOL)canOpenQQ{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
}
#pragma mark - lazy
- (UIView *)header{
    if (!_header) {
        _header = [UIView new];
        UIView *contentV = [UIView new];
        contentV.backgroundColor = [UIColor whiteColor];

        [_header addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.header);
        }];
        
        _topTipImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apply"]];
        [contentV addSubview:_topTipImageV];
        [_topTipImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(21));
            make.width.mas_equalTo(Adaptor_Value(130));
            make.top.mas_equalTo(Adaptor_Value(40));
            make.centerX.mas_equalTo(contentV);
        }];
        
        _topTipLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_topTipLable];
        [_topTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.topTipImageV.mas_bottom).offset(Adaptor_Value(14));
        }];
        
        UIView *cornerView = [UIView new];
        _cornerView = cornerView;
        [contentV addSubview:cornerView];
        [cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(25));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(25));
            make.top.mas_equalTo(weakSelf.topTipLable.mas_bottom).offset(Adaptor_Value(15));
        }];
  

        
        _moneyTipLabel = [UILabel lableWithText:@"" textColor:[UIColor whiteColor] fontSize:RegularFONT(15) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [cornerView addSubview:_moneyTipLabel];
        [_moneyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Adaptor_Value(24));
            make.left.mas_equalTo(Adaptor_Value(17.5));
        }];
        _moneyLable = [UILabel lableWithText:@"" textColor:[UIColor whiteColor] fontSize:RegularFONT(17) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [cornerView addSubview:_moneyLable];
        [_moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.moneyTipLabel.mas_bottom).offset(Adaptor_Value(5));
            make.left.mas_equalTo(weakSelf.moneyTipLabel);
        }];
        
        
        _feeTipLabel = [UILabel lableWithText:@"" textColor:[UIColor whiteColor] fontSize:RegularFONT(15) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [cornerView addSubview:_feeTipLabel];
        [_feeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.moneyLable.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.moneyTipLabel);
        }];
        _feeLabel = [UILabel lableWithText:@"" textColor:[UIColor whiteColor] fontSize:RegularFONT(15) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [cornerView addSubview:_feeLabel];
        [_feeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.feeTipLabel);
            make.right.mas_equalTo(cornerView).offset(-Adaptor_Value(17.5));
        }];
        
        
        _payTimeTipLable = [UILabel lableWithText:@"" textColor:[UIColor whiteColor] fontSize:RegularFONT(15) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [cornerView addSubview:_payTimeTipLable];
        [_payTimeTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.feeTipLabel.mas_bottom).offset(Adaptor_Value(12));
            make.left.mas_equalTo(weakSelf.moneyTipLabel);
        }];
        _payTimeLable = [UILabel lableWithText:@"" textColor:[UIColor whiteColor] fontSize:RegularFONT(15) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [cornerView addSubview:_payTimeLable];
        [_payTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.payTimeTipLable);
            make.right.mas_equalTo(cornerView).offset(-Adaptor_Value(17.5));
            make.bottom.mas_equalTo(cornerView).offset(-Adaptor_Value(23));
        }];
        
      

        
        _detailTipLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(15) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_detailTipLable];
        [_detailTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(cornerView.mas_bottom).offset(Adaptor_Value(18));
        }];
        _kefuTipLable = [UILabel lableWithText:@"" textColor:BlueJianbian1 fontSize:RegularFONT(15) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_kefuTipLable];
        [_kefuTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.detailTipLable.mas_bottom).offset(Adaptor_Value(5));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(10));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kefuTap:)];
        _kefuTipLable.userInteractionEnabled = YES;
        [_kefuTipLable addGestureRecognizer:tap];
        
        

    }
    return _header;
}

- (UIView *)infoView{
    if (!_infoView) {
        _infoView = [UIView new];
        UIView *contentV = [UIView new];
        contentV.backgroundColor = BackGroundColor;

        [_infoView addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.infoView);
        }];
        _infoViewTipLable1 = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:SemiboldFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_infoViewTipLable1];
        [_infoViewTipLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(25));
            make.top.mas_equalTo(Adaptor_Value(20));
        }];
        _infoViewTipSubLabel1 = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_infoViewTipSubLabel1];
        [_infoViewTipSubLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.infoViewTipLable1);
            make.top.mas_equalTo(weakSelf.infoViewTipLable1.mas_bottom).offset(Adaptor_Value(10));
        }];

        
        UIView *nameTFBackView = [UIView new];
        nameTFBackView.backgroundColor = [UIColor whiteColor];
        [contentV addSubview:nameTFBackView];
        [nameTFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(25));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(25));
            make.top.mas_equalTo(weakSelf.infoViewTipSubLabel1.mas_bottom).offset(Adaptor_Value(14));
            make.height.mas_equalTo(Adaptor_Value(60));
        }];
        nameTFBackView.layer.shadowColor = YinYingColor.CGColor;
        nameTFBackView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        nameTFBackView.layer.shadowOpacity = 0.5f;
        nameTFBackView.layer.shadowRadius = 5;
        nameTFBackView.layer.masksToBounds = NO;
        
        _nameTextF = [[UITextField alloc] init];
        [nameTFBackView addSubview:_nameTextF];
        [_nameTextF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.top.bottom.right.mas_equalTo(nameTFBackView);
        }];
        _nameTextF.placeholder = lqLocalized(@"输入真实姓名", nil);
        
        
        UIView *idcardTFBackView = [UIView new];
        idcardTFBackView.backgroundColor = [UIColor whiteColor];
        [contentV addSubview:idcardTFBackView];
        [idcardTFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(nameTFBackView);
            make.right.mas_equalTo(nameTFBackView);
            make.top.mas_equalTo(nameTFBackView.mas_bottom).offset(Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(60));
        }];
        idcardTFBackView.layer.shadowColor = YinYingColor.CGColor;
        idcardTFBackView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        idcardTFBackView.layer.shadowOpacity = 0.5f;
        idcardTFBackView.layer.shadowRadius = 5;
        idcardTFBackView.layer.masksToBounds = NO;
        
        _idcardTextF = [[UITextField alloc] init];
        [idcardTFBackView addSubview:_idcardTextF];
        [_idcardTextF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.top.bottom.right.mas_equalTo(idcardTFBackView);
        }];
        _idcardTextF.placeholder = lqLocalized(@"输入身份证号码", nil);
        
        UIView *bankTFBackView = [UIView new];
        bankTFBackView.backgroundColor = [UIColor whiteColor];
        [contentV addSubview:bankTFBackView];
        [bankTFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(nameTFBackView);
            make.right.mas_equalTo(nameTFBackView);
            make.top.mas_equalTo(idcardTFBackView.mas_bottom).offset(Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(60));
        }];
        bankTFBackView.layer.shadowColor = YinYingColor.CGColor;
        bankTFBackView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        bankTFBackView.layer.shadowOpacity = 0.5f;
        bankTFBackView.layer.shadowRadius = 5;
        bankTFBackView.layer.masksToBounds = NO;
        _bankcardTextF = [[UITextField alloc] init];
        [bankTFBackView addSubview:_bankcardTextF];
        [_bankcardTextF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.top.bottom.right.mas_equalTo(bankTFBackView);
        }];
        _bankcardTextF.placeholder = lqLocalized(@"输入银行卡号", nil);
        
        
        UIView *phoneTFBackView = [UIView new];
        phoneTFBackView.backgroundColor = [UIColor whiteColor];
        [contentV addSubview:phoneTFBackView];
        [phoneTFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(nameTFBackView);
            make.right.mas_equalTo(nameTFBackView);
            make.top.mas_equalTo(bankTFBackView.mas_bottom).offset(Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(60));
        }];
        phoneTFBackView.layer.shadowColor = YinYingColor.CGColor;
        phoneTFBackView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        phoneTFBackView.layer.shadowOpacity = 0.5f;
        phoneTFBackView.layer.shadowRadius = 5;
        phoneTFBackView.layer.masksToBounds = NO;
        _phoneTextF = [[UITextField alloc] init];
        [phoneTFBackView addSubview:_phoneTextF];
        [_phoneTextF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.top.bottom.right.mas_equalTo(phoneTFBackView);
        }];
        _phoneTextF.placeholder = lqLocalized(@"输入银行预留手机号", nil);
        _phoneTextF.keyboardType = UIKeyboardTypeNumberPad;
        
        
        _infoViewTipLable2 = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:SemiboldFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_infoViewTipLable2];
        [_infoViewTipLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.infoViewTipLable1);
            make.top.mas_equalTo(phoneTFBackView.mas_bottom).offset(Adaptor_Value(35));
        }];
        _infoViewTipSubLabel2 = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_infoViewTipSubLabel2];
        [_infoViewTipSubLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.infoViewTipLable2);
            make.top.mas_equalTo(weakSelf.infoViewTipLable2.mas_bottom).offset(Adaptor_Value(10));
        }];
        
        
        UIView *zhimaTFBackView = [UIView new];
        zhimaTFBackView.backgroundColor = [UIColor whiteColor];
        [contentV addSubview:zhimaTFBackView];
        [zhimaTFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(25));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(25));
            make.top.mas_equalTo(weakSelf.infoViewTipSubLabel2.mas_bottom).offset(Adaptor_Value(14));
            make.height.mas_equalTo(Adaptor_Value(60));
        }];
        zhimaTFBackView.layer.shadowColor = YinYingColor.CGColor;
        zhimaTFBackView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        zhimaTFBackView.layer.shadowOpacity = 0.5f;
        zhimaTFBackView.layer.shadowRadius = 5;
        zhimaTFBackView.layer.masksToBounds = NO;
        
        _zhimaTextF = [[UITextField alloc] init];
        [zhimaTFBackView addSubview:_zhimaTextF];
        [_zhimaTextF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.top.bottom.right.mas_equalTo(zhimaTFBackView);
        }];
        _zhimaTextF.placeholder = lqLocalized(@"请填写真是的芝麻信用分", nil);
        
        
        UIView *qqTFBackView = [UIView new];
        qqTFBackView.backgroundColor = [UIColor whiteColor];
        [contentV addSubview:qqTFBackView];
        [qqTFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(zhimaTFBackView);
            make.right.mas_equalTo(zhimaTFBackView);
            make.top.mas_equalTo(zhimaTFBackView.mas_bottom).offset(Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(60));
        }];
        qqTFBackView.layer.shadowColor = YinYingColor.CGColor;
        qqTFBackView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        qqTFBackView.layer.shadowOpacity = 0.5f;
        qqTFBackView.layer.shadowRadius = 5;
        qqTFBackView.layer.masksToBounds = NO;
        
        _qqTextF = [[UITextField alloc] init];
        [qqTFBackView addSubview:_qqTextF];
        [_qqTextF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.top.bottom.right.mas_equalTo(qqTFBackView);
        }];
        _qqTextF.placeholder = lqLocalized(@"请填写您的QQ号码，方便我们为您服务", nil);
        
        
        UIView *xueliTFBackView = [UIView new];
        xueliTFBackView.backgroundColor = [UIColor whiteColor];
        [contentV addSubview:xueliTFBackView];
        [xueliTFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(qqTFBackView);
            make.right.mas_equalTo(contentV.mas_centerX).offset(-Adaptor_Value(2.5));
            make.top.mas_equalTo(qqTFBackView.mas_bottom).offset(Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(60));
        }];
        xueliTFBackView.layer.shadowColor = YinYingColor.CGColor;
        xueliTFBackView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        xueliTFBackView.layer.shadowOpacity = 0.5f;
        xueliTFBackView.layer.shadowRadius = 5;
        xueliTFBackView.layer.masksToBounds = NO;
        
        _xueliTextF = [[UITextField alloc] init];
        [xueliTFBackView addSubview:_xueliTextF];
        [_xueliTextF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.top.bottom.right.mas_equalTo(xueliTFBackView);
        }];
        _xueliTextF.placeholder = lqLocalized(@"最高学历", nil);
        _xueliTextF.userInteractionEnabled = NO;
        
        UIButton *chooseBtn1 = [UIButton buttonWithTitle:@"" titleColor:nil titleFont:nil backGroundColor:TitleGrayColor normalImage:[UIImage imageNamed:@"down"] selectedImage:[UIImage imageNamed:@"down"] Target:self action:@selector(xuelichoose:) rect:CGRectZero];
        [xueliTFBackView addSubview:chooseBtn1];
        [chooseBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.top.mas_equalTo(weakSelf.xueliTextF);
            make.width.mas_equalTo(AdaptedWidth(35));
        }];

        
        UIView *graductionTFBackView = [UIView new];
        graductionTFBackView.backgroundColor = [UIColor whiteColor];
        [contentV addSubview:graductionTFBackView];
        [graductionTFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(contentV.mas_centerX).offset(Adaptor_Value(2.5));
            make.right.mas_equalTo(qqTFBackView);
            make.top.mas_equalTo(qqTFBackView.mas_bottom).offset(Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(60));
        }];
        graductionTFBackView.layer.shadowColor = YinYingColor.CGColor;
        graductionTFBackView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        graductionTFBackView.layer.shadowOpacity = 0.5f;
        graductionTFBackView.layer.shadowRadius = 5;
        graductionTFBackView.layer.masksToBounds = NO;
        
        _graduationTextF = [[UITextField alloc] init];
        [graductionTFBackView addSubview:_graduationTextF];
        [_graduationTextF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.top.bottom.right.mas_equalTo(graductionTFBackView);
        }];
        _graduationTextF.placeholder = lqLocalized(@"已毕业年数", nil);
        _graduationTextF.userInteractionEnabled = NO;

        UIButton *chooseBtn2 = [UIButton buttonWithTitle:@"" titleColor:nil titleFont:nil backGroundColor:TitleGrayColor normalImage:[UIImage imageNamed:@"down"] selectedImage:[UIImage imageNamed:@"down"] Target:self action:@selector(graduationchoose:) rect:CGRectZero];
        [graductionTFBackView addSubview:chooseBtn2];
        [chooseBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.top.mas_equalTo(weakSelf.graduationTextF);
            make.width.mas_equalTo(AdaptedWidth(35));
        }];
        
        UIView *provinceTFBackView = [UIView new];
        provinceTFBackView.backgroundColor = [UIColor whiteColor];
        [contentV addSubview:provinceTFBackView];
        [provinceTFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(xueliTFBackView);
            make.right.mas_equalTo(xueliTFBackView);
            make.top.mas_equalTo(xueliTFBackView.mas_bottom).offset(Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(60));
        }];
        provinceTFBackView.layer.shadowColor = YinYingColor.CGColor;
        provinceTFBackView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        provinceTFBackView.layer.shadowOpacity = 0.5f;
        provinceTFBackView.layer.shadowRadius = 5;
        provinceTFBackView.layer.masksToBounds = NO;
        
        _provinceTextF = [[UITextField alloc] init];
        [provinceTFBackView addSubview:_provinceTextF];
        [_provinceTextF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.top.bottom.right.mas_equalTo(provinceTFBackView);
        }];
        _provinceTextF.placeholder = lqLocalized(@"常住省份", nil);
        _provinceTextF.userInteractionEnabled = NO;

        UIButton *chooseBtn3 = [UIButton buttonWithTitle:@"" titleColor:nil titleFont:nil backGroundColor:TitleGrayColor normalImage:[UIImage imageNamed:@"down"] selectedImage:[UIImage imageNamed:@"down"] Target:self action:@selector(provincechoose:) rect:CGRectZero];
        [provinceTFBackView addSubview:chooseBtn3];
        [chooseBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.top.mas_equalTo(weakSelf.provinceTextF);
            make.width.mas_equalTo(AdaptedWidth(35));
        }];
        
        UIView *cityTFBackView = [UIView new];
        cityTFBackView.backgroundColor = [UIColor whiteColor];
        [contentV addSubview:cityTFBackView];
        [cityTFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(graductionTFBackView);
            make.top.mas_equalTo(graductionTFBackView.mas_bottom).offset(Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(60));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(30));

        }];
        cityTFBackView.layer.shadowColor = YinYingColor.CGColor;
        cityTFBackView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        cityTFBackView.layer.shadowOpacity = 0.5f;
        cityTFBackView.layer.shadowRadius = 5;
        cityTFBackView.layer.masksToBounds = NO;
        
        _cityTextF = [[UITextField alloc] init];
        [cityTFBackView addSubview:_cityTextF];
        [_cityTextF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.top.bottom.right.mas_equalTo(cityTFBackView);
        }];
        _cityTextF.placeholder = lqLocalized(@"常住城市", nil);
        _cityTextF.userInteractionEnabled = NO;

        UIButton *chooseBtn4 = [UIButton buttonWithTitle:@"" titleColor:nil titleFont:nil backGroundColor:TitleGrayColor normalImage:[UIImage imageNamed:@"down"] selectedImage:[UIImage imageNamed:@"down"] Target:self action:@selector(citychoose:) rect:CGRectZero];
        [cityTFBackView addSubview:chooseBtn4];
        [chooseBtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.top.mas_equalTo(weakSelf.cityTextF);
            make.width.mas_equalTo(AdaptedWidth(35));
        }];

        
    }
    return _infoView;
}
- (UIView *)chooseView{
    if (!_chooseView) {
        _chooseView = [UIView new];
//        UIView *contentV = [UIView new];
//        contentV.backgroundColor = BackGroundColor;
//
//        [_chooseView addSubview:contentV];
//        __weak __typeof(self) weakSelf = self;
//        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(weakSelf.chooseView);
//        }];
//
//        _chooseTipLable1 = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:SemiboldFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
//        [contentV addSubview:_chooseTipLable1];
//        [_chooseTipLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(Adaptor_Value(25));
//            make.top.mas_equalTo(Adaptor_Value(25));
//        }];
//        _chooseTipSubLable1 = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
//        [contentV addSubview:_chooseTipSubLable1];
//        [_chooseTipSubLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(weakSelf.chooseTipLable1);
//            make.top.mas_equalTo(weakSelf.chooseTipLable1.mas_bottom).offset(Adaptor_Value(10));
//        }];
//
//        [contentV addSubview:self.chooseCollectionView1];
//        [self.chooseCollectionView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(contentV);
//            make.height.mas_equalTo(Adaptor_Value(150));
//            make.top.mas_equalTo(weakSelf.chooseTipSubLable1.mas_bottom).offset(Adaptor_Value(13));
//        }];
//
//        _chooseTipLable2 = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:SemiboldFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
//        [contentV addSubview:_chooseTipLable2];
//        [_chooseTipLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(weakSelf.chooseTipLable1);
//            make.top.mas_equalTo(weakSelf.chooseCollectionView1.mas_bottom).offset(Adaptor_Value(35));
//        }];
//        _chooseTipSubLable2 = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
//        [contentV addSubview:_chooseTipSubLable2];
//        [_chooseTipSubLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(weakSelf.chooseTipLable2);
//            make.top.mas_equalTo(weakSelf.chooseTipLable2.mas_bottom).offset(Adaptor_Value(10));
//        }];
//
//        [contentV addSubview:self.chooseCollectionView2];
//        [self.chooseCollectionView2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(contentV);
//            make.height.mas_equalTo(Adaptor_Value(150));
//            make.top.mas_equalTo(weakSelf.chooseTipSubLable2.mas_bottom).offset(Adaptor_Value(13));
//            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(30));
//        }];
    }
    return _chooseView;
}

@end
