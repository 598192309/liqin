//
//  HomeBottomCollectionViewCell.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/27.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "HomeBottomCollectionViewCell.h"
@interface HomeBottomCollectionViewCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (nonatomic, strong) UIImageView *contentImageView;
@end
@implementation HomeBottomCollectionViewCell
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
    [self.cellBackgroundView addSubview:self.contentImageView];
}
-(void)layoutPageSubviews{
    __weak __typeof(self) weakSelf = self;
    [self.cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];

    
}

- (void)configUIWithUrlString:(NSString *)urlString{
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
}



#pragma mark - getters
-(UIView *)cellBackgroundView{
    if (!_cellBackgroundView) {
        _cellBackgroundView = [UIView new];
        _cellBackgroundView.backgroundColor = [UIColor whiteColor];
        
    }
    return _cellBackgroundView;
}

- (UIImageView *)contentImageView{
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] init];
    }
    return _contentImageView;
}


@end
