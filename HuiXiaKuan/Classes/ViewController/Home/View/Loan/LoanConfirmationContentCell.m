//
//  LoanConfirmationContentCell.m
//  RabiBird
//
//  Created by Lqq on 2018/7/24.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "LoanConfirmationContentCell.h"
#import "HomeModel.h"
@interface LoanConfirmationContentCell()


@property (nonatomic,strong) UIView * cellBackgroundView;
@property (nonatomic, strong) UIImageView * leftImageView;
@property (nonatomic, strong) UIImageView * rightImageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * tagsLabel;

@property (nonatomic, strong) CALayer * jianbianLayer;
@property (nonatomic, strong) UILabel * priceLabel;
@end

@implementation LoanConfirmationContentCell
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.contentView.backgroundColor = [UIColor clearColor];
        [self addPageSubviews];
        [self layoutPageSubviews];
       
        self.layer.shadowColor = [UIColor colorWithHexString:@"#00c7bd" alpha:0.3].CGColor;
        self.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        self.layer.shadowOpacity = 0.3f;
        self.layer.shadowRadius = 3;
        self.layer.masksToBounds = NO;
    }
    return self;
}
-(void)addPageSubviews{
    [self.contentView addSubview:self.cellBackgroundView];
    [self.cellBackgroundView addSubview:self.priceLabel];
}
-(void)layoutPageSubviews{
    __weak __typeof(self) weakSelf = self;
    [self.cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
   
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf.cellBackgroundView);
    }];
    self.priceLabel.userInteractionEnabled = NO;
}

- (void)configUIWithItme:(LoanTypeItem *)item{
    
    self.priceLabel.text = item.scope;
    self.cellBackgroundView.backgroundColor = item.isSelected ? [UIColor colorWithHexString:@"00c7bd"] : [UIColor whiteColor];
    self.priceLabel.textColor = item.isSelected ? [UIColor whiteColor] : [UIColor colorWithHexString: @"222020"];
}

-(void)setIsDid:(BOOL)isDid{
    _isDid = isDid;
    
    self.cellBackgroundView.backgroundColor = isDid ? [UIColor colorWithHexString:@"00c7bd"] : [UIColor whiteColor];
    self.priceLabel.textColor = isDid ? [UIColor whiteColor] : [UIColor colorWithHexString: @"222020"];

}


#pragma mark - getters
-(UIView *)cellBackgroundView{
    if (!_cellBackgroundView) {
        _cellBackgroundView = [UIView new];
        _cellBackgroundView.backgroundColor = [UIColor whiteColor];
        
    }
    return _cellBackgroundView;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.font = AdaptedFontSize(15);

    }
    return _priceLabel;
}


@end
