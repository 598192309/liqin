//
//  AboutCustomView.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/4.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "AboutCustomView.h"
#import "HomeBottomCollectionViewCell.h"
#import "SDCycleScrollView.h"
#import "Setting.h"
@interface AboutCustomView()<SDCycleScrollViewDelegate>
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UIImageView *topImageV;
//公司简介
@property (nonatomic,strong)UILabel *gsTipLable;
@property (nonatomic,strong)UILabel *gsContentLable;

//渠道
@property (nonatomic,strong)UILabel *qudaoTipLable;
@property (nonatomic,strong)UILabel *qudaoContentTipLable;
@property (nonatomic,strong)UIImageView *qudaoImageV;
@property (nonatomic,strong)UILabel *qudaoContentLable;

//联系方式
@property (nonatomic,strong)UILabel *contactTipLable;
@property (nonatomic,strong)UILabel *adressTipLable;
@property (nonatomic,strong)UILabel *adressLable;
@property (nonatomic,strong)UILabel *customerTipLable;
@property (nonatomic,strong)UILabel *customerLable;
@property (nonatomic,strong)UILabel *complaintTipLable;
@property (nonatomic,strong)UILabel *complaintLable;
@property (nonatomic,strong)UILabel *wechatTipLable;
@property (nonatomic,strong)UILabel *wechatLable;
@property (nonatomic,strong)UILabel *emailTipLable;
@property (nonatomic,strong)UILabel *emailLable;

//企业氛围
@property (nonatomic,strong)UILabel *fenweiTipLable;
@property (nonatomic,strong)UIButton *backBtn;
//@property (nonatomic,strong)UICollectionView *bottomCollectionView;
@property (nonatomic,strong)SDCycleScrollView *infiniteView;
@property (nonatomic,assign)NSInteger infiniteIndex;

@property (nonatomic,strong)UIButton *nextBtn;

@property (nonatomic,strong)UIImageView *logoImageV;

@property (nonatomic,strong)AboutItem *aboutItem;

@end
@implementation AboutCustomView

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
- (void)configUIWithItem:(AboutItem *)item finishi:(void(^)())finishBlock{
    _aboutItem = item;
    WeChatItem *wechatItem = item.wechat;
    ContactItem *contactItem = item.contact;
    [_topImageV sd_setImageWithURL:[NSURL URLWithString:item.bg]];
    _gsTipLable.text = lqLocalized(@"•公司简介", nil);
    NSAttributedString *attstr = [NSString attributeStringWithParagraphStyleLineSpace:Adaptor_Value(10) withString:item.content Alignment:NSTextAlignmentLeft];
    _gsContentLable.attributedText = attstr;
    
    _qudaoTipLable.text =  lqLocalized(@"•官方渠道", nil);
    _qudaoContentTipLable.text = lqLocalized(@"微信公众号", nil);
    _qudaoContentLable.text = wechatItem.account;
    [_qudaoImageV sd_setImageWithURL:[NSURL URLWithString:wechatItem.qrcode]];
    
    _contactTipLable.text =  lqLocalized(@"•联系方式", nil);
    _adressTipLable.text = lqLocalized(@"通讯地址:", nil);
    _adressLable.text = contactItem.address;
    _customerTipLable.text = lqLocalized(@"客服电话:", nil);
    _customerLable.text = contactItem.customer_tel;
    _complaintTipLable.text = lqLocalized(@"投诉监督电话:", nil);
    _complaintLable.text = contactItem.complaint_tel;
    _wechatTipLable.text = lqLocalized(@"微信号:", nil);
    _wechatLable.text = contactItem.wechat;
    _emailTipLable.text = lqLocalized(@"客服邮箱:", nil);
    _emailLable.text = contactItem.customer_email;
    
    _fenweiTipLable.text = lqLocalized(@"•企业氛围", nil);
    _infiniteView.imageURLStringsGroup = item.photo;
    
    [_logoImageV sd_setImageWithURL:[NSURL URLWithString:item.logo]];

    finishBlock();
}

#pragma mark - act
- (void)backBtnClick:(UIButton *)sender{
    [self.infiniteView cycleScrollViewdidScrollTobackIndex:_infiniteIndex - 1 <= 0 ? self.aboutItem.photo.count - 1 : _infiniteIndex - 1];
}
- (void)nextBtnClick:(UIButton *)sender{
    [self.infiniteView cycleScrollViewdidScrollToNextIndex:_infiniteIndex + 1 >= self.aboutItem.photo.count ? 0 : _infiniteIndex + 1];


}
#pragma  mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
}
/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    _infiniteIndex = index;
    
}
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
        _topImageV = [[UIImageView alloc] init];
        [contentV addSubview:_topImageV];
        [_topImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(contentV);
            make.height.mas_equalTo(Adaptor_Value(150));
        }];
        
        _gsTipLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:SemiboldFONT(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_gsTipLable];
        [_gsTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.topImageV.mas_bottom).offset(Adaptor_Value(23));
            make.left.mas_equalTo(Adaptor_Value(28));
        }];
        _gsContentLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_gsContentLable];
        [_gsContentLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.gsTipLable.mas_bottom).offset(Adaptor_Value(10));
            make.left.mas_equalTo(weakSelf.gsTipLable);
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(28));

        }];
        
        _qudaoTipLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_qudaoTipLable];
        [_qudaoTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.gsContentLable.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.gsContentLable);
        }];
        
        UIView *erweimaContentView = [UIView new];
        erweimaContentView.backgroundColor = [UIColor whiteColor];
        [contentV addSubview:erweimaContentView];
        [erweimaContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(25));
            make.top.mas_equalTo(weakSelf.qudaoTipLable.mas_bottom).offset(Adaptor_Value(13));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(25));
            make.height.mas_equalTo(Adaptor_Value(275));
        }];
        ViewRadius(erweimaContentView, Adaptor_Value(12));
        erweimaContentView.layer.shadowColor = YinYingColor.CGColor;
        erweimaContentView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        erweimaContentView.layer.shadowOpacity = 0.5f;
        erweimaContentView.layer.shadowRadius = 5;
        erweimaContentView.layer.masksToBounds = NO;

        _qudaoContentTipLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [erweimaContentView addSubview:_qudaoContentTipLable];
        [_qudaoContentTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Adaptor_Value(15));
            make.centerX.mas_equalTo(erweimaContentView);
        }];
        _qudaoImageV = [[UIImageView alloc] init];
        [erweimaContentView addSubview:_qudaoImageV];
        [_qudaoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.qudaoContentTipLable.mas_bottom).offset(Adaptor_Value(15));
            make.centerX.mas_equalTo(erweimaContentView);
            make.height.width.mas_equalTo(Adaptor_Value(185));
        }];
        _qudaoContentLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [erweimaContentView addSubview:_qudaoContentLable];
        [_qudaoContentLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.qudaoImageV.mas_bottom).offset(Adaptor_Value(10));
            make.centerX.mas_equalTo(erweimaContentView);
        }];
        
        
        _contactTipLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:SemiboldFONT(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [erweimaContentView addSubview:_contactTipLable];
        [_contactTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(erweimaContentView.mas_bottom).offset(Adaptor_Value(30));
            make.left.mas_equalTo(weakSelf.gsTipLable);
        }];
        UIView *contactContentView = [UIView new];
        contactContentView.backgroundColor = [UIColor whiteColor];
        [contentV addSubview:contactContentView];
        [contactContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(25));
            make.top.mas_equalTo(weakSelf.contactTipLable.mas_bottom).offset(Adaptor_Value(13));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(25));
//            make.height.mas_equalTo(Adaptor_Value(185));
        }];
        ViewRadius(contactContentView, Adaptor_Value(12));
        contactContentView.layer.shadowColor = YinYingColor.CGColor;
        contactContentView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        contactContentView.layer.shadowOpacity = 0.5f;
        contactContentView.layer.shadowRadius = 5;
        contactContentView.layer.masksToBounds = NO;
        
        _adressTipLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contactContentView addSubview:_adressTipLable];
        [_adressTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Adaptor_Value(24));
            make.left.mas_equalTo(Adaptor_Value(17.5));
        }];
        UIView *line1 = [UIView new];
        line1.backgroundColor = TitleBlackColor;
        [contactContentView addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.adressTipLable.mas_bottom);
            make.left.mas_equalTo(weakSelf.adressTipLable.mas_right);
            make.height.mas_equalTo(kOnePX);
            make.right.mas_equalTo(contactContentView).offset(-Adaptor_Value(17.5));
        }];
        _adressLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contactContentView addSubview:_adressLable];
        [_adressLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.adressTipLable);
            make.left.mas_equalTo(weakSelf.adressTipLable.mas_right);
        }];
        
        _customerTipLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contactContentView addSubview:_customerTipLable];
        [_customerTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.adressTipLable.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.adressTipLable);
        }];
        UIView *line2 = [UIView new];
        line2.backgroundColor = TitleBlackColor;
        [contactContentView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.customerTipLable.mas_bottom);
            make.left.mas_equalTo(weakSelf.customerTipLable.mas_right);
            make.height.mas_equalTo(kOnePX);
            make.right.mas_equalTo(contactContentView).offset(-Adaptor_Value(17.5));

        }];
        _customerLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contactContentView addSubview:_customerLable];
        [_customerLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.customerTipLable);
            make.left.mas_equalTo(weakSelf.customerTipLable.mas_right);
        }];
        
        _complaintTipLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contactContentView addSubview:_complaintTipLable];
        [_complaintTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.customerTipLable.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.customerTipLable);
        }];
        UIView *line3 = [UIView new];
        line3.backgroundColor = TitleBlackColor;
        [contactContentView addSubview:line3];
        [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.complaintTipLable.mas_bottom);
            make.left.mas_equalTo(weakSelf.complaintTipLable.mas_right);
            make.height.mas_equalTo(kOnePX);
            make.right.mas_equalTo(contactContentView).offset(-Adaptor_Value(17.5));

        }];
        _complaintLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contactContentView addSubview:_complaintLable];
        [_complaintLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.complaintTipLable);
            make.left.mas_equalTo(weakSelf.complaintTipLable.mas_right);
        }];

        _wechatTipLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contactContentView addSubview:_wechatTipLable];
        [_wechatTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.complaintTipLable.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.complaintTipLable);
        }];
        UIView *line4 = [UIView new];
        line4.backgroundColor = TitleBlackColor;
        [contactContentView addSubview:line4];
        [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.wechatTipLable.mas_bottom);
            make.left.mas_equalTo(weakSelf.wechatTipLable.mas_right);
            make.height.mas_equalTo(kOnePX);
            make.right.mas_equalTo(contactContentView).offset(-Adaptor_Value(17.5));

        }];
        _wechatLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contactContentView addSubview:_wechatLable];
        [_wechatLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.wechatTipLable);
            make.left.mas_equalTo(weakSelf.wechatTipLable.mas_right);
        }];
        
        _emailTipLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contactContentView addSubview:_emailTipLable];
        [_emailTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.wechatTipLable.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.wechatTipLable);
        }];
        UIView *line5 = [UIView new];
        line5.backgroundColor = TitleBlackColor;
        [contactContentView addSubview:line5];
        [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.emailTipLable.mas_bottom);
            make.left.mas_equalTo(weakSelf.emailTipLable.mas_right);
            make.height.mas_equalTo(kOnePX);
            make.right.mas_equalTo(contactContentView).offset(-Adaptor_Value(17.5));

            make.bottom.mas_equalTo(contactContentView).offset(-Adaptor_Value(20));
        }];
        _emailLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contactContentView addSubview:_emailLable];
        [_emailLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.emailTipLable);
            make.left.mas_equalTo(weakSelf.emailTipLable.mas_right);
        }];
        
        _fenweiTipLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:RegularFONT(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_fenweiTipLable];
        [_fenweiTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contactContentView.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.gsTipLable);
        }];
        
        _infiniteView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Adaptor_Value(250), Adaptor_Value(155)) delegate:self placeholderImage:nil];
        _infiniteView.backgroundColor = [UIColor clearColor];
        _infiniteView.boworrWidth = AdaptedWidth(250);
        _infiniteView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
        _infiniteView.cellSpace = Adaptor_Value(10);
        _infiniteView.showPageControl = YES;
        _infiniteView.autoScroll = NO;
        [contentV addSubview:_infiniteView];
        [_infiniteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(140));
            make.width.mas_equalTo(Adaptor_Value(255));
            make.top.mas_equalTo(weakSelf.fenweiTipLable.mas_bottom).offset(Adaptor_Value(13));
            make.centerX.mas_equalTo(contentV);

        }];
        _backBtn = [[UIButton alloc] init];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [contentV addSubview:_backBtn];
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(Adaptor_Value(13));
            make.height.mas_equalTo(Adaptor_Value(32));
            make.left.mas_equalTo(Adaptor_Value(25));
            make.centerY.mas_equalTo(weakSelf.infiniteView).offset(-10);
        }];
        
        _nextBtn = [[UIButton alloc] init];
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"arrow-right"] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [contentV addSubview:_nextBtn];
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(Adaptor_Value(13));
            make.height.mas_equalTo(Adaptor_Value(32));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(25));
            make.centerY.mas_equalTo(weakSelf.backBtn);
        }];
        
        _logoImageV = [[UIImageView alloc] init];
        _logoImageV.contentMode = UIViewContentModeScaleAspectFit;
        [contentV addSubview:_logoImageV];
        [_logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(Adaptor_Value(70));
            make.height.mas_equalTo(Adaptor_Value(22.5));
            make.top.mas_equalTo(weakSelf.infiniteView.mas_bottom).offset(Adaptor_Value(20));
            make.bottom.mas_equalTo(-Adaptor_Value(10));
            make.centerX.mas_equalTo(contentV);
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
//        [_bottomCollectionView registerClass:[HomeBottomCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeBottomCollectionViewCell class])];
//        _bottomCollectionView.delegate = self;
//        _bottomCollectionView.dataSource = self;
//        _bottomCollectionView.showsVerticalScrollIndicator = NO;
//        _bottomCollectionView.showsHorizontalScrollIndicator = NO;
//
//    }
//    return _bottomCollectionView;
//}


@end
