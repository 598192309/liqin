//
//  LorginViewController.m
//  RabiBird
//
//  Created by Lqq on 16/8/9.
//  Copyright © 2016年 Lq. All rights reserved.
//  登录界面

#import "LorginViewController.h"
#import "LorginApi.h"
#import "AppDelegate.h"
#import "LorginModel.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "CommonBtn.h"
#import "CommonApi.h"
#import "CommonModel.h"



@interface LorginViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UITextField *accoutTextF;
@property (nonatomic,strong)UITextField *tuxingTF;
@property (nonatomic,strong)UIImageView *tuxingImageView;
@property (nonatomic,strong)UITextField *codeTF;
@end

@implementation LorginViewController
#pragma mark - 重写
-(void)backClick:(UIButton*)button{

    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark -  生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lorginSuccess) name:KNotification_RegisterSuccess object:nil];
    [self requestTuxing:self.tuxingImageView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)dealloc{
    LQLog(@"dealloc -- %@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark -  ui
- (void)configUI{
    //导航栏
    [self addNavigationView];
    self.navigationTextLabel.text = lqLocalized(@"会下款", nil);
    [self.navigationBackButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];

    [self.navigationRightBtn setTitle:lqLocalized(@"联系客服", nil) forState:UIControlStateNormal];


    [self.view addSubview:self.customTableView];
    __weak __typeof(self) weakSelf = self;
    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(NavMaxY);
    }];
    //用masonry设置 tableview的header footer  先包裹一次 才好设置  不然有错误
    UIView *tableHeaderView = [[UIView alloc] init];
    [tableHeaderView addSubview:self.header];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    //    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = Main_Screen_Height - 100;
    
}
#pragma mark - act
- (void)confirmBtnClick:(UIButton *)sender{
    [LSVProgressHUD showGIFImage];
    __weak __typeof(self) weakSelf = self;
    sender.userInteractionEnabled = NO;
    [LorginApi loginWithMobile:self.accoutTextF.text code:self.codeTF.text success:^(LorginModel *loginItem, NSString *msg) {
        [CommonApi requestCommonInfoSuccess:^(NSString *msg, NSInteger status, CommonInfoItem *commonInfoItem) {
            [LSVProgressHUD dismiss];
            sender.userInteractionEnabled = YES;
            NOTIFY_POST(kUserSignIn);
            [weakSelf dismissViewControllerAnimated:YES completion:nil];

        } error:^(NSError *error, id resultObject) {
            
        }];
        

    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        sender.userInteractionEnabled = YES;
        
    }];

}


- (void)lorginSuccess{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//获取验证码
- (void)codeBtnClick:(UIButton *)sender{
    [LSVProgressHUD showGIFImage];
    __weak __typeof(self) weakSelf = self;
    sender.userInteractionEnabled = YES;
    [LorginApi requsteLoginCodeWithMoblie:self.accoutTextF.text captcha:self.tuxingTF.text success:^(NSString *msg) {
        [sender startWithTime:60 title:NSLocalizedString(@"重发验证码", nil) titleColor:[UIColor colorWithHexString:@"#FFC600"] countDownTitle:NSLocalizedString(@"s后重发", nil) countDownTitleColor:TitleGrayColor mainColor:[UIColor clearColor] countColor:[UIColor whiteColor]];
        [LSVProgressHUD showInfoWithStatus:msg];

    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
    }];
    
}

- (void)tuxingTap:(UITapGestureRecognizer *)gest{
    [self requestTuxing:self.tuxingImageView];
}
#pragma mark - 网络请求
//获取图形验证码
- (void)requestTuxing:(UIImageView *)imageV{
    
    [LSVProgressHUD showGIFImage];
    [CommonApi requestTuxingSuccess:^(NSString *captcha) {
        [LSVProgressHUD dismiss];
        [imageV sd_setImageWithURL:[NSURL URLWithString:captcha]];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
    }];
}

//登录

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Adaptor_Value(65);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - setter
- (void)setShowMsg:(NSString *)showMsg{
    [self showHUD:showMsg];
}
#pragma mark - lazy
- (UITableView *)customTableView{
    if (!_customTableView) {
        _customTableView = [[UITableView alloc] init];
        _customTableView.backgroundColor = BackGroundColor;
        _customTableView.dataSource = self;
        _customTableView.delegate = self;
        _customTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _customTableView.showsVerticalScrollIndicator = NO;
        _customTableView.showsHorizontalScrollIndicator = NO;
        
    }
    return _customTableView;
}

- (UIView *)header{
    if (_header == nil) {
        _header = [UIView new];
        __weak __typeof(self) weakSelf = self;

        UIView *topTipView = [UIView new];
        [_header addSubview:topTipView];
        [topTipView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.width.mas_equalTo(Adaptor_Value(100));
            make.height.mas_equalTo(Adaptor_Value(35));
            make.top.mas_equalTo(Adaptor_Value(25));
        }];
//        添加左边两个圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, Adaptor_Value(100), Adaptor_Value(35)) byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(35 * 0.5, 35 * 0.5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = CGRectMake(0, 0, Adaptor_Value(100), Adaptor_Value(35));
        maskLayer.path = maskPath.CGPath;
        topTipView.layer.mask = maskLayer;

        UIView *topTipViewBackView = [UIView new];
        topTipViewBackView.backgroundColor = [UIColor greenColor];
        [topTipView addSubview:topTipViewBackView];
        [topTipViewBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(topTipView);
        }];
        /**
         *  1.通过CAGradientLayer 设置渐变的背景。
         */
        CAGradientLayer *layer1 = [CAGradientLayer new];
        //colors存放渐变的颜色的数组
        NSArray *colorArray = @[(__bridge id)[UIColor colorWithHexString:@"5bc4c9"].CGColor,(__bridge id)[UIColor colorWithHexString:@"43aaee"].CGColor];
        layer1.colors=colorArray;
        layer1.startPoint = CGPointMake(0.0, 0.0);
        layer1.endPoint = CGPointMake(0.6, 0);
        layer1.frame = CGRectMake(0, 0, Adaptor_Value(100), Adaptor_Value(35));
        [topTipViewBackView.layer insertSublayer:layer1 atIndex:0];

        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        imageV.backgroundColor = BlueJianbian2;
        [topTipView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(Adaptor_Value(20));
            make.centerY.mas_equalTo(topTipView);
            make.left.mas_equalTo(Adaptor_Value(15));
        }];
        UIView *topTipViewLine = [UIView new];
        topTipViewLine.backgroundColor = [UIColor whiteColor];
        [topTipView addSubview:topTipViewLine];
        [topTipViewLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(20));
            make.width.mas_equalTo(kOnePX);
            make.left.mas_equalTo(imageV.mas_right).offset(Adaptor_Value(2));
            make.centerY.mas_equalTo(topTipView);
        }];
        UILabel *topTipViewLable = [UILabel lableWithText:lqLocalized(@"登录", nil) textColor:[UIColor whiteColor] fontSize:RegularFONT(20) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [topTipView addSubview:topTipViewLable];
        [topTipViewLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(topTipView.mas_right).offset(-Adaptor_Value(20));
            make.centerY.mas_equalTo(topTipView);
        }];
        
        UIImageView *imageV2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginIcon"]];
        [topTipView addSubview:imageV2];
        [imageV2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(topTipView);
            
        }];
    
        
        
        UIView *textFBackView = [UIView new];
        textFBackView.backgroundColor = [UIColor whiteColor];
        [_header addSubview:textFBackView];
        [textFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.right.mas_equalTo(weakSelf.header).offset(-Adaptor_Value(10));
            make.top.mas_equalTo(topTipView.mas_bottom).offset(Adaptor_Value(20));
            make.height.mas_equalTo(Adaptor_Value(60));
        }];
        ViewRadius(textFBackView, 5);
        textFBackView.layer.shadowColor = YinYingColor.CGColor;
        textFBackView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        textFBackView.layer.shadowOpacity = 0.5f;
        textFBackView.layer.shadowRadius = 5;
        textFBackView.layer.masksToBounds = NO;
        
        _accoutTextF = [[UITextField alloc] init];
        [textFBackView addSubview:_accoutTextF];
        [_accoutTextF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(20));
            make.top.bottom.right.mas_equalTo(textFBackView);
        }];
        _accoutTextF.placeholder = lqLocalized(@"请输入手机号码", nil);
        
        _accoutTextF.keyboardType = UIKeyboardTypeNumberPad;
        
        UIView *tuxingtextFBackView = [UIView new];
        tuxingtextFBackView.backgroundColor = [UIColor whiteColor];
        [_header addSubview:tuxingtextFBackView];
        [tuxingtextFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.right.mas_equalTo(weakSelf.header).offset(-Adaptor_Value(10));
            make.top.mas_equalTo(textFBackView.mas_bottom).offset(Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(60));
        }];
        ViewRadius(tuxingtextFBackView, 5);
        tuxingtextFBackView.layer.shadowColor = YinYingColor.CGColor;
        tuxingtextFBackView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        tuxingtextFBackView.layer.shadowOpacity = 0.5f;
        tuxingtextFBackView.layer.shadowRadius = 5;
        tuxingtextFBackView.layer.masksToBounds = NO;
        
        _tuxingTF = [[UITextField alloc] init];
        [tuxingtextFBackView addSubview:_tuxingTF];
        [_tuxingTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(20));
            make.top.bottom.right.mas_equalTo(tuxingtextFBackView);
        }];
        _tuxingTF.placeholder = lqLocalized(@"请输入右侧数字", nil);
        
        _tuxingImageView = [UIImageView new];
        _tuxingImageView.backgroundColor = BlueJianbian2;
        [tuxingtextFBackView addSubview:_tuxingImageView];
        [_tuxingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(tuxingtextFBackView).offset(-Adaptor_Value(5));
            make.top.mas_equalTo(Adaptor_Value(5));
            make.bottom.mas_equalTo(tuxingtextFBackView).offset(-Adaptor_Value(5));
            make.width.mas_equalTo(Adaptor_Value(100));
        }];
        _tuxingImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tuxingTap:)];
        [_tuxingImageView addGestureRecognizer:tap];
        
        UIView *codetextFBackView = [UIView new];
        codetextFBackView.backgroundColor = [UIColor whiteColor];
        [_header addSubview:codetextFBackView];
        [codetextFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.right.mas_equalTo(weakSelf.header).offset(-Adaptor_Value(10));
            make.top.mas_equalTo(tuxingtextFBackView.mas_bottom).offset(Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(60));
        }];
        ViewRadius(codetextFBackView, 5);
        codetextFBackView.layer.shadowColor = YinYingColor.CGColor;
        codetextFBackView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        codetextFBackView.layer.shadowOpacity = 0.5f;
        codetextFBackView.layer.shadowRadius = 5;
        codetextFBackView.layer.masksToBounds = NO;
        
        _codeTF = [[UITextField alloc] init];
        [codetextFBackView addSubview:_codeTF];
        [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(20));
            make.top.bottom.right.mas_equalTo(codetextFBackView);
        }];
        _codeTF.placeholder = lqLocalized(@"请输入短信验证码", nil);
        
        UIButton *codeBtn = [[UIButton alloc] init];
        
        [codeBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        codeBtn.titleLabel.font = RegularFONT(15);
        [codeBtn setTitle:lqLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [codeBtn setTitleColor:[UIColor colorWithHexString:@"a4a4a4"] forState:UIControlStateNormal];
        [codetextFBackView addSubview:codeBtn];
        [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(50));
            make.right.mas_equalTo(codetextFBackView).offset(-Adaptor_Value(10));
            make.centerY.mas_equalTo(codetextFBackView);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor colorWithHexString:@"a4a4a4"];
        [codetextFBackView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(20));
            make.width.mas_equalTo(kOnePX);
            make.right.mas_equalTo(codeBtn.mas_left).offset(Adaptor_Value(-5));
            make.centerY.mas_equalTo(codetextFBackView);
        }];

        
        CommonBtn *confirmBtn = [[CommonBtn alloc] init];
        [confirmBtn setTitle:lqLocalized(@"立即登录", nil) forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_header addSubview:confirmBtn];
        confirmBtn.CommonBtnEndLongPressBlock = ^(UIButton *sender){
            [weakSelf confirmBtnClick:sender];
        };
        [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(10));
            make.right.mas_equalTo(weakSelf.header).offset(-Adaptor_Value(10));
            make.top.mas_equalTo(codetextFBackView.mas_bottom).offset(Adaptor_Value(50));
            make.height.mas_equalTo(Adaptor_Value(60));
        }];
        UIView *btnShadow = [UIView new];
        btnShadow.backgroundColor = [UIColor whiteColor];
        [_header insertSubview:btnShadow belowSubview:confirmBtn];
        [btnShadow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(confirmBtn);
            make.width.mas_equalTo(confirmBtn).offset(-5);
            make.centerX.mas_equalTo(confirmBtn);
        }];
        //按钮阴影
        btnShadow.layer.shadowColor = [UIColor colorWithHexString:@"#ff0000" alpha:0.4].CGColor;
        btnShadow.layer.shadowOpacity = 0.5f;
        btnShadow.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);//和下方 配合偏移
        btnShadow.layer.shadowRadius = 10;
        btnShadow.layer.masksToBounds = NO;
        
        UILabel *zhuceLabel = [UILabel new];
        zhuceLabel.font = RegularFONT(12);
        zhuceLabel.textColor = TitleGrayColor;
        zhuceLabel.text = lqLocalized(@"新老用户可直接用手机号登录", nil);
        [_header addSubview:zhuceLabel];
        [zhuceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.header);
            make.bottom.mas_equalTo(confirmBtn.mas_bottom).offset(Adaptor_Value(30));
        }];
 

        
        
    }
    return _header;
}

@end



