//
//  LoanConfirmationContentView.m
//  RabiBird
//
//  Created by Lqq on 2018/7/24.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "LoanConfirmationContentView.h"
#import "LoanConfirmationContentCell.h"
#import "HomeModel.h"

@interface LoanConfirmationContentView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UILabel * yuceLabel;
@property (nonatomic,strong) UIButton * yuceBtn;

@property (nonatomic,strong) UILabel * moneyTipLabel;
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) UIView * bottomView;
@property (nonatomic, strong) UILabel * bottomFeeTipLabel;
@property (nonatomic, strong) UILabel * bottomCharLabel;
@property (nonatomic,strong)  UILabel *bottomZhonghuaxianFeeLabel;
@property (nonatomic, strong) UILabel * bottomFeeLabel;
@property (nonatomic, strong) UILabel * bottomFeeSubLabel;
@property (nonatomic,strong) UIButton * chooseButton;
@property (nonatomic, strong) UILabel * bottom1Label;
@property (nonatomic, strong) UILabel * bottom2Label;
@property (nonatomic,strong) UIButton * buyBtn;

@property (nonatomic,strong)NSArray *dataItemArr;


@end
@implementation LoanConfirmationContentView

#pragma mark - 生命周期
-(instancetype)init{
    if (self = [super init]) {
        [self configUI];
        [self layoutSub];
        self.backgroundColor = [UIColor colorWithHexString:@"eaeff6"];

        
    }
    return self;
}
#pragma mark - ui
-(void)configUI{
    [self addSubview:self.yuceLabel];
    [self addSubview:self.yuceBtn];
    [self addSubview:self.moneyTipLabel];
    [self addSubview:self.collectionView];
    [self addSubview:self.bottomFeeTipLabel];
    [self addSubview:self.bottomZhonghuaxianFeeLabel];
    [self addSubview:self.bottomCharLabel];
    [self addSubview:self.bottomFeeLabel];
    [self addSubview:self.bottomFeeSubLabel];
    [self addSubview:self.chooseButton];
    [self addSubview:self.bottom1Label];
    [self addSubview:self.bottom2Label];
    [self addSubview:self.buyBtn];
    

}
- (void)layoutSub{
    __weak __typeof(self) weakSelf = self;
    [self.yuceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Adaptor_Value(25));
        make.top.mas_equalTo(Adaptor_Value(25));
    }];
    [self.yuceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-Adaptor_Value(25));
        make.centerY.mas_equalTo(weakSelf.yuceLabel);
    }];
    [self.moneyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.yuceLabel);
        make.top.mas_equalTo(weakSelf.yuceLabel.mas_bottom).offset(Adaptor_Value(25));
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.moneyTipLabel.mas_bottom).with.offset(AdaptedHeight(10));
        make.left.mas_offset(0);
        make.right.mas_offset(LQScreemW);
        make.height.mas_equalTo(AdaptedHeight(60));
        
    }];
    [self.bottomFeeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.collectionView.mas_bottom).with.offset(AdaptedHeight(10));
        make.left.mas_equalTo(weakSelf.yuceLabel);
    }];
    [self.bottomZhonghuaxianFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.bottomFeeTipLabel.mas_right).offset(5);
        make.centerY.mas_equalTo(weakSelf.bottomFeeTipLabel);
        
    }];

    [self.bottomCharLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.bottomZhonghuaxianFeeLabel.mas_right).offset(Adaptor_Value(5));
        make.top.mas_equalTo(weakSelf.bottomFeeTipLabel);
        
    }];
    [self.bottomFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.bottomCharLabel.mas_right).offset(0);
        make.centerY.mas_equalTo(weakSelf.bottomFeeTipLabel);
        
    }];
    [self.bottomFeeSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bottomFeeTipLabel.mas_bottom).offset(Adaptor_Value(12));
        make.left.mas_equalTo(weakSelf.bottomFeeTipLabel);
        make.right.mas_equalTo(weakSelf).offset(-Adaptor_Value(25));
        make.width.mas_equalTo(LQScreemW - Adaptor_Value(25) * 2);
    }];
    
    [self.chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bottomFeeSubLabel.mas_bottom).offset(Adaptor_Value(20));
        make.left.mas_equalTo(weakSelf.bottomFeeTipLabel);
        make.size.mas_equalTo(CGSizeMake(AdaptedWidth(15), AdaptedWidth(15)));
    }];
    [self.bottom1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.chooseButton);
        make.left.mas_equalTo(weakSelf.chooseButton.mas_right).with.offset(5);
    }];
    [self.bottom2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.chooseButton);
        make.left.mas_equalTo(weakSelf.bottom1Label.mas_right);
    }];
    
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(Adaptor_Value(60));
        make.left.mas_equalTo(Adaptor_Value(50));
        make.right.mas_equalTo(weakSelf).offset(-Adaptor_Value(50));
        make.top.mas_equalTo(weakSelf.bottom2Label.mas_bottom).offset(Adaptor_Value(20));
        make.bottom.mas_equalTo(weakSelf).offset(-Adaptor_Value(20));
    }];
    
    /**
     *  1.通过CAGradientLayer 设置渐变的背景。
     */
    CAGradientLayer *layer1 = [CAGradientLayer new];
    NSArray *colorArray = @[(__bridge id)[UIColor colorWithHexString:@"#ffc600"].CGColor,(__bridge id)[UIColor colorWithHexString:@"#ed8233"].CGColor];
    layer1.colors=colorArray;
    layer1.startPoint = CGPointMake(0.0, 0.0);
    layer1.endPoint = CGPointMake(0.9, 0);
    layer1.frame = CGRectMake(0, 0, LQScreemW - Adaptor_Value(50) * 2,Adaptor_Value(60));
    [self.buyBtn.layer insertSublayer:layer1 atIndex:0];

}

#pragma mark - 刷新ui
- (void)configUIWithItmeArr:(NSArray *)itemArr{
    self.dataItemArr = itemArr;
    for (int i = 0; i < itemArr.count; i++) {
        LoanTypeItem *loanItem = [itemArr safeObjectAtIndex:i];
        if (loanItem.isSelected) {
            _row = i;
        }
    }

    [self.collectionView reloadData];
    [self refreshBottomInfo];
    
}
- (void)setYucelabelText:(NSString *)text{
    self.yuceLabel.text = text;

}

- (void)refreshBottomInfo{
    LoanTypeItem *loanItem = [self.dataItemArr safeObjectAtIndex:_row];
    self.bottomFeeLabel.text = [NSString stringWithFormat:@"%ld",loanItem.total_fee];
    self.bottomFeeSubLabel.text = loanItem.info;
    //中划线
    NSString *str = [NSString stringWithFormat:@"￥%ld",loanItem.org_fee];
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attribtStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
    [attribtStr addAttribute:NSFontAttributeName value:AdaptedFontSize(16) range:NSMakeRange(0, str.length)];
    [attribtStr addAttribute:NSForegroundColorAttributeName value:TitleGrayColor range:NSMakeRange(0, str.length)];
    if (loanItem.org_fee != loanItem.total_fee) {
        self.bottomZhonghuaxianFeeLabel.attributedText = attribtStr;
    }else{
        self.bottomZhonghuaxianFeeLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@""];

    }

}

#pragma mark - 自定义
- (void)chooseClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}
- (void)yuceBtnClick:(UIButton *)sender{
    if (self.LoanConfirmationContentViewCeSuanBtnClickBlock) {
        self.LoanConfirmationContentViewCeSuanBtnClickBlock();
    }
}



- (void)buyClick:(UIButton *)sender{
    if (!self.chooseButton.selected) {
        [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"请先阅读并同意服务合同", nil)];
        return;
    }

    if (self.LoanConfirmationContentViewXiakuanBtnClickBlock) {
        self.LoanConfirmationContentViewXiakuanBtnClickBlock(sender);
    }
}

- (void)dealTap:(UITapGestureRecognizer *)gest{
    LoanTypeItem *loanItem = [self.dataItemArr safeObjectAtIndex:_row];

    if (self.LoanConfirmationContentViewDealBlock) {
        self.LoanConfirmationContentViewDealBlock(loanItem.scope);
    }
}

#pragma mark collectionView代理方法

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataItemArr ? self.dataItemArr.count :3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LoanConfirmationContentCell *cell = (LoanConfirmationContentCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"LoanConfirmationContentCell" forIndexPath:indexPath];
    LoanTypeItem *item = [self.dataItemArr safeObjectAtIndex:indexPath.row];
    [cell configUIWithItme:item];
    cell.row = indexPath.row;
    return cell;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataItemArr ? CGSizeMake(self.dataItemArr.count > 3 ? (LQScreemW -  AdaptedWidth(12.5 + 23)*2)/3.0 : (LQScreemW -  AdaptedWidth(12.5 + 23)*2)/self.dataItemArr.count, 50 ) : CGSizeMake((LQScreemW -  AdaptedWidth(12.5 + 23)*2)/3.0, 50 );



}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(AdaptedWidth(10), AdaptedWidth(23), AdaptedWidth(12.5), AdaptedWidth(23));
}




//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.row = indexPath.row;
    for (LoanTypeItem *item in self.dataItemArr) {
        item.isSelected = NO;
    }
    ((LoanTypeItem *)[self.dataItemArr safeObjectAtIndex:indexPath.row]).isSelected = YES;
    
    [self refreshBottomInfo];
    [self.collectionView reloadData];

    
}
#pragma mark - lazy
-(UILabel *)yuceLabel{
    if (!_yuceLabel) {
        _yuceLabel = [UILabel new];
        _yuceLabel.textColor = [UIColor colorWithHexString:@"222020"];
        _yuceLabel.font = AdaptedFontSize(17);
        _yuceLabel.text = NSLocalizedString(@"我的额度测算结果:", nil);
    }
    return _yuceLabel;
}
- (UIButton *)yuceBtn{
    if (!_yuceBtn) {
        _yuceBtn = [UIButton bottomButtonWithTitle:NSLocalizedString(@"重新测算", nil) titleColor:[UIColor colorWithHexString:@"00c7bd"] backGroundColor:[UIColor clearColor] Target:self action:@selector(yuceBtnClick:)];
        _yuceBtn.titleLabel.font = AdaptedFontSize(15);
    }
    return _yuceBtn;
}

-(UILabel *)moneyTipLabel{
    if (!_moneyTipLabel) {
        _moneyTipLabel = [UILabel new];
        _moneyTipLabel.textColor = [UIColor colorWithHexString:@"222020"];
        _moneyTipLabel.font = AdaptedFontSize(13);
        _moneyTipLabel.text = NSLocalizedString(@"借款金额:", nil);

    }
    return _moneyTipLabel;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, LQScreemW, AdaptedHeight(60)) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[LoanConfirmationContentCell class] forCellWithReuseIdentifier:@"LoanConfirmationContentCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
    }
    return _collectionView;
}
-(UIView *)bottomView{
    if (!_bottomView ) {
        _bottomView = [UIView new];
        //        _bottomView.backgroundColor = [UIColor purpleColor];
    }
    return _bottomView;
}



-(UILabel *)bottomFeeTipLabel{
    if (!_bottomFeeTipLabel ) {
        _bottomFeeTipLabel = [UILabel new];
        //        _bottomTipLabel.text = NSLocalizedString(@"*若借款审核失败，1-3日内全额退款至支付账户", nil);
        _bottomFeeTipLabel.text = NSLocalizedString(@"服务费用:", nil);
        
        _bottomFeeTipLabel.font = AdaptedFontSize(14);
        _bottomFeeTipLabel.textColor = [UIColor colorWithHexString:@"222020"];
        _bottomFeeTipLabel.numberOfLines = 0;
    }
    return _bottomFeeTipLabel;
}
-(UILabel *)bottomCharLabel{
    if (!_bottomCharLabel ) {
        _bottomCharLabel = [UILabel new];
        _bottomCharLabel.text = NSLocalizedString(@"￥", nil);
        _bottomCharLabel.font = AdaptedFontSize(10);
        _bottomCharLabel.textColor = [UIColor colorWithHexString:@"00c7bd"];
    }
    return _bottomCharLabel;
}
-(UILabel *)bottomFeeLabel{
    if (!_bottomFeeLabel) {
        _bottomFeeLabel = [UILabel new];
        _bottomFeeLabel.textColor = [UIColor colorWithHexString:@"00c7bd"];
        _bottomFeeLabel.font =AdaptedFontSize(18);
        _bottomFeeTipLabel.numberOfLines = 0;

    }
    return _bottomFeeLabel;
}
-(UILabel *)bottomZhonghuaxianFeeLabel{
    if (!_bottomZhonghuaxianFeeLabel) {
        _bottomZhonghuaxianFeeLabel = [UILabel new];
        _bottomZhonghuaxianFeeLabel.textColor = [UIColor colorWithHexString:@"222020"];
        _bottomZhonghuaxianFeeLabel.font =AdaptedFontSize(18);
        _bottomZhonghuaxianFeeLabel.numberOfLines = 0;
        
    }
    return _bottomZhonghuaxianFeeLabel;
}


-(UILabel *)bottomFeeSubLabel{
    if (!_bottomFeeSubLabel) {
        _bottomFeeSubLabel = [UILabel new];
        NSString *str = NSLocalizedString(@"啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊", nil);
        
        _bottomFeeSubLabel.attributedText =[NSString attributeStringWithParagraphStyleLineSpace:Adaptor_Value(8) withString:str Alignment:NSTextAlignmentLeft] ;
        _bottomFeeSubLabel.textColor = TitleBlackColor;
        _bottomFeeSubLabel.font =AdaptedFontSize(13);
        _bottomFeeSubLabel.numberOfLines = 0;
        
    }
    return _bottomFeeSubLabel;
}
-(UIButton *)chooseButton{
    if (!_chooseButton) {
        _chooseButton = [UIButton new];
        [_chooseButton addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
        [_chooseButton setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateSelected];
        [_chooseButton setImage:[UIImage imageNamed:@""]  forState:UIControlStateNormal];
//        [_chooseButton setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateSelected];
//        [_chooseButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];

        _chooseButton.selected = YES;
        ViewBorderRadius(_chooseButton, 0, kOnePX *2, TitleBlackColor);

    }
    return _chooseButton;
}
-(UILabel *)bottom1Label{
    if (!_bottom1Label ) {
        _bottom1Label = [UILabel new];
        _bottom1Label.text = NSLocalizedString(@"我已阅读并接受", nil);
        _bottom1Label.font = AdaptedFontSize(14);
        _bottom1Label.textColor = [UIColor colorWithHexString:@"222020"];
    }
    return _bottom1Label;
}
-(UILabel *)bottom2Label{
    if (!_bottom2Label) {
        _bottom2Label = [UILabel new];
        _bottom2Label.text = NSLocalizedString(@"《会下款服务合同》", nil);
        _bottom2Label.textColor = [UIColor colorWithHexString:@"86bdef"];
        _bottom2Label.font =AdaptedFontSize(14);
        _bottom2Label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap:)];
        [_bottom2Label addGestureRecognizer:tap];
    }
    return _bottom2Label;
}

- (UIButton *)buyBtn{
    if (!_buyBtn) {
        _buyBtn = [[UIButton alloc] init];
        [_buyBtn setTitle:NSLocalizedString(@"立即支付", nil) forState:UIControlStateNormal];
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyBtn addTarget:self action:@selector(buyClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _buyBtn;
}

@end
