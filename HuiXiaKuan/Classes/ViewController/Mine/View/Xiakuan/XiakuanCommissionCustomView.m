//
//  XiakuanCommissionCustomView.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/11.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "XiakuanCommissionCustomView.h"
#import "Account.h"
@interface XiakuanCommissionCustomView()
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UIImageView *tipImageV;
@property (nonatomic,strong)UILabel *moneyLable;
@property (nonatomic,strong)UILabel *moneyTipLable;
@property (nonatomic,strong)CommonBtn *confirmBtn;

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *infoTipLabel;
@property (nonatomic,strong)UIView *cornerContentView;
@property (nonatomic,strong)UILabel *xiakuanTipLabel;
@property (nonatomic,strong)UILabel *xiakuanLabel;
@property (nonatomic,strong)UILabel *poposeMoneyTipLabel;
@property (nonatomic,strong)UILabel *poposeMoneyLabel;
@property (nonatomic,strong)UILabel *manageFeeTipLabel;
@property (nonatomic,strong)UILabel *manageFeeLabel;
@property (nonatomic,strong)UILabel *timeTipLabel;
@property (nonatomic,strong)UILabel *timeLabel;

@end
@implementation XiakuanCommissionCustomView

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
    [self addSubview:self.bottomView];
    __weak __typeof(self) weakSelf = self;
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.header.mas_bottom);
    }];
}

#pragma mark - refreshUI
- (void)configUIWithItem:(XiakuanCommissionItem *)item finishBlock:(void(^)())finishBlock{
    if (item.is_paid) {
        [self.tipImageV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(29));
            
        }];
        [self.confirmBtn setTitle:lqLocalized(@"返回我的账户", nil) forState:UIControlStateNormal];
    }else{
        [self.tipImageV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
            
        }];
        [self.confirmBtn setTitle:lqLocalized(@"立即支付", nil) forState:UIControlStateNormal];
    }
    NSString *str = [NSString stringWithFormat:@"￥%@",item.commission];
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:TitleBlackColor}];
    NSRange range = [str rangeOfString:NSLocalizedString(@"￥", nil)];
    if (range.length > 0) {
        [attribtStr addAttribute:NSFontAttributeName value:SemiboldFONT(36) range:NSMakeRange(range.location + 1, str.length - range.location - range.length)];
        
    }
    self.moneyLable.attributedText = attribtStr;
    
    self.moneyTipLable.text = [NSString stringWithFormat:@"%@贷款已完成，按照协议需支付下款佣金",item.real_name];
//    self.xiakuanLabel.text = [NSString stringWithFormat:@"￥%@",item.true_amount];
    NSString *xiakuanstr = [NSString stringWithFormat:@"￥%ld",item.true_amount];
    NSMutableAttributedString *xiankuanattribtStr = [[NSMutableAttributedString alloc] initWithString:xiakuanstr attributes:@{NSForegroundColorAttributeName:BlueJianbian1}];
    NSRange xiankuanrange = [xiakuanstr rangeOfString:NSLocalizedString(@"￥", nil)];
    if (xiankuanrange.length > 0) {
        [xiankuanattribtStr addAttribute:NSFontAttributeName value:SemiboldFONT(20) range:NSMakeRange(xiankuanrange.location + 1, xiakuanstr.length - xiankuanrange.location - xiankuanrange.length)];
        
    }
    self.xiakuanLabel.attributedText = xiankuanattribtStr;

    self.poposeMoneyLabel.text = [NSString stringWithFormat:@"￥%@",item.title];
    self.manageFeeLabel.text = [NSString stringWithFormat:@"￥%@",item.commission];
    self.timeLabel.text = item.created_at;
    
    finishBlock();
}
#pragma mark - act
- (void)confirmBtnClick:(UIButton *)sender{
    if (self.xiakuanCommissionCustomViewConfirmBtnClickBlock) {
        self.xiakuanCommissionCustomViewConfirmBtnClickBlock(sender, nil);
    }
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
            make.height.mas_equalTo(Adaptor_Value(280));
        }];
        
        _tipImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paysuccess"]];
        [contentV addSubview:_tipImageV];
        [_tipImageV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(Adaptor_Value(29));
            make.height.mas_equalTo(0);

            make.width.mas_equalTo(Adaptor_Value(123));
            make.top.mas_equalTo(Adaptor_Value(60));
            make.centerX.mas_equalTo(contentV);
        }];
        
        _moneyLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(22) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_moneyLable];
        [_moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.tipImageV.mas_bottom).offset(Adaptor_Value(30));
            make.centerX.mas_equalTo(contentV);
        }];
        _moneyTipLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_moneyTipLable];
        [_moneyTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.moneyLable.mas_bottom).offset(Adaptor_Value(10));
        }];
        
        CommonBtn *confirmBtn = [[CommonBtn alloc] init];
        _confirmBtn = confirmBtn;
        [confirmBtn setTitle:lqLocalized(@"立即支付", nil) forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchDown];
        [contentV addSubview:confirmBtn];
        confirmBtn.CommonBtnEndLongPressBlock = ^(UIButton *sender){
            [weakSelf confirmBtnClick:sender];
        };
        [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(60));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(60));
            make.bottom.mas_equalTo(contentV.mas_bottom).offset(-Adaptor_Value(25));
            make.height.mas_equalTo(Adaptor_Value(60));
        }];
    }
    return _header;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        UIView *contentV = [UIView new];
        [_bottomView addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.bottomView);
        }];
        _infoTipLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_infoTipLabel];
        [_infoTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Adaptor_Value(30));
            make.left.mas_equalTo(Adaptor_Value(25));
        }];
        
        _cornerContentView = [UIView new];
        _cornerContentView.backgroundColor = [UIColor whiteColor];
        ViewRadius(_cornerContentView, Adaptor_Value(15));
        [contentV addSubview:_cornerContentView];
        [_cornerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.infoTipLabel);
            make.top.mas_equalTo(weakSelf.infoTipLabel.mas_bottom).offset(Adaptor_Value(10));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(25));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(100));
        }];
        
        _xiakuanTipLabel = [UILabel lableWithText:lqLocalized(@"本次下款金额",nil) textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_cornerContentView addSubview:_xiakuanTipLabel];
        [_xiakuanTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(17.5));
            make.top.mas_equalTo(Adaptor_Value(20));
        }];
        _xiakuanLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_cornerContentView addSubview:_xiakuanLabel];
        [_xiakuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.xiakuanTipLabel);
            make.top.mas_equalTo(weakSelf.xiakuanTipLabel.mas_bottom).offset(Adaptor_Value(10));
        }];
        
       
        
        _poposeMoneyTipLabel = [UILabel lableWithText:lqLocalized(@"目标金额",nil) textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_cornerContentView addSubview:_poposeMoneyTipLabel];
        [_poposeMoneyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.xiakuanTipLabel);
            make.top.mas_equalTo(weakSelf.xiakuanLabel.mas_bottom).offset(Adaptor_Value(10));
        }];
        _poposeMoneyLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_cornerContentView addSubview:_poposeMoneyLabel];
        [_poposeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.cornerContentView).offset(-Adaptor_Value(17.5));
            make.centerY.mas_equalTo(weakSelf.poposeMoneyTipLabel);
        }];
        
        _manageFeeTipLabel = [UILabel lableWithText:lqLocalized(@"应收佣金",nil) textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_cornerContentView addSubview:_manageFeeTipLabel];
        [_manageFeeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.poposeMoneyTipLabel);
            make.top.mas_equalTo(weakSelf.poposeMoneyTipLabel.mas_bottom).offset(Adaptor_Value(10));
        }];
        _manageFeeLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_cornerContentView addSubview:_manageFeeLabel];
        [_manageFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.poposeMoneyLabel);
            make.centerY.mas_equalTo(weakSelf.manageFeeTipLabel);
        }];
        
        _timeTipLabel = [UILabel lableWithText:lqLocalized(@"下款时间",nil) textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_cornerContentView addSubview:_timeTipLabel];
        [_timeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.manageFeeTipLabel);
            make.top.mas_equalTo(weakSelf.manageFeeTipLabel.mas_bottom).offset(Adaptor_Value(10));
        }];
        _timeLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_cornerContentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.manageFeeLabel);
            make.centerY.mas_equalTo(weakSelf.timeTipLabel);
            make.bottom.mas_equalTo(weakSelf.cornerContentView).offset(-Adaptor_Value(25));
        }];
    }
    return _bottomView;
}
@end
