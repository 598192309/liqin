//
//  multipleChoiceCell.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/6.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "multipleChoiceCell.h"
#import "multipleCollectionCell.h"
#import "HomeModel.h"
@interface multipleChoiceCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UIView *cellBackView;
@property (nonatomic,strong)UILabel *tipLabel;
@property (nonatomic,strong)UILabel *subLable;
@property (nonatomic,strong)UILabel *contentTipLable;
//@property (nonatomic,strong)UICollectionView *bottomCollectionView;
@property (nonatomic,strong)UIScrollView *bottomScrollView;

@property (nonatomic,assign)CGFloat bottomCollectionViewMaxHeight;
@property (nonatomic,strong)CreditInfoItem *creditInfoItem;

@end
@implementation multipleChoiceCell
#pragma mark - 生命周期
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        self.contentView.backgroundColor = BackGroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)configUI{
    [self.contentView addSubview:self.cellBackView];
    __weak __typeof(self) weakSelf = self;
    [self.cellBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.contentView);
    }];
    _optionsArr = [NSMutableArray array];
}

#pragma mark - refresh ui
- (void)configUIWithItem:(CreditInfoItem *)item  finishBlock:(void(^)())finishBlock{
    self.creditInfoItem = item;
    self.tipLabel.text = item.cat_name;
    if (!RI.is_vest) {
        self.subLable.text = lqLocalized(@"若因资料不实导致下款失败，渠道管理费将不予退还。", nil);
    }
    for (NSObject *a  in item.questions) {
        [_optionsArr addObject:@(1000)];
    }

//    [self.bottomCollectionView reloadData];
    for (UIView *subView in self.bottomScrollView.subviews) {
        [subView removeFromSuperview];
    }
    
//#warning ceshi
//    [_optionsArr addObjectsFromArray:@[@(1000),@(1000),@(1000),@(1000),@(1000)]];
    //5代表_optionsArr.count
    for (int i = 0 ; i < _optionsArr.count; i++) {//315代表每个CeSuanViewBottomCell的宽度   10代表两个CeSuanViewBottomCell之前的间距
        CGFloat h = Adaptor_Value(15);
        EDuQuestionItem *item = [self.creditInfoItem.questions safeObjectAtIndex:i];
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
//            if (self.CeSuanCustomViewChangeHeightBlock) {
//                self.CeSuanCustomViewChangeHeightBlock();
//            }
        }
        //zhuyzhuy
        multipleCollectionCell *view = [[multipleCollectionCell alloc] initWithFrame:CGRectMake(i*(315 + 10), 0, 315, Adaptor_Value(160))];
        view.tag = i;
        __weak __typeof(view) weakView = view;
        
        [view configUIWithItem:item index:i finishBlock:^{
            CGFloat H = [weakView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            [LSVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%ld",H]];
            
        }];
        
        [self.bottomScrollView addSubview:view];
        view.multipleCollectionCellClickBlock = ^(NSInteger index) {
            CGFloat targetContentOffsetX = weakSelf.bottomScrollView.contentOffset.x + weakSelf.bottomScrollView.lq_width;
            if (targetContentOffsetX > (weakSelf.bottomScrollView.contentSize.width - weakSelf.bottomScrollView.lq_width)) {
                targetContentOffsetX = weakSelf.bottomScrollView.contentSize.width - weakSelf.bottomScrollView.lq_width;
            }
            [weakSelf.bottomScrollView setContentOffset:CGPointMake(targetContentOffsetX , 0) animated:YES];
            
            [weakSelf.optionsArr setObject:@(index) atIndexedSubscript:weakView.tag];
    
            if (weakSelf.multipleChoiceCellChooseBlock) {
                weakSelf.multipleChoiceCellChooseBlock(index,i);
            }
            item.selected = [NSString stringWithFormat:@"%ld",index];

            
        };
    }
    [self.bottomScrollView setContentSize:CGSizeMake(_optionsArr.count*(315 + 10), 0)];
    
    finishBlock();
}
//#pragma mark collectionView代理方法
//
////每个section的item个数
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.creditInfoItem.questions.count;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    multipleCollectionCell *cell = (multipleCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([multipleCollectionCell class]) forIndexPath:indexPath];
//    EDuQuestionItem *item = [self.creditInfoItem.questions safeObjectAtIndex:indexPath.row];
//    __weak __typeof(self) weakSelf = self;
//
//    cell.multipleCollectionCellClickBlock  = ^(NSInteger index) {
//        //向下一页滚
//        NSInteger nextRow = (indexPath.row + 1 >= self.creditInfoItem.questions.count -1) ? self.creditInfoItem.questions.count -1 :indexPath.row + 1;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.bottomCollectionView setContentOffset:CGPointMake(AdaptedWidth(315)*nextRow , 0) animated:YES];
//
//        });
//        [weakSelf.optionsArr setObject:@(index) atIndexedSubscript:indexPath.row];
//
//        if (weakSelf.multipleChoiceCellChooseBlock) {
//            weakSelf.multipleChoiceCellChooseBlock(index,indexPath);
//        }
//        EDuQuestionItem *item = [self.creditInfoItem.questions safeObjectAtIndex:indexPath.row];
//        item.selected = [NSString stringWithFormat:@"%ld",index];
//        [weakSelf.bottomCollectionView reloadData];
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
//
//        EDuQuestionItem *item = [self.creditInfoItem.questions safeObjectAtIndex:i];
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
//
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



#pragma mark - lazy
- (UIView *)cellBackView{
    if (!_cellBackView) {
        _cellBackView = [UIView new];
        _cellBackView.backgroundColor = BackGroundColor;
        _tipLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:SemiboldFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_cellBackView addSubview:_tipLabel];
        __weak __typeof(self) weakSelf = self;
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(25));
            make.top.mas_equalTo(Adaptor_Value(25));
        }];
        _subLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_cellBackView addSubview:_subLable];
        [_subLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.tipLabel);
            make.top.mas_equalTo(weakSelf.tipLabel.mas_bottom).offset(Adaptor_Value(10));
        }];
        
//        [_cellBackView addSubview:self.bottomCollectionView];
//        [self.bottomCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(weakSelf.subLable.mas_bottom).offset(Adaptor_Value(30));
//            make.right.left.mas_equalTo(weakSelf.cellBackView);
//            make.height.mas_equalTo(Adaptor_Value(150));
//            make.bottom.mas_equalTo(weakSelf.cellBackView).offset(-Adaptor_Value(30));
//        }];
        
        
        [_cellBackView addSubview:self.bottomScrollView];
        [self.bottomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.subLable.mas_bottom).offset(Adaptor_Value(30));
            make.left.mas_equalTo(Adaptor_Value(20));//scrollView距离左边的距离
            make.height.mas_equalTo(Adaptor_Value(150));
            make.bottom.mas_equalTo(weakSelf.cellBackView).offset(-Adaptor_Value(30));
            make.width.equalTo(@(315 + 10));//注意,scrollView的宽度为每个itemView的宽度+10,10代表每个itemView之前的宽度

        }];
        
    }
    return _cellBackView;
}
//-(UICollectionView *)bottomCollectionView{
//    if (!_bottomCollectionView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        //设置collectionView滚动方向
//        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//
//        _bottomCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//        _bottomCollectionView.backgroundColor = [UIColor clearColor];
//        [_bottomCollectionView registerClass:[multipleCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([multipleCollectionCell class])];
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
