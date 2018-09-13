//
//  MineCustomView.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/30.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "MineCustomView.h"
#import "Account.h"
@interface MineCustomView()
//头部view
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UIImageView *iconImageV;

//center
@property (nonatomic,strong)UIView *centerView;
@property (nonatomic,strong)UILabel *titleTipLabel;
@property (nonatomic,strong)UIView *centerContetView;
@property (nonatomic,strong)UILabel *noLoanTipLabel;
@property (nonatomic,strong)UILabel *xiakuanTipLabel;
@property (nonatomic,strong)UILabel *xiakuanLabel;
@property (nonatomic,strong)UILabel *unpaidServiceFeeTipLabel;
@property (nonatomic,strong)UILabel *unpaidServiceFeeLabel;
@property (nonatomic,strong)UILabel *poposeMoneyTipLabel;
@property (nonatomic,strong)UILabel *poposeMoneyLabel;
@property (nonatomic,strong)UILabel *manageFeeTipLabel;
@property (nonatomic,strong)UILabel *manageFeeLabel;
@property (nonatomic,strong)UILabel *paidCommissionTipLabel;
@property (nonatomic,strong)UILabel *paidCommissionLabel;
@property (nonatomic,strong)UILabel *waitpaidCommissionTipLabel;
@property (nonatomic,strong)UILabel *waitpaidCommissionLabel;
@property (nonatomic,strong)UILabel *contractTipLabel;
@property (nonatomic,strong)UILabel *contractLabel;
@property (nonatomic,strong)UILabel *loanTypeTipLabel;
@property (nonatomic,strong)UILabel *loanTypeLabel;
@property (nonatomic,strong)CommonBtn *confirmBtn;


@end
@implementation MineCustomView
#pragma mark - 生命周期
#pragma mark - 生命周期
-(instancetype)init{
    if (self = [super init]) {
        [self configUI];

    }
    return self;
}
#pragma mark - ui
-(void)configUI{
    [self addSubview:self.header];
    __weak __typeof(self) weakSelf = self;
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf);
    }];
    [self addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.header.mas_bottom);
    }];
}


#pragma mark - 刷新ui
- (void)configUIWithItem:(AccountHomeItem *)item finishi:(void(^)())finishBlock{
    LoanRecordInfoItem *loanItem = [item.list safeObjectAtIndex:0];
    __weak __typeof(self) weakSelf = self;

    _unpaidServiceFeeLabel.text = @"";


    
    if (loanItem.is_vest) {
        _unpaidServiceFeeTipLabel.text = @"";
        [_confirmBtn setTitle:@"" forState:UIControlStateNormal];

    }else{
        if (!loanItem.is_paid_service_fee) {//未支付前期服务费
//            _unpaidServiceFeeTipLabel.text = lqLocalized(@"未支付服务费", nil);
            NSString *str = lqLocalized(@"未支付服务费", nil);
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:BlueJianbian1,NSFontAttributeName:RegularFONT(13)}];
            _unpaidServiceFeeTipLabel.attributedText = attribtStr;
            
            [_confirmBtn setTitle:loanItem.is_paid_commission ? lqLocalized(@"", nil) : lqLocalized(@"前往支付并操作下款", nil) forState:UIControlStateNormal];

            
        }else if (!loanItem.is_perfected) {//已付前期费用但未填写个人信息
//            _unpaidServiceFeeTipLabel.text = lqLocalized(@"未完善个人信息", nil);
            NSString *str = lqLocalized(@"未完善个人信息", nil);
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:BlueJianbian1,NSFontAttributeName:RegularFONT(13)}];
            
            _unpaidServiceFeeTipLabel.attributedText = attribtStr;


            _unpaidServiceFeeLabel.text = lqLocalized(@"立即完善", nil);
            [_confirmBtn setTitle:loanItem.is_paid_commission ? lqLocalized(@"", nil) : lqLocalized(@"开始VIP专属服务", nil) forState:UIControlStateNormal];

            
        }else if (!loanItem.is_loaned) {//已完善个人信息用但未下款
//            _unpaidServiceFeeTipLabel.text = lqLocalized(@"未下款", nil);
            NSString *str = lqLocalized(@"未下款", nil);
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:BlueJianbian1,NSFontAttributeName:RegularFONT(13)}];
            
            _unpaidServiceFeeTipLabel.attributedText = attribtStr;


            [_confirmBtn setTitle:loanItem.is_paid_commission ? lqLocalized(@"", nil) : lqLocalized(@"开始VIP专属服务", nil) forState:UIControlStateNormal];

            
        }else if (!loanItem.is_paid_commission) {//已下款待支付下款佣金 部分支付
            NSString *str = [NSString stringWithFormat:@"￥%ld",loanItem.true_amount];
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:BlueJianbian1}];
            NSRange range = [str rangeOfString:NSLocalizedString(@"￥", nil)];
            if (range.length > 0) {
                [attribtStr addAttribute:NSFontAttributeName value:SemiboldFONT(20) range:NSMakeRange(range.location + 1, str.length - range.location - range.length)];
                
            }
            _unpaidServiceFeeTipLabel.attributedText = attribtStr;

//            _unpaidServiceFeeTipLabel.text = [NSString stringWithFormat:@"￥%ld",loanItem.true_amount];
            
//            if (loanItem.unpaid_commission > 0 && loanItem.paid_commission > 0) {
//                [_confirmBtn setTitle:loanItem.is_paid_commission ? lqLocalized(@"开始VIP专属服务", nil) : lqLocalized(@"支付剩余下款佣金", nil) forState:UIControlStateNormal];
//            }else{
//                [_confirmBtn setTitle:loanItem.is_paid_commission ? lqLocalized(@"", nil) : lqLocalized(@"支付下款佣金", nil) forState:UIControlStateNormal];
//            }
            if (loanItem.is_loaned  && !loanItem.is_paid_commission ) {
                 [_confirmBtn setTitle:loanItem.is_paid_commission ? lqLocalized(@"", nil) : lqLocalized(@"支付下款佣金", nil) forState:UIControlStateNormal];
            }else if (loanItem.is_loaned && loanItem.is_paid_commission  ){
                [_confirmBtn setTitle:loanItem.unpaid_commission > 0 ?lqLocalized(@"支付剩余下款佣金", nil): lqLocalized(@"开始VIP专属服务", nil)  forState:UIControlStateNormal];
            }
        }
    }
    
//    if (loanItem.is_paid_commission || loanItem.is_loaned) {//已下款待支付下款佣金 部分支付
//        _paidCommissionTipLabel.text = loanItem.is_vest ? @"" : lqLocalized(@"已支付下款佣金", nil);
//        _waitpaidCommissionTipLabel.text = loanItem.is_vest ? @"" : lqLocalized(@"待支付下款佣金", nil);
//        _paidCommissionLabel.text = [NSString stringWithFormat:@"%ld",loanItem.paid_commission];
//        _waitpaidCommissionLabel.text = [NSString stringWithFormat:@"%ld",loanItem.unpaid_commission];
//        [_contractTipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(weakSelf.manageFeeTipLabel);
//            make.top.mas_equalTo(weakSelf.waitpaidCommissionTipLabel.mas_bottom).offset(Adaptor_Value(13));
//        }];
//
//    }else{
//        _paidCommissionTipLabel.text = @"";
//        _waitpaidCommissionTipLabel.text = @"";
//        _paidCommissionLabel.text = @"";
//        _waitpaidCommissionLabel.text = @"";
//        [_contractTipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(weakSelf.manageFeeTipLabel);
//            make.top.mas_equalTo(weakSelf.manageFeeTipLabel.mas_bottom).offset(Adaptor_Value(13));
//        }];
//
//    }
    
    if (loanItem.is_current) {//有当前贷款
        _noLoanTipLabel.text = @"";
        _titleTipLabel.text = loanItem.is_vest ? lqLocalized(@"",nil) : lqLocalized(@"当前贷款",nil);
        _xiakuanTipLabel.text = loanItem.is_vest ? lqLocalized(@"",nil) : lqLocalized(@"累计下款金额",nil);
        _poposeMoneyTipLabel.text = loanItem.is_vest ? lqLocalized(@"",nil) : lqLocalized(@"目标金额",nil);
        _manageFeeTipLabel.text = loanItem.is_vest ? lqLocalized(@"",nil) : lqLocalized(@"服务费及渠道管理费",nil);
        _contractTipLabel.text = loanItem.is_vest ? lqLocalized(@"",nil) : lqLocalized(@"服务协议",nil);
        _loanTypeTipLabel.text = loanItem.is_vest ? lqLocalized(@"",nil) : lqLocalized(@"贷款状态",nil);
        
        [_confirmBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(weakSelf.centerContetView);
            make.height.mas_equalTo(Adaptor_Value(50)); make.top.mas_equalTo(weakSelf.loanTypeTipLabel.mas_bottom).offset(Adaptor_Value(30));

        }];
        
        _xiakuanLabel.text = loanItem.applied_at;
        _poposeMoneyLabel.text = [NSString stringWithFormat:@"￥%@",loanItem.title];
        _manageFeeLabel.text = loanItem.is_paid_service_fee ? [NSString stringWithFormat:@"￥%ld",loanItem.total_fee] :  [NSString stringWithFormat:@"待付款￥%ld",loanItem.total_fee] ;
        
        _contractLabel.text = loanItem.is_vest ? @"" :(loanItem.is_paid_service_fee ? lqLocalized(@"点击查看", nil) : lqLocalized(@"未生成", nil));
        _loanTypeLabel.text = loanItem.status_desc;

    }else{
        _titleTipLabel.text = @"";
        _xiakuanTipLabel.text = @"";
        _poposeMoneyTipLabel.text = @"";
        _manageFeeTipLabel.text = @"";
        _contractTipLabel.text = @"";
        _loanTypeTipLabel.text = @"";
        _unpaidServiceFeeTipLabel.text = @"";
//        _paidCommissionTipLabel.text = @"";
//        _waitpaidCommissionTipLabel.text = @"";
//        _paidCommissionLabel.text = @"";
//        _waitpaidCommissionLabel.text = @"";
        
        _xiakuanLabel.text = @"";
        _poposeMoneyLabel.text =  @"";
        _manageFeeLabel.text =  @"" ;
        _contractLabel.text =  @"";
        _loanTypeLabel.text =  @"";


        _noLoanTipLabel.text = loanItem.is_vest? @"暂时什么都没有哦" :lqLocalized(@"你还没有申请贷款，快去申请一笔吧，包下款哦！", nil);
        
        [_confirmBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(weakSelf.centerContetView);
            make.height.mas_equalTo(Adaptor_Value(50)); make.top.mas_equalTo(weakSelf.noLoanTipLabel.mas_bottom).offset(Adaptor_Value(30));

        }];
        

    }
    
  

    
    finishBlock();
}
#pragma mark - act
- (void)confirmBtnClick:(UIButton *)sender{
    if (self.mineCustomViewConfirmBtnClickBlock) {
        self.mineCustomViewConfirmBtnClickBlock(sender, nil);
    }
}
- (void)contractTap:(UITapGestureRecognizer *)gest{
    if (self.mineCustomViewCheckContractBlock) {
        self.mineCustomViewCheckContractBlock(self.contractLabel, nil);
    }
}
- (void)infoTap:(UITapGestureRecognizer *)gest{
    if (self.mineCustomViewCheckConsummateInfoBlock) {
        self.mineCustomViewCheckConsummateInfoBlock(self.unpaidServiceFeeLabel,nil);
    }
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
            make.height.mas_equalTo(Adaptor_Value(180));
        }];
        _iconImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avator"]];
        [contentV addSubview:_iconImageV];
        _iconImageV.backgroundColor = [UIColor redColor];
        [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(Adaptor_Value(70));
            make.top.mas_equalTo(Adaptor_Value(58));
            make.centerX.mas_equalTo(contentV);
        }];
        ViewBorderRadius(_iconImageV, Adaptor_Value(70)*0.5, kOnePX * 4, [UIColor colorWithHexString:@"a2e3f0"]);
        
        _accountLabel = [UILabel lableWithText:RI.mobile textColor:[UIColor whiteColor] fontSize:SemiboldFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_accountLabel];
        [_accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.iconImageV.mas_bottom).offset(Adaptor_Value(5));
            make.centerX.mas_equalTo(contentV);
//            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(25));
        }];
        _accountLabel.text = RI.mobile;
        
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

- (UIView *)centerView{
    if (!_centerView) {
        _centerView = [UIView new];
        UIView *contentView = [UIView new];
        contentView.backgroundColor = BackGroundColor;
        [_centerView addSubview:contentView];
        __weak __typeof(self) weakSelf = self;
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.centerView);
        }];
        _titleTipLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentView addSubview:_titleTipLabel];
        [_titleTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(24));
            make.top.mas_equalTo(Adaptor_Value(17));
        }];
        _centerContetView = [UIView new];
        _centerContetView.backgroundColor = [UIColor whiteColor];
        _centerContetView.layer.shadowColor = YinYingColor.CGColor;
        _centerContetView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        _centerContetView.layer.shadowOpacity = 0.5f;
        _centerContetView.layer.shadowRadius = 5;
        _centerContetView.layer.masksToBounds = NO;

        ViewRadius(_centerContetView, Adaptor_Value(15));
        [contentView addSubview:_centerContetView];
        [_centerContetView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleTipLabel);
            make.right.mas_equalTo(contentView).offset(-Adaptor_Value(24));
            make.top.mas_equalTo(weakSelf.titleTipLabel.mas_bottom).offset(Adaptor_Value(8));
            make.bottom.mas_equalTo(-Adaptor_Value(24));
        }];
        _noLoanTipLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_centerContetView addSubview:_noLoanTipLabel];
        [_noLoanTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.centerContetView);
            make.top.mas_equalTo(Adaptor_Value(20));
        }];
        
        _xiakuanTipLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_centerContetView addSubview:_xiakuanTipLabel];
        [_xiakuanTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(17.5));
            make.top.mas_equalTo(Adaptor_Value(13));
        }];
        _xiakuanLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_centerContetView addSubview:_xiakuanLabel];
        [_xiakuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.centerContetView).offset(-Adaptor_Value(17.5));
            make.centerY.mas_equalTo(weakSelf.xiakuanTipLabel);
        }];
        
        _unpaidServiceFeeTipLabel = [UILabel lableWithText:@"" textColor:BlueJianbian1 fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_centerContetView addSubview:_unpaidServiceFeeTipLabel];
        [_unpaidServiceFeeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.xiakuanTipLabel);
            make.top.mas_equalTo(weakSelf.xiakuanTipLabel.mas_bottom).offset(Adaptor_Value(13));
        }];
        _unpaidServiceFeeLabel = [UILabel lableWithText:@"" textColor:BlueJianbian1 fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_centerContetView addSubview:_unpaidServiceFeeLabel];
        [_unpaidServiceFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.xiakuanLabel);
            make.centerY.mas_equalTo(weakSelf.unpaidServiceFeeTipLabel);
        }];
        _unpaidServiceFeeLabel.userInteractionEnabled = YES;

        UITapGestureRecognizer *infoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(infoTap:)];
        [_unpaidServiceFeeLabel addGestureRecognizer:infoTap];
        
        _poposeMoneyTipLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_centerContetView addSubview:_poposeMoneyTipLabel];
        [_poposeMoneyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.unpaidServiceFeeTipLabel);
            make.top.mas_equalTo(weakSelf.unpaidServiceFeeTipLabel.mas_bottom).offset(Adaptor_Value(13));
        }];
        _poposeMoneyLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_centerContetView addSubview:_poposeMoneyLabel];
        [_poposeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.unpaidServiceFeeLabel);
            make.centerY.mas_equalTo(weakSelf.poposeMoneyTipLabel);
        }];
        
        _manageFeeTipLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_centerContetView addSubview:_manageFeeTipLabel];
        [_manageFeeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.poposeMoneyTipLabel);
            make.top.mas_equalTo(weakSelf.poposeMoneyTipLabel.mas_bottom).offset(Adaptor_Value(13));
        }];
        _manageFeeLabel = [UILabel lableWithText:@"" textColor:BlueJianbian1 fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_centerContetView addSubview:_manageFeeLabel];
        [_manageFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.poposeMoneyLabel);
            make.centerY.mas_equalTo(weakSelf.manageFeeTipLabel);
        }];
        
        _paidCommissionTipLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_centerContetView addSubview:_paidCommissionTipLabel];
        [_paidCommissionTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.manageFeeTipLabel);
            make.top.mas_equalTo(weakSelf.manageFeeTipLabel.mas_bottom).offset(Adaptor_Value(13));
        }];
        _paidCommissionLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_centerContetView addSubview:_paidCommissionLabel];
        [_paidCommissionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.manageFeeLabel);
            make.centerY.mas_equalTo(weakSelf.paidCommissionTipLabel);
        }];
        
        _waitpaidCommissionTipLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_centerContetView addSubview:_waitpaidCommissionTipLabel];
        [_waitpaidCommissionTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.paidCommissionTipLabel);
            make.top.mas_equalTo(weakSelf.paidCommissionTipLabel.mas_bottom).offset(Adaptor_Value(13));
        }];
        _waitpaidCommissionLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_centerContetView addSubview:_waitpaidCommissionLabel];
        [_waitpaidCommissionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.paidCommissionLabel);
            make.centerY.mas_equalTo(weakSelf.waitpaidCommissionTipLabel);
        }];


        _contractTipLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_centerContetView addSubview:_contractTipLabel];
        [_contractTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.manageFeeTipLabel);
            make.top.mas_equalTo(weakSelf.manageFeeTipLabel.mas_bottom).offset(Adaptor_Value(13));
        }];
        _contractLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_centerContetView addSubview:_contractLabel];
        [_contractLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.manageFeeLabel);
            make.centerY.mas_equalTo(weakSelf.contractTipLabel);
        }];
        
        _contractLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contractTap:)];
        [_contractLabel addGestureRecognizer:tap];
        
        _loanTypeTipLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_centerContetView addSubview:_loanTypeTipLabel];
        [_loanTypeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.contractTipLabel);
            make.top.mas_equalTo(weakSelf.contractTipLabel.mas_bottom).offset(Adaptor_Value(13));
        }];
        _loanTypeLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_centerContetView addSubview:_loanTypeLabel];
        [_loanTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.contractLabel);
            make.centerY.mas_equalTo(weakSelf.loanTypeTipLabel);
        }];
        
        _confirmBtn = [[CommonBtn alloc] init];
        [_confirmBtn setTitle:RI.is_vest ? lqLocalized(@"", nil) : lqLocalized(@"立即下款", nil) forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_centerContetView addSubview:_confirmBtn];
        _confirmBtn.CommonBtnEndLongPressBlock = ^(UIButton *sender){
            [weakSelf confirmBtnClick:sender];
        };
        [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(weakSelf.centerContetView);
            make.height.mas_equalTo(Adaptor_Value(50));
            make.top.mas_equalTo(weakSelf.loanTypeTipLabel.mas_bottom).offset(Adaptor_Value(30));
//            if (hasLoan) {
//                make.top.mas_equalTo(weakSelf.loanTypeTipLabel.mas_bottom).offset(Adaptor_Value(30));
//            }else{
//                make.top.mas_equalTo(weakSelf.noLoanTipLabel.mas_bottom).offset(Adaptor_Value(30));
//
//            }
        }];
    }
    return _centerView;
}
@end
