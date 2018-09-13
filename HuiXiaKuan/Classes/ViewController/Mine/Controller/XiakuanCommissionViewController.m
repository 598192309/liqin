//
//  XiakuanCommissionViewController.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/11.
//  Copyright © 2018年 Lq. All rights reserved.
//  支付下款佣金界面
#import "XiakuanCommissionViewController.h"
#import "XiakuanCommissionCustomView.h"
#import "HomeApi.h"
#import "HomeModel.h"
#import "BankViewController.h"
#import "AccountApi.h"
#import "Account.h"

@interface XiakuanCommissionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView  *customTableView;
@property (nonatomic,strong)XiakuanCommissionCustomView *xiakuanCommissionCustomView;
@property (nonatomic,strong)XiakuanCommissionItem *xiakuanCommissionItem;
@end

@implementation XiakuanCommissionViewController
#pragma mark - setter
- (void)setLoanID:(NSString *)loanID{
    _loanID = loanID;
}
- (void)setCommission_token:(NSString *)commission_token{
    _commission_token = commission_token;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.notFirstAppear) {
        [self requestData];
    }
}
#pragma mark - ui
- (void)configUI{
    [self.view addSubview:self.customTableView];
    __weak __typeof(self) weakSelf = self;
    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(NavMaxY);
    }];
    self.customTableView.contentInset = UIEdgeInsetsMake(0, 0, TabbarH, 0);
    UIView *tableHeaderView = [[UIView alloc] init];
    [tableHeaderView addSubview:self.xiakuanCommissionCustomView];
    [self.xiakuanCommissionCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;
    
    [self xiakuanCommissionCustomViewAct];
    
    //导航栏
    [self addNavigationView];
    self.navigationTextLabel.text = lqLocalized(@"会下款", nil);
    [self.navigationRightBtn setTitle:lqLocalized(@"联系客服", nil) forState:UIControlStateNormal];
}

#pragma mark - act
- (void)xiakuanCommissionCustomViewAct{
    //点击确认按钮
    __weak __typeof(self) weakSelf = self;
    self.xiakuanCommissionCustomView.xiakuanCommissionCustomViewConfirmBtnClickBlock = ^(UIButton *sender, NSDictionary *dict) {
        if ([[sender titleForState:UIControlStateNormal] isEqualToString:@"立即支付"]) {
            [weakSelf gopay:sender];
        }else{
            //返回我的账号
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }
    };
}

- (void)refreshHeaderViewHeight{
    UIView *tableHeaderView = [[UIView alloc] init];
    [tableHeaderView addSubview:self.xiakuanCommissionCustomView];
    [self.xiakuanCommissionCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = H;
    self.customTableView.tableHeaderView.lq_height = H;
    
    self.customTableView.tableHeaderView = tableHeaderView;
    
    
}

#pragma mark - net
- (void)requestData{
    [LSVProgressHUD showGIFImage];
    __weak __typeof(self) weakSelf = self;
    [AccountApi requestXiakuanCommissionInfoWithLoan_id:self.loanID commission_token:self.commission_token Success:^(XiakuanCommissionItem *xiakuanCommissionItem, NSString *msg, NSInteger status) {
        weakSelf.xiakuanCommissionItem = xiakuanCommissionItem;
        [LSVProgressHUD dismiss];
        [weakSelf.xiakuanCommissionCustomView configUIWithItem:xiakuanCommissionItem finishBlock:^{
            [weakSelf refreshHeaderViewHeight];
        }];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
    }];
}
//去支付
- (void)gopay:(UIButton *)sender{
    [LSVProgressHUD showGIFImage];
    //获取支付信息
    __weak __typeof(self) weakSelf = self;
    [HomeApi requestPayTypesSuccess:^(NSArray *paytypeItemArr, NSString *msg, NSInteger status) {
        sender.userInteractionEnabled = YES;
        //暂时只考虑银行卡 所以先这样写
        PaytypeItem *item = [paytypeItemArr safeObjectAtIndex:0];
        if ([item.code isEqualToString:@"joinpay"]) {
            BankViewController *vc = [[BankViewController alloc] init];
            vc.moneyStr = weakSelf.xiakuanCommissionItem.commission;
            vc.loan_id = weakSelf.loanID;
            vc.payment_code = item.code;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            [LSVProgressHUD dismiss];
        }else{
            [LSVProgressHUD showInfoWithStatus:@"本版本不支持此支付方式，请更新最新版本"];
        }
    } error:^(NSError *error, id resultObject) {
        sender.userInteractionEnabled = YES;
        [LSVProgressHUD showError:error];
        
    }];
    }
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.01;
}
#pragma  mark - lazy
- (UITableView *)customTableView
{
    if (_customTableView == nil) {
        _customTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,LQScreemW, LQScreemH) style:UITableViewStylePlain];
        _customTableView.delegate = self;
        _customTableView.dataSource = self;
        _customTableView.showsVerticalScrollIndicator = NO;
        _customTableView.showsHorizontalScrollIndicator = NO;
        _customTableView.backgroundColor = BackGroundColor;
        _customTableView.separatorColor = BackGroundColor;
        
    }
    return _customTableView;
}
- (XiakuanCommissionCustomView *)xiakuanCommissionCustomView{
    if (!_xiakuanCommissionCustomView) {
        _xiakuanCommissionCustomView = [[XiakuanCommissionCustomView alloc] init];
        
    }
    return _xiakuanCommissionCustomView;
}
@end
