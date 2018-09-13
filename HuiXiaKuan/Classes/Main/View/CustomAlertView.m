//
//  CustomAlertView.m
//  RabiBird
//
//  Created by 拉比鸟 on 17/1/4.
//  Copyright © 2017年 Lq. All rights reserved.
//

#import "CustomAlertView.h"
@interface CustomAlertView()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTrailingCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewLeadingCons;

@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *subLable;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secBtn;
@property (weak, nonatomic) IBOutlet UIButton *singleBtn;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *visualEffectView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end
@implementation CustomAlertView
- (IBAction)firstBtnClick:(UIButton *)sender {
    if (self.CustomAlertViewBlock) {
        self.CustomAlertViewBlock(1,[sender titleForState:UIControlStateNormal]);
    }
}
- (IBAction)secBtnClick:(UIButton *)sender {
    if (self.CustomAlertViewBlock) {
        self.CustomAlertViewBlock(2,[sender titleForState:UIControlStateNormal]);
    }
}
- (IBAction)singleBtnClick:(UIButton *)sender {
    if (self.CustomAlertViewBlock) {
        self.CustomAlertViewBlock(3,[sender titleForState:UIControlStateNormal]);
    }
}

#pragma  mark - 拖拽
#pragma  mark - 类方法
+ (instancetype)instanceView{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (void)setCustomCoverView:(UIView *)customCoverView{
    _customCoverView = customCoverView;
    _visualEffectView .hidden = YES;
    _shadowView.hidden = YES;
    
    [self.contentView insertSubview:customCoverView atIndex:0];
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [customCoverView addGestureRecognizer:tap];

}
#pragma  mark - smzq

- (void)awakeFromNib{
    [super awakeFromNib];
    self.viewLeadingCons.constant = Adaptor_Value(30);
    self.viewTrailingCons.constant = Adaptor_Value(30);
    [self.alertView setLayerCornerRadius:10];

    //添加阴影
    self.shadowView.layer.shadowColor = [UIColor colorWithHexString:@"1d1d1d" alpha:0.3].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(0.0f, 0.5f);
    self.shadowView.layer.shadowOpacity = 0.5f;
    self.shadowView.layer.shadowRadius = 5;
    self.shadowView.layer.masksToBounds = NO;
    
    self.singleBtn.hidden = YES;


    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.visualEffectView addGestureRecognizer:tap];

}


-(void)refreshUIWithTitle:(NSString *)title subTitle:(NSString *)subTitle firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle  singleBtnHidden:(BOOL)hidden  singleBtnTitle:(NSString *)singleBtnTitle{
    self.titlelabel.text = title;
    self.subLable.text = subTitle;
    [self.firstBtn setTitle:firstBtnTitle forState:UIControlStateNormal];
    [self.secBtn setTitle:secBtnTitle forState:UIControlStateNormal];
    [self.singleBtn setTitle:singleBtnTitle forState:UIControlStateNormal];

    self.singleBtn.hidden = hidden;

}
-(void)refreshUIWithTitle:(NSString *)title subTitle:(NSString *)subTitle firstBtnTitle:(NSString *)firstBtnTitle firstBtnTitleColor:(UIColor *)firstBtnTitleColor secBtnTitle:(NSString *)secBtnTitle secBtnTitleColor:(UIColor *)secBtnTitleColor singleBtnHidden:(BOOL)hidden singleBtnTitle:(NSString*)singleBtnTitle singleBtnTitleColor:(UIColor *)singleBtnTitleColor{
    self.titlelabel.text = title;
    self.subLable.text = subTitle;
    [self.firstBtn setTitle:firstBtnTitle forState:UIControlStateNormal];
    [self.firstBtn setTitleColor:firstBtnTitleColor forState:UIControlStateNormal];
    [self.secBtn setTitle:secBtnTitle forState:UIControlStateNormal];
    [self.secBtn setTitleColor:secBtnTitleColor forState:UIControlStateNormal];

    [self.singleBtn setTitle:singleBtnTitle forState:UIControlStateNormal];
    [self.singleBtn setTitleColor:singleBtnTitleColor forState:UIControlStateNormal];

    
    self.singleBtn.hidden = hidden;
    
    
}
-(void)refreshUIWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont*)titleFont  titleAliment:(NSTextAlignment)titleAliment subTitle:(NSString *)subTitle  subTitleColor:(UIColor *)subTitleColor subTitleFont:(UIFont*)subTitleFont  subTitleAliment:(NSTextAlignment)subTitleAliment firstBtnTitle:(NSString *)firstBtnTitle firstBtnTitleColor:(UIColor *)firstBtnTitleColor secBtnTitle:(NSString *)secBtnTitle secBtnTitleColor:(UIColor *)secBtnTitleColor singleBtnHidden:(BOOL)hidden singleBtnTitle:(NSString*)singleBtnTitle singleBtnTitleColor:(UIColor *)singleBtnTitleColor{
    self.titlelabel.text = title;
    self.titlelabel.textColor = titleColor;
    self.titlelabel.font = titleFont;
    self.titlelabel.textAlignment = titleAliment;
    self.subLable.text = subTitle;
    self.subLable.textColor = subTitleColor;
    self.subLable.font = subTitleFont;
    self.subLable.textAlignment = subTitleAliment;
    [self.firstBtn setTitle:firstBtnTitle forState:UIControlStateNormal];
    [self.firstBtn setTitleColor:firstBtnTitleColor forState:UIControlStateNormal];
    [self.secBtn setTitle:secBtnTitle forState:UIControlStateNormal];
    [self.secBtn setTitleColor:secBtnTitleColor forState:UIControlStateNormal];
    
    [self.singleBtn setTitle:singleBtnTitle forState:UIControlStateNormal];
    [self.singleBtn setTitleColor:singleBtnTitleColor forState:UIControlStateNormal];
    
    
    self.singleBtn.hidden = hidden;

}

-(void)refreshUIWithAttributeTitle:(NSAttributedString *)attributeTitle titleColor:(UIColor *)titleColor titleFont:(UIFont*)titleFont  titleAliment:(NSTextAlignment)titleAliment attributeSubTitle:(NSAttributedString *)attributeSubTitle  subTitleColor:(UIColor *)subTitleColor subTitleFont:(UIFont*)subTitleFont  subTitleAliment:(NSTextAlignment)subTitleAliment firstBtnTitle:(NSString *)firstBtnTitle firstBtnTitleColor:(UIColor *)firstBtnTitleColor secBtnTitle:(NSString *)secBtnTitle secBtnTitleColor:(UIColor *)secBtnTitleColor singleBtnHidden:(BOOL)hidden singleBtnTitle:(NSString*)singleBtnTitle singleBtnTitleColor:(UIColor *)singleBtnTitleColor{
    self.titlelabel.attributedText = attributeTitle;
    self.titlelabel.textColor = titleColor;
    self.titlelabel.font = titleFont;
    self.titlelabel.textAlignment = titleAliment;
    self.subLable.attributedText = attributeSubTitle;
    self.subLable.textColor = subTitleColor;
    self.subLable.font = subTitleFont;
    self.subLable.textAlignment = subTitleAliment;
    [self.firstBtn setTitle:firstBtnTitle forState:UIControlStateNormal];
    [self.firstBtn setTitleColor:firstBtnTitleColor forState:UIControlStateNormal];
    [self.secBtn setTitle:secBtnTitle forState:UIControlStateNormal];
    [self.secBtn setTitleColor:secBtnTitleColor forState:UIControlStateNormal];
    
    [self.singleBtn setTitle:singleBtnTitle forState:UIControlStateNormal];
    [self.singleBtn setTitleColor:singleBtnTitleColor forState:UIControlStateNormal];
    
    
    self.singleBtn.hidden = hidden;
    
    //文本混合时 有中文数字 这样设置 不然排列会有问题
    self.titlelabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.subLable.lineBreakMode = NSLineBreakByCharWrapping;

    
}

- (void)tap{
    if (self.CustomAlertViewBlock) {
        self.CustomAlertViewBlock(4,nil);
    }
}
@end
