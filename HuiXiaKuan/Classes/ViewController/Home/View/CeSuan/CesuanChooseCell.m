//
//  CesuanChooseCell.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/3.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "CesuanChooseCell.h"
@interface CesuanChooseCell()
@property (nonatomic,strong)UIView *contentV;
@property (nonatomic,strong)UILabel *titleLable;
@end
@implementation CesuanChooseCell
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
- (void)configUIWithStr:(NSString *)str selected:(BOOL)selected finishBlock:(void(^)())finishBlock{
    self.titleLable.text = str;
    if (selected) {
        self.contentV.backgroundColor = BlueJianbian1;
        self.titleLable.textColor = [UIColor whiteColor];
    }else{
        self.contentV.backgroundColor = [UIColor whiteColor];
        self.titleLable.textColor = TitleBlackColor;

    }
}

#pragma mark - lazy
- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [UIView new];
        ViewBorderRadius(_contentV, 0, kOnePX *2, BlueJianbian1);
        _titleLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(13) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [_contentV addSubview:_titleLable];
        __weak __typeof(self) weakSelf = self;
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(weakSelf.contentV);
        }];
    }
    return _contentV;
}
@end
