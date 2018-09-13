//
//  CeSuanCustomView.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/31.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "CeSuanCustomView.h"
#import "CeSuanViewBottomCell.h"
#import "HomeModel.h"
#import "UICountingLabel.h"


@interface CeSuanCustomView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UIImageView *imageV;
@property (nonatomic,strong)UICountingLabel *eduLable;
@property (nonatomic,strong)UILabel *eduTipLable;
@property (nonatomic,strong)UILabel *bottomTipLable;
//@property (nonatomic,strong)UICollectionView *bottomCollectionView;
@property (nonatomic,strong)UIScrollView *bottomScrollView;
@property (nonatomic,strong)CommonBtn *confirmBtn;
@property (nonatomic,strong)UIView *btnShadow;
@property (nonatomic,strong)NSArray *eduQuestionList;
@property (nonatomic,assign)CGFloat bottomCollectionViewMaxHeight;
@property (nonatomic,strong)NSMutableArray *optionsArr;

@property (nonatomic,assign)NSInteger oldPage;
@end
@implementation CeSuanCustomView

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
#pragma mark - refresh ui
- (void)configUIWithItem:(EDuThemeItem *)item eduQuestionList:(NSArray *)eduQuestionList finishBlock:(void(^)())finishBlock{
    _optionsArr = [NSMutableArray array];
    for (EDuQuestionItem *item in eduQuestionList) {
        [_optionsArr addObject:@(1000)];
    }

    self.eduQuestionList = eduQuestionList;

    self.eduTipLable.text = item.a1;
    self.bottomTipLable.text = item.a2;
    [self.confirmBtn setTitle:item.a3 forState:UIControlStateNormal];
//    [self.bottomCollectionView reloadData];
    for (UIView *subView in self.bottomScrollView.subviews) {
        [subView removeFromSuperview];
    }
    
    
    //5代表_optionsArr.count
    for (int i = 0 ; i < _optionsArr.count; i++) {//315代表每个CeSuanViewBottomCell的宽度   10代表两个CeSuanViewBottomCell之前的间距
        CGFloat h = Adaptor_Value(15);
        EDuQuestionItem *item = [self.eduQuestionList safeObjectAtIndex:i];
        CGFloat titleH = [item.title boundingRectWithSize:CGSizeMake(Adaptor_Value(315) - Adaptor_Value(10) *2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:SemiboldFONT(15)} context:nil].size.height;
        h += titleH;
        h += ceilf(item.options.count/2.0) * Adaptor_Value(35) + Adaptor_Value(15) * (ceilf(item.options.count/2.0)+1);
        if (h > _bottomCollectionViewMaxHeight) {
            _bottomCollectionViewMaxHeight = h;
        }
        
        __weak __typeof(self) weakSelf = self;
        if (_bottomCollectionViewMaxHeight > Adaptor_Value(160)) {
            [self.bottomScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(Adaptor_Value(weakSelf.bottomCollectionViewMaxHeight));
            }];
            if (self.CeSuanCustomViewChangeHeightBlock) {
                self.CeSuanCustomViewChangeHeightBlock();
            }
        }
        //zhuyzhuy
        CeSuanViewBottomCell *view = [[CeSuanViewBottomCell alloc] initWithFrame:CGRectMake(i*(315 + 10), 0, 315, h)];
        view.tag = i;
        __weak __typeof(view) weakView = view;

        EDuQuestionItem *questItem = [eduQuestionList safeObjectAtIndex:i];
        [view configUIWithItem:questItem index:i finishBlock:^{
            CGFloat H = [weakView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            [LSVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%ld",H]];

        }];
        [self.bottomScrollView addSubview:view];
        view.ceSuanViewBottomCellClickBlock = ^(NSInteger index) {
            CGFloat targetContentOffsetX = weakSelf.bottomScrollView.contentOffset.x + weakSelf.bottomScrollView.lq_width;
            if (targetContentOffsetX > (weakSelf.bottomScrollView.contentSize.width - weakSelf.bottomScrollView.lq_width)) {
                targetContentOffsetX = weakSelf.bottomScrollView.contentSize.width - weakSelf.bottomScrollView.lq_width;
            }
            [weakSelf.bottomScrollView setContentOffset:CGPointMake(targetContentOffsetX , 0) animated:YES];
            
                [weakSelf.optionsArr setObject:@(index) atIndexedSubscript:weakView.tag];
        
                BOOL allSel = YES;
                for ( NSNumber *a in weakSelf.optionsArr) {
                    if ([a integerValue] == 1000) {
                        allSel = NO;
                    }
                }
                weakSelf.confirmBtn.btnEnable = allSel;
                weakSelf.confirmBtn.btnSeleted = allSel;
        
                if (allSel) {
                    //按钮阴影
                    weakSelf.btnShadow.layer.shadowColor = [UIColor colorWithHexString:@"#ff0000" alpha:0.4].CGColor;
                    weakSelf.btnShadow.layer.shadowOpacity = 0.5f;
                    weakSelf.btnShadow.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);//和下方 配合偏移
                    weakSelf.btnShadow.layer.shadowRadius = 2;
                    weakSelf.btnShadow.layer.masksToBounds = NO;
                }
        
        };
    }
    [self.bottomScrollView setContentSize:CGSizeMake(_optionsArr.count*(315 + 10), 0)];
    

    finishBlock();
}
- (void)setEduLable:(NSInteger)count{
    [_eduLable countFrom:0 to:count];

}

#pragma mark - act
- (void)confirmBtnClick:(UIButton *)sender{
    if (self.ceSuanCustomViewCesuanBtnClickBlock) {
        NSString *str = [self.optionsArr componentsJoinedByString:@","];
        self.ceSuanCustomViewCesuanBtnClickBlock(sender, @{@"options":str});
    }
}

//#pragma mark collectionView代理方法
//
////每个section的item个数
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
////    return self.eduQuestionList.count;
//    return 5;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CeSuanViewBottomCell *cell = (CeSuanViewBottomCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CeSuanViewBottomCell class]) forIndexPath:indexPath];
//    EDuQuestionItem *item = [self.eduQuestionList safeObjectAtIndex:indexPath.row];
//    __weak __typeof(self) weakSelf = self;
//
//    cell.ceSuanViewBottomCellClickBlock = ^(NSInteger index) {
//        //向下一页滚
//        NSInteger nextRow = (indexPath.row + 1 > item.options.count -1) ? item.options.count -1 :indexPath.row + 1;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSIndexPath *path = [NSIndexPath indexPathForRow:nextRow inSection:0];
//            [weakSelf.bottomCollectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
//            [weakSelf.bottomCollectionView setContentOffset:CGPointMake(weakSelf.bottomCollectionView.contentOffset.x + (LQScreemW - AdaptedWidth(315)) * 0.5 , 0) animated:NO];
//
//
//        });
//        [weakSelf.optionsArr setObject:@(index) atIndexedSubscript:indexPath.row];
//
//        BOOL allSel = YES;
//        for ( NSNumber *a in weakSelf.optionsArr) {
//            if ([a integerValue] == 1000) {
//                allSel = NO;
//            }
//        }
//        weakSelf.confirmBtn.btnEnable = allSel;
//        weakSelf.confirmBtn.btnSeleted = allSel;
//
//        if (allSel) {
//            //按钮阴影
//            weakSelf.btnShadow.layer.shadowColor = [UIColor colorWithHexString:@"#ff0000" alpha:0.4].CGColor;
//            weakSelf.btnShadow.layer.shadowOpacity = 0.5f;
//            weakSelf.btnShadow.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);//和下方 配合偏移
//            weakSelf.btnShadow.layer.shadowRadius = 2;
//            weakSelf.btnShadow.layer.masksToBounds = NO;
//        }
//
//    };
//
//    [cell configUIWithItem:item index:indexPath.row finishBlock:^{
//
//    }];
//    return cell;
//}
////设置每个item的尺寸
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//
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
//    return CGSizeMake(Adaptor_Value(315) ,_bottomCollectionViewMaxHeight > Adaptor_Value(150) ? _bottomCollectionViewMaxHeight : Adaptor_Value(150));
//
//
//}
////设置每个item的UIEdgeInsets
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(AdaptedWidth(0), AdaptedWidth(30), AdaptedWidth(0), AdaptedWidth(10));
//}
//
//
//
//
////点击item方法
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//}



#pragma mark - lazy
- (UIView *)header{
    if (!_header) {
        _header = [UIView new];
        UIView *contentV = [UIView new];
        contentV.backgroundColor = BackGroundColor;
        [_header addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.header);
        }];
        
        _imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circleProgress"]];
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        [contentV addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(contentV);
            make.height.mas_equalTo(Adaptor_Value(265));
        }];
//        _eduLable = [UILabel lableWithText:@"" textColor:[UIColor whiteColor] fontSize:SemiboldFONT(40) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        _eduLable = [UICountingLabel new];
        _eduLable.textColor = [UIColor whiteColor];
        _eduLable.font = SemiboldFONT(40);
        _eduLable.format = @"%d";
        _eduLable.animationDuration = 1.0;

        [contentV addSubview:_eduLable];
        [_eduLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(Adaptor_Value(110));
        }];
        _eduTipLable = [UILabel lableWithText:@"" textColor:[UIColor whiteColor] fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_eduTipLable];
        [_eduTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.eduLable.mas_bottom).offset(Adaptor_Value(20));
        }];
        
        _bottomTipLable = [UILabel lableWithText:@""  textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTipLable];
        [_bottomTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(24));
            make.top.mas_equalTo(weakSelf.imageV.mas_bottom).offset(Adaptor_Value(25));
            make.width.mas_equalTo(LQScreemW - Adaptor_Value(24) * 2);
        }];
        
//        [contentV addSubview:self.bottomCollectionView];
//        [self.bottomCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(weakSelf.bottomTipLable.mas_bottom).offset(Adaptor_Value(30));
//            make.right.left.mas_equalTo(contentV);
//            make.height.mas_equalTo(Adaptor_Value(150));
//        }];
        
        [contentV addSubview:self.bottomScrollView];
        [self.bottomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.bottomTipLable.mas_bottom).offset(Adaptor_Value(30));
            make.left.mas_equalTo(contentV).offset(20);//scrollView距离左边的距离
            make.width.equalTo(@(315 + 10));//注意,scrollView的宽度为每个itemView的宽度+10,10代表每个itemView之前的宽度
            make.height.mas_equalTo(Adaptor_Value(150));
        }];
        
        CommonBtn *confirmBtn = [[CommonBtn alloc] init];
        _confirmBtn = confirmBtn;

        [confirmBtn setTitle:lqLocalized(@"立即登录", nil) forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchDown];
        [contentV addSubview:confirmBtn];
        confirmBtn.CommonBtnEndLongPressBlock = ^(UIButton *sender){
            [weakSelf confirmBtnClick:sender];
        };
        //默认 disable
        confirmBtn.btnEnable = NO;
        [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(55));
            make.right.mas_equalTo(weakSelf.header).offset(-Adaptor_Value(55));
            make.top.mas_equalTo(weakSelf.bottomScrollView.mas_bottom).offset(Adaptor_Value(35));
            make.height.mas_equalTo(Adaptor_Value(60));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(30));
        }];
        _btnShadow = [UIView new];
        _btnShadow.backgroundColor = [UIColor whiteColor];
        [contentV insertSubview:_btnShadow belowSubview:confirmBtn];
        [_btnShadow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(confirmBtn);
            make.width.mas_equalTo(confirmBtn).offset(-5);
            make.centerX.mas_equalTo(confirmBtn);
        }];
    }
    return _header;
}

//-(UICollectionView *)bottomCollectionView{
//    if (!_bottomCollectionView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        //设置collectionView滚动方向
//        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//
//        _bottomCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//        _bottomCollectionView.backgroundColor = [UIColor clearColor];
//        [_bottomCollectionView registerClass:[CeSuanViewBottomCell class] forCellWithReuseIdentifier:NSStringFromClass([CeSuanViewBottomCell class])];
//        _bottomCollectionView.delegate = self;
//        _bottomCollectionView.dataSource = self;
//        _bottomCollectionView.showsVerticalScrollIndicator = NO;
//        _bottomCollectionView.showsHorizontalScrollIndicator = NO;
//        _bottomCollectionView.pagingEnabled = YES;
//
//    }
//    return _bottomCollectionView;
//}

/**
 关键地方
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *child = [super hitTest:point withEvent:event];
    
    if (child == self) {
        return self.bottomScrollView;
    }
    
    return child;
}






-(UIScrollView *)bottomScrollView{
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc] init];
        _bottomScrollView.delegate = self;
        _bottomScrollView.showsVerticalScrollIndicator = NO;
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
        _bottomScrollView.clipsToBounds = NO;//关键地方，必须设置
        _bottomScrollView.pagingEnabled = YES;
        
    }
    return _bottomScrollView;
}
@end
