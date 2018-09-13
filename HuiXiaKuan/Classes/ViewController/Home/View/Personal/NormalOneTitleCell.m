//
//  NormalOneTitleCell.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/5.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "NormalOneTitleCell.h"
#import "HomeModel.h"

@interface NormalOneTitleCell()
@property (nonatomic,strong)UIView *contentV;
@property (nonatomic,strong)UILabel *titleLable;
@end
@implementation NormalOneTitleCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        
    }
    return self;
}
#pragma mark - ui
-(void)configUI{
    [self.contentView addSubview:self.contentV];
    __weak __typeof(self) weakSelf = self;
    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.contentView);
    }];
}
#pragma mark - refresh ui
- (void)configUIWithItem:(LoanPlatformItem *)item finishBlock:(void(^)())finishBlock{
    self.titleLable.text = item.name;
    if (item.isSelected) {
        self.contentV.backgroundColor = BlueJianbian1;
        self.titleLable.textColor = [UIColor whiteColor];
    }else{
        self.contentV.backgroundColor = [UIColor whiteColor];
        self.titleLable.textColor = TitleGrayColor;
        
    }
}

#pragma mark - lazy
- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [UIView new];
        _contentV.backgroundColor = [UIColor whiteColor];

        _titleLable = [UILabel lableWithText:@"" textColor:TitleGrayColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [_contentV addSubview:_titleLable];
        __weak __typeof(self) weakSelf = self;
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(weakSelf.contentV);
        }];
    }
    return _contentV;
}

@end
