//
//  MineLoanRecordCell.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/31.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "MineLoanRecordCell.h"
#import "Account.h"
@interface MineLoanRecordCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
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

@end
@implementation MineLoanRecordCell

#pragma mark - 生命周期
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        [self layoutSub];
        self.contentView.backgroundColor = BackGroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}
-(void)configUI{
    [self.contentView addSubview:self.cellBackgroundView];

}
- (void)layoutSub{
    __weak __typeof(self) weakSelf = self;
    [self.cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Adaptor_Value(5));
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-Adaptor_Value(5));
        make.left.mas_equalTo(Adaptor_Value(25));
        make.right.mas_equalTo(weakSelf.contentView).offset(-Adaptor_Value(25));
    }];
}
#pragma mark - 刷新ui
- (void)configUIWithItem:(LoanRecordInfoItem *)item{
    NSString *str = [NSString stringWithFormat:@"￥%ld",item.true_amount];
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:BlueJianbian1}];
    NSRange range = [str rangeOfString:NSLocalizedString(@"￥", nil)];
    if (range.length > 0) {
        [attribtStr addAttribute:NSFontAttributeName value:SemiboldFONT(20) range:NSMakeRange(range.location + 1, str.length - range.location - range.length)];
        
    }
    _unpaidServiceFeeTipLabel.attributedText = attribtStr;

//    _unpaidServiceFeeTipLabel.text = item.is_paid_commission ? [NSString stringWithFormat:@"%ld",item.true_amount] : lqLocalized(@"未支付服务费", nil);
    _xiakuanLabel.text = item.applied_at;
    _poposeMoneyLabel.text = item.title;
    _manageFeeLabel.text = [NSString stringWithFormat:@"%ld",item.service_fee] ;
    _contractLabel.text =item.is_paid_service_fee ? lqLocalized(@"点击查看", nil) : lqLocalized(@"未生成", nil);
    _loanTypeLabel.text = item.status_desc;
    __weak __typeof(self) weakSelf = self;
    if (!item.is_paid_commission) {//已下款待支付下款佣金 部分支付
        _paidCommissionTipLabel.text = item.is_vest ? @"" : lqLocalized(@"已支付下款佣金", nil);
        _waitpaidCommissionTipLabel.text = item.is_vest ? @"" : lqLocalized(@"待支付下款佣金", nil);
        _paidCommissionLabel.text = [NSString stringWithFormat:@"%ld",item.paid_commission];
        _waitpaidCommissionLabel.text = [NSString stringWithFormat:@"%ld",item.unpaid_commission];
        [_contractTipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.manageFeeTipLabel);
            make.top.mas_equalTo(weakSelf.waitpaidCommissionTipLabel.mas_bottom).offset(Adaptor_Value(13));
        }];
        
    }else{
        NSString *str = lqLocalized(@"未支付服务费", nil);
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:BlueJianbian1,NSFontAttributeName:RegularFONT(13)}];
        _unpaidServiceFeeTipLabel.attributedText = attribtStr;
        
        _paidCommissionTipLabel.text = @"";
        _waitpaidCommissionTipLabel.text = @"";
        _paidCommissionLabel.text = @"";
        _waitpaidCommissionLabel.text = @"";
        [_contractTipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.manageFeeTipLabel);
            make.top.mas_equalTo(weakSelf.manageFeeTipLabel.mas_bottom).offset(Adaptor_Value(13));
        }];
        
    }
}
#pragma mark - act
- (void)contractTap:(UITapGestureRecognizer *)gest{
    if (self.mineLoanRecordCellCheckContractBlock) {
        self.mineLoanRecordCellCheckContractBlock(self.contractLabel, nil);
    }
}

#pragma mark - lazy
- (UIView *)cellBackgroundView{
    if (!_cellBackgroundView) {
        _cellBackgroundView = [UIView new];
        UIView *contentV = [UIView new];
        __weak __typeof(self) weakSelf = self;
        [_cellBackgroundView addSubview:contentV];
        _cellBackgroundView.layer.shadowColor = YinYingColor.CGColor;
        _cellBackgroundView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        _cellBackgroundView.layer.shadowOpacity = 0.5f;
        _cellBackgroundView.layer.shadowRadius = 5;
        _cellBackgroundView.layer.masksToBounds = NO;
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.cellBackgroundView);
        }];
        ViewRadius(contentV, Adaptor_Value(15));
        
        contentV.backgroundColor = [UIColor whiteColor];
        _xiakuanTipLabel = [UILabel lableWithText:lqLocalized(@"累计下款金额",nil) textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_xiakuanTipLabel];
        [_xiakuanTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(17.5));
            make.top.mas_equalTo(Adaptor_Value(13));
        }];
        _xiakuanLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_xiakuanLabel];
        [_xiakuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(17.5));
            make.centerY.mas_equalTo(weakSelf.xiakuanTipLabel);
        }];
        
        _unpaidServiceFeeTipLabel = [UILabel lableWithText:@"" textColor:BlueJianbian1 fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_unpaidServiceFeeTipLabel];
        [_unpaidServiceFeeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.xiakuanTipLabel);
            make.top.mas_equalTo(weakSelf.xiakuanTipLabel.mas_bottom).offset(Adaptor_Value(13));
        }];
        _unpaidServiceFeeLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_unpaidServiceFeeLabel];
        [_unpaidServiceFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.xiakuanLabel);
            make.centerY.mas_equalTo(weakSelf.unpaidServiceFeeTipLabel);
        }];
        
        _poposeMoneyTipLabel = [UILabel lableWithText:lqLocalized(@"目标金额",nil) textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_poposeMoneyTipLabel];
        [_poposeMoneyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.unpaidServiceFeeTipLabel);
            make.top.mas_equalTo(weakSelf.unpaidServiceFeeTipLabel.mas_bottom).offset(Adaptor_Value(13));
        }];
        _poposeMoneyLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_poposeMoneyLabel];
        [_poposeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.unpaidServiceFeeLabel);
            make.centerY.mas_equalTo(weakSelf.poposeMoneyTipLabel);
        }];
        
        _manageFeeTipLabel = [UILabel lableWithText:lqLocalized(@"服务费及渠道管理费",nil) textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_manageFeeTipLabel];
        [_manageFeeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.poposeMoneyTipLabel);
            make.top.mas_equalTo(weakSelf.poposeMoneyTipLabel.mas_bottom).offset(Adaptor_Value(13));
        }];
        _manageFeeLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_manageFeeLabel];
        [_manageFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.poposeMoneyLabel);
            make.centerY.mas_equalTo(weakSelf.manageFeeTipLabel);
        }];
        
        _paidCommissionTipLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_paidCommissionTipLabel];
        [_paidCommissionTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.manageFeeTipLabel);
            make.top.mas_equalTo(weakSelf.manageFeeTipLabel.mas_bottom).offset(Adaptor_Value(13));
        }];
        _paidCommissionLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_paidCommissionLabel];
        [_paidCommissionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.manageFeeLabel);
            make.centerY.mas_equalTo(weakSelf.paidCommissionTipLabel);
        }];
        
        _waitpaidCommissionTipLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_waitpaidCommissionTipLabel];
        [_waitpaidCommissionTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.paidCommissionTipLabel);
            make.top.mas_equalTo(weakSelf.paidCommissionTipLabel.mas_bottom).offset(Adaptor_Value(13));
        }];
        _waitpaidCommissionLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_waitpaidCommissionLabel];
        [_waitpaidCommissionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.paidCommissionLabel);
            make.centerY.mas_equalTo(weakSelf.waitpaidCommissionTipLabel);
        }];
        
        _contractTipLabel = [UILabel lableWithText:lqLocalized(@"服务协议",nil) textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_contractTipLabel];
        [_contractTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.manageFeeTipLabel);
            make.top.mas_equalTo(weakSelf.manageFeeTipLabel.mas_bottom).offset(Adaptor_Value(13));
        }];
        _contractLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_contractLabel];
        [_contractLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.manageFeeLabel);
            make.centerY.mas_equalTo(weakSelf.contractTipLabel);
        }];
        _contractLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contractTap:)];
        [_contractLabel addGestureRecognizer:tap];
        
        _loanTypeTipLabel = [UILabel lableWithText:lqLocalized(@"贷款状态",nil) textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_loanTypeTipLabel];
        [_loanTypeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.contractTipLabel);
            make.top.mas_equalTo(weakSelf.contractTipLabel.mas_bottom).offset(Adaptor_Value(13));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(13));
        }];
        _loanTypeLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_loanTypeLabel];
        [_loanTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.contractLabel);
            make.centerY.mas_equalTo(weakSelf.loanTypeTipLabel);
        }];
        

    }
    return _cellBackgroundView;
}
@end
