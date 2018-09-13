//
//  CeSuanViewBottomCell.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/31.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "CeSuanViewBottomCell.h"
#import "CesuanChooseCell.h"
#import "HomeModel.h"
@interface CeSuanViewBottomCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)EDuQuestionItem *eDuQuestionItem;
@property (nonatomic,assign)NSInteger selectedIndex;
@end
@implementation CeSuanViewBottomCell
#pragma mark - 生命周期
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        [self setLayerCornerRadius:Adaptor_Value(5)];
        _selectedIndex = 1000;
    }
    return self;
}
#pragma mark - ui
-(void)configUI{
    [self addSubview:self.cellBackgroundView];
    __weak __typeof(self) weakSelf = self;

    [self.cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    [self.cellBackgroundView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Adaptor_Value(10));
        make.top.mas_equalTo(Adaptor_Value(15));
        make.right.mas_equalTo(weakSelf.cellBackgroundView).offset(-Adaptor_Value(10));
    }];
    
    [self.cellBackgroundView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf.cellBackgroundView);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(Adaptor_Value(0));
    }];
}

#pragma mark - refresh ui
- (void)configUIWithItem:(EDuQuestionItem *)item index:(NSInteger)index finishBlock:(void(^)())finishBlock{
    _eDuQuestionItem = item;
    self.titleLabel.text = [NSString stringWithFormat:@"%ld.%@",index,item.title];
    [self.collectionView reloadData ];
    finishBlock();
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
//    return  self.eDuQuestionItem.options.count;
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CesuanChooseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CesuanChooseCell class]) forIndexPath:indexPath];
    [cell configUIWithStr:[self.eDuQuestionItem.options safeObjectAtIndex:indexPath.row] selected:indexPath.row == self.selectedIndex  finishBlock:^{
        
    }];
    return cell;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    
    NSInteger section = indexPath.section;
    self.selectedIndex = indexPath.row;
    [self.collectionView reloadData];
    if (self.ceSuanViewBottomCellClickBlock) {
        self.ceSuanViewBottomCellClickBlock(indexPath.row);
    }
    NSLog(@"section =%lu  row =%lu",section ,row);
    
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(Adaptor_Value(125), Adaptor_Value(35));
    
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(AdaptedWidth(15), AdaptedWidth(25), AdaptedWidth(15), AdaptedWidth(25));
}

#pragma mark - lazy
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[CesuanChooseCell class] forCellWithReuseIdentifier:NSStringFromClass([CesuanChooseCell class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
    }
    return _collectionView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lableWithText:@"aa" textColor:TitleBlackColor fontSize:SemiboldFONT(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        
    }
    return _titleLabel;
}
-(UIView *)cellBackgroundView{
    if (!_cellBackgroundView) {
        _cellBackgroundView = [UIView new];
        _cellBackgroundView.backgroundColor = [UIColor whiteColor];
        _cellBackgroundView.layer.shadowColor = [UIColor colorWithHexString:@"#00c7bd" alpha:0.3].CGColor;
        _cellBackgroundView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        _cellBackgroundView.layer.shadowOpacity = 0.3f;
        _cellBackgroundView.layer.shadowRadius = 3;
        _cellBackgroundView.layer.masksToBounds = NO;

    }
    return _cellBackgroundView;
}@end
