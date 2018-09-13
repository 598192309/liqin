//
//  PersonalLoanCustomBottomView.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/7.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "PersonalLoanCustomBottomView.h"
#import "HomeModel.h"
#import "NormalOneTitleCell.h"
@interface PersonalLoanCustomBottomView()
@property (nonatomic,strong)UIView *platformView;
@property (nonatomic,strong)UILabel *platformViewTipLable1;
@property (nonatomic,strong)UICollectionView *platformCollectionView;

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *bottomTipLable;
@property (nonatomic,strong)UILabel *bottomTipSubLable;
@property (nonatomic,strong)CommonBtn *confirmBtn;

@property (nonatomic,strong)LoanBuildInfoItem *loanBuildInfoItem;


@end
@implementation PersonalLoanCustomBottomView

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
    [self addSubview:self.platformView];
    [self addSubview:self.bottomView];
    __weak __typeof(self) weakSelf = self;
    [self.platformView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf);
        make.top.mas_equalTo(Adaptor_Value(10));
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.platformView.mas_bottom);
        
    }];
    
}
- (void)configUIWithItem:(LoanBuildInfoItem *)item finishBlock:(void(^)())finishBlock{
    _loanBuildInfoItem = item;
    if (!RI.is_vest) {
        _platformViewTipLable1.text = lqLocalized(@"5.请选择您最近申请过的网贷平台", nil);
        
        _bottomTipLable.text = lqLocalized(@"我已知悉：", nil);
        _bottomTipSubLable.text = lqLocalized(@"若因资料不实导致下款失败，渠道管理费将不予退还。", nil);
    }
    
    [self.platformCollectionView reloadData];
    finishBlock();
}
#pragma mark - act
- (void)confirmBtnClick:(UIButton *)sender{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < self.loanBuildInfoItem.loan_platform.count ; i++) {
        LoanPlatformItem *item = [self.loanBuildInfoItem.loan_platform safeObjectAtIndex:i];
        if (item.isSelected) {
            [arr addObject:@(item.ID)];
        }
    }
    NSString *str = [arr componentsJoinedByString:@","];
    if (self.personalLoanCustomBottomViewConfirmBtnClickBlock) {
        self.personalLoanCustomBottomViewConfirmBtnClickBlock(sender, str);
    }
}
#pragma mark collectionView代理方法

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.loanBuildInfoItem.loan_platform.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NormalOneTitleCell *cell = (NormalOneTitleCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NormalOneTitleCell class]) forIndexPath:indexPath];
    LoanPlatformItem *item = [self.loanBuildInfoItem.loan_platform safeObjectAtIndex:indexPath.row];
    [cell configUIWithItem:item finishBlock:^{
        
    }];
    return cell;
    
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //    for (int i ; i < indexPath.row + 1; i ++) {
    //        CGFloat h = Adaptor_Value(15);
    //        EDuQuestionItem *item = [self.eduQuestionList safeObjectAtIndex:i];
    //        CGFloat titleH = [item.title boundingRectWithSize:CGSizeMake(Adaptor_Value(315) - Adaptor_Value(10) *2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:SemiboldFONT(15)} context:nil].size.height;
    //        h += titleH;
    //        h += ceilf(item.options.count/2.0) * Adaptor_Value(35) + Adaptor_Value(15) * (ceilf(item.options.count/2.0)+1);
    //        if (h > _bottomCollectionViewMaxHeight) {
    //            _bottomCollectionViewMaxHeight = h;
    //        }
    //    }
    //    __weak __typeof(self) weakSelf = self;
    //    if (_bottomCollectionViewMaxHeight > Adaptor_Value(160)) {
    //        [self.bottomCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.height.mas_equalTo(Adaptor_Value(weakSelf.bottomCollectionViewMaxHeight));
    //        }];
    //        if (self.CeSuanCustomViewChangeHeightBlock) {
    //            self.CeSuanCustomViewChangeHeightBlock();
    //        }
    //    }
    //
    return CGSizeMake(Adaptor_Value(108) , Adaptor_Value(45));
    
    
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(AdaptedWidth(0), AdaptedWidth(23), AdaptedWidth(10), AdaptedWidth(23));
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LoanPlatformItem *item = [self.loanBuildInfoItem.loan_platform safeObjectAtIndex:indexPath.row];
    item.isSelected = !item.isSelected;
    NormalOneTitleCell *cell = (NormalOneTitleCell *)[collectionView cellForItemAtIndexPath:indexPath];

    [cell configUIWithItem:item finishBlock:^{
        
    }];
}
#pragma mark - lazy
- (UIView *)platformView{
    if (!_platformView) {
        _platformView  = [UIView new];
        UIView *contentV = [UIView new];
        contentV.backgroundColor = BackGroundColor;
        [_platformView addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.platformView);
        }];
        
        _platformViewTipLable1 = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:SemiboldFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_platformViewTipLable1];
        [_platformViewTipLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(25));
            make.top.mas_equalTo(Adaptor_Value(25));
        }];
        
        [contentV addSubview:self.platformCollectionView];
        [self.platformCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(contentV);
            make.height.mas_equalTo(Adaptor_Value(125));
            make.top.mas_equalTo(weakSelf.platformViewTipLable1.mas_bottom).offset(Adaptor_Value(15));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(15));
        }];
    }
    return _platformView;
}
-(UICollectionView *)platformCollectionView{
    if (!_platformCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 10;
        _platformCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _platformCollectionView.backgroundColor = [UIColor clearColor];
        [_platformCollectionView registerClass:[NormalOneTitleCell class] forCellWithReuseIdentifier:NSStringFromClass([NormalOneTitleCell class])];
        _platformCollectionView.delegate = self;
        _platformCollectionView.dataSource = self;
        _platformCollectionView.showsVerticalScrollIndicator = NO;
        _platformCollectionView.showsHorizontalScrollIndicator = NO;
        _platformCollectionView.pagingEnabled = YES;
        
    }
    return _platformCollectionView;
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
        
        _bottomTipLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:SemiboldFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTipLable];
        [_bottomTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(25));
            make.top.mas_equalTo(Adaptor_Value(35));
        }];
        _bottomTipSubLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTipSubLable];
        [_bottomTipSubLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.bottomTipLable);
            make.top.mas_equalTo(weakSelf.bottomTipLable.mas_bottom).offset(Adaptor_Value(10));
        }];
        
        _confirmBtn = [[CommonBtn alloc] init];
        [_confirmBtn setTitle:lqLocalized(@"信息无误，确认提交", nil) forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchDown];
        [contentV addSubview:_confirmBtn];
        _confirmBtn.CommonBtnEndLongPressBlock = ^(UIButton *sender){
            [weakSelf confirmBtnClick:sender];
        };
        [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.bottomTipSubLable);
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(25));
            make.top.mas_equalTo(weakSelf.bottomTipSubLable.mas_bottom).offset(Adaptor_Value(50));
            make.height.mas_equalTo(Adaptor_Value(60));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(30));
        }];
        
    }
    return _bottomView;
}
@end
