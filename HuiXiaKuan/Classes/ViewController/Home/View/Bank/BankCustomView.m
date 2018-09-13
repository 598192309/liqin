//
//  BankCustomView.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/4.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "BankCustomView.h"
@interface BankCustomView()
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UILabel *moneTipLabel;
@property (nonatomic,strong)UILabel *moneyLabel;
@property (nonatomic,strong)UITextField *nameTextF;
@property (nonatomic,strong)UITextField *idcardTextF;
@property (nonatomic,strong)UITextField *bankcardTextF;
@property (nonatomic,strong)UITextField *phoneTextF;
@property (nonatomic,strong)CommonBtn *confirmBtn;

@end
@implementation BankCustomView
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
        make.edges.mas_equalTo(weakSelf);
    }];
}

#pragma mark - act
- (void)confirmBtnClick:(UIButton *)sender{
    if (self.bankCustomViewConfirmBtnClickBlock) {
        self.bankCustomViewConfirmBtnClickBlock(sender,@{@"real_name":SAFE_NIL_STRING(self.nameTextF.text),@"idno":SAFE_NIL_STRING(self.idcardTextF.text),@"bankcard":SAFE_NIL_STRING(self.bankcardTextF.text),@"mobile":SAFE_NIL_STRING(self.phoneTextF.text)});
//        self.bankCustomViewConfirmBtnClickBlock(sender,@{@"real_name":@"黎芹",@"idno":@"430523199005267648",@"bankcard":@"6214830203224471",@"mobile":@"18175932278"});

    }
    
}

#pragma mark - setter
- (void)setMoneyStr:(NSString *)moneyStr{
    _moneyStr = moneyStr;
    NSString *str = [NSString stringWithFormat:@"￥%@",moneyStr];
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:BlueJianbian2}];
    NSRange range = [str rangeOfString:NSLocalizedString(@"￥", nil)];
    if (range.length > 0) {
        [attribtStr addAttribute:NSFontAttributeName value:SemiboldFONT(36) range:NSMakeRange(range.location + 1, str.length - range.location - range.length)];

    }
    self.moneyLabel.attributedText = attribtStr;
    
    self.moneTipLabel.text = RI.is_vest ? @"" : lqLocalized(@"支付金额", nil);
}
#pragma mark - lazy
- (UIView *)header{
    if (_header == nil) {
        _header = [UIView new];
        __weak __typeof(self) weakSelf = self;
        
        UIView *contentV = [UIView new];
        contentV.backgroundColor = BackGroundColor;
        [_header addSubview:contentV];
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.header);
        }];
        _moneTipLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:SemiboldFONT(20) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_moneTipLabel];
        [_moneTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(20));
            make.top.mas_equalTo(Adaptor_Value(30));
        }];
        _moneyLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:SemiboldFONT(20) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.moneTipLabel);
            make.top.mas_equalTo(weakSelf.moneTipLabel.mas_bottom).offset(Adaptor_Value(20));
        }];
        
        UIView *nameTFBackView = [UIView new];
        nameTFBackView.backgroundColor = [UIColor whiteColor];
        [contentV addSubview:nameTFBackView];
        [nameTFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(25));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(25));
            make.top.mas_equalTo(weakSelf.moneyLabel.mas_bottom).offset(Adaptor_Value(20));
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

        
        CommonBtn *confirmBtn = [[CommonBtn alloc] init];
        [confirmBtn setTitle:lqLocalized(@"下一步", nil) forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchDown];
        [contentV addSubview:confirmBtn];
        confirmBtn.CommonBtnEndLongPressBlock = ^(UIButton *sender){
            [weakSelf confirmBtnClick:sender];
        };
        [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(10));
            make.right.mas_equalTo(weakSelf.header).offset(-Adaptor_Value(10));
            make.top.mas_equalTo(phoneTFBackView.mas_bottom).offset(Adaptor_Value(25));
            make.height.mas_equalTo(Adaptor_Value(60));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(100));
        }];

        
        
    }
    return _header;
}

@end
