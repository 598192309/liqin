//
//  BottomAlertView.m
//  RabiBird
//
//  Created by Lqq on 2018/7/25.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "BottomAlertView.h"
@interface BottomAlertView()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
@property (nonatomic,strong)UIView *contentV;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *closeBtn;
@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UIWebView *webView;

@end
@implementation BottomAlertView
#pragma mark - 生命周期
-(instancetype)init{
    if (self = [super init]) {
        [self configUI];
        [self layoutSub];
        self.backgroundColor = [UIColor clearColor];

        self.layer.shadowColor = [UIColor colorWithHexString:@"1d1d1d" alpha:0.3].CGColor;
        self.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        self.layer.shadowOpacity = 0.5f;
        self.layer.shadowRadius = 5;
        self.layer.masksToBounds = NO;
        [LSVProgressHUD show];


        
    }
    return self;
}
#pragma mark - ui
-(void)configUI{
    [self addSubview:self.contentV];
    [self.contentV addSubview:self.titleLabel];
    [self.contentV addSubview:self.closeBtn];
    [self.contentV addSubview:self.line];
    [self.contentV addSubview:self.customTableView];


    self.customTableView.tableHeaderView = self.header;
    CGFloat H = [self.header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.customTableView.tableHeaderView.lq_height = Adaptor_Value(320);
    
}
- (void)layoutSub{
    __weak __typeof(self) weakSelf = self;
    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.contentV);
        make.top.mas_equalTo(Adaptor_Value(10));
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.titleLabel);
        make.right.mas_equalTo(weakSelf.contentV).offset(-Adaptor_Value(12.5));
        make.width.height.mas_equalTo(Adaptor_Value(20));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Adaptor_Value(12.5));
        make.right.mas_equalTo(weakSelf.contentV).offset(-Adaptor_Value(12.5));
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(Adaptor_Value(10));
        make.height.mas_equalTo(kOnePX);
    }];
    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.line.mas_bottom).offset(Adaptor_Value(10));
        make.left.mas_equalTo(Adaptor_Value(20));
        make.right.mas_equalTo(weakSelf.contentV).offset(-Adaptor_Value(20));
        make.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(Adaptor_Value(320));
    }];

}
#pragma mark - set
- (void)setHtmlStr:(NSString *)htmlStr{
    _htmlStr = htmlStr;
    [self.webView loadHTMLString:htmlStr baseURL:nil];
    

}
- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    self.titleLabel.text = titleStr;
}
#pragma mark - act
-(void)closeBtnClick:(UIButton *)sender{
    if (self.bottomAlertViewCloseBlock) {
        self.bottomAlertViewCloseBlock();
    }
}
#pragma  mark - uitableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark -UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //    [AV showLoading:nil];
    LQLog(@"webView.URL => %@",webView.request.URL);
    NSLog(@"UserAgent = %@", [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]);
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [LSVProgressHUD dismiss];

    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [LSVProgressHUD dismiss];
    
}
#pragma  mark - lazy
- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [UIView new];
        ViewRadius(_contentV, 10);
        _contentV.backgroundColor = [UIColor whiteColor];

    }
    return _contentV;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = NSLocalizedString(@"会下款服务合同", nil) ;
        _titleLabel.textColor = TitleBlackColor;
        _titleLabel.font = [UIFont boldSystemFontOfSize:Adaptor_Value(15)];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}
-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton new];
        [_closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
    return _closeBtn;
}

-(UIView *)line{
    if (_line == nil) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor colorWithHexString:@"f0eff5"];
    }
    return _line;
}
- (UITableView *)customTableView
{
    if (_customTableView == nil) {
        _customTableView = [[UITableView alloc] init];
        _customTableView.delegate = self;
        _customTableView.dataSource = self;
        _customTableView.showsVerticalScrollIndicator = NO;
        _customTableView.showsHorizontalScrollIndicator = NO;
    }
    return _customTableView;
}
-(UIView *)header{
    if (!_header) {
        _header = [UIView new];
        _header.backgroundColor = [UIColor whiteColor];
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        [_header addSubview:_webView];
        __weak __typeof(self) weakSelf = self;
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.header);
            make.width.mas_equalTo(LQScreemW - Adaptor_Value(20) *2);
        }];
    }
    return _header;
}

@end
