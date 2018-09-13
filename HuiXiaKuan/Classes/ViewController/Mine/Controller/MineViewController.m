//
//  MineViewController.m
//  IUang
////我的账户
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "MineViewController.h"
#import "Account.h"
#import "AccountApi.h"
#import "MineCustomView.h"
#import "MineLoanRecordCell.h"
#import "LoanConfirmationViewController.h"
#import "PersonalLoanInfoViewController.h"
#import "HomeApi.h"
#import "HomeModel.h"
#import "BottomAlertView.h"
#import "XiakuanCommissionViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView  *customTableView;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)AccountHomeItem *accountHomeItem;
@property (nonatomic,strong)NSMutableArray *loanRecordArr;
@property (nonatomic,strong)NSMutableArray *historyloanRecordArr;//历史数据 不包括当前的贷款

@property (nonatomic,strong)MineCustomView *mineCustomView;

@property (nonatomic,strong)BottomAlertView *dealView;
@property(nonatomic,strong)UIView *coverView;//背后透明view  以防别处可点击

@end

@implementation MineViewController
#pragma mark - 重写

#pragma mark - 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    _loanRecordArr = [NSMutableArray array];
    _historyloanRecordArr = [NSMutableArray array];

    [self configUI];
    //监听用户登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI) name:kUserSignIn object:nil];

    
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
    [tableHeaderView addSubview:self.mineCustomView];
    [self.mineCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;
    
    [self mineCustomViewAct];
    
    //导航栏
    [self addNavigationView];
    self.navigationTextLabel.text = lqLocalized(@"会下款", nil);
    [self.navigationRightBtn setTitle:lqLocalized(@"联系客服", nil) forState:UIControlStateNormal];
    self.navigationBackButton.hidden = YES;
}
- (void)refreshUI{
    NSString *str = RI.mobile;
    self.mineCustomView.accountLabel.text = RI.mobile;
    [self requestData];

}
#pragma mark - act
- (void)mineCustomViewAct{
    __weak __typeof(self) weakSelf = self;

    self.mineCustomView.mineCustomViewConfirmBtnClickBlock = ^(UIButton *sender, NSDictionary *dict) {
        NSString *title = [sender titleForState:UIControlStateNormal];
        if ([title isEqualToString:lqLocalized(@"前往支付并操作下款",nil)]) {
            LoanConfirmationViewController *vc = [[LoanConfirmationViewController alloc] init];
            vc.quto = [NSString stringWithFormat:@"%ld",RI.quota];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else if ([title isEqualToString:lqLocalized(@"开始VIP专属服务",nil)]) {
//            PersonalLoanInfoViewController *vc = [[PersonalLoanInfoViewController alloc] init];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
            if ([weakSelf canOpenQQ]) {
                LoanRecordInfoItem *item = [weakSelf.loanRecordArr safeObjectAtIndex:0];

                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",item.saler_im_link]];
                UIApplication *application = [UIApplication sharedApplication];
                if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                    [application openURL:url options:@{} completionHandler:nil];
                }else{
                    [application openURL:url];
                }
            }else{
                [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"未安装QQ", nil)];
            }        }else if ([title isEqualToString:lqLocalized(@"支付下款佣金",nil)] || [title isEqualToString:lqLocalized(@"支付剩余下款佣金",nil)]) {
            XiakuanCommissionViewController *vc = [[XiakuanCommissionViewController alloc] init];
            LoanRecordInfoItem *item = [weakSelf.loanRecordArr safeObjectAtIndex:0];

            vc.commission_token = item.commission_token;
            vc.loanID = [NSString stringWithFormat:@"%ld",item.ID];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else if ([title isEqualToString:lqLocalized(@"立即下款",nil)]) {
            //进入首页
            AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
            MainTabBarController *vc =(MainTabBarController *)del.window.rootViewController;
            vc.selectedIndex = 0;

        }
    };
    //查看服务协议
    self.mineCustomView.mineCustomViewCheckContractBlock = ^(UILabel *tapLable, NSDictionary *dict) {
        if (![tapLable.text isEqualToString:lqLocalized(@"点击查看", nil)]) {
            return ;
        }
        [weakSelf.view addSubview:weakSelf.dealView];
        weakSelf.dealView.bottomAlertViewCloseBlock = ^{//关闭合同
            [weakSelf shutDealView];
        };
        LoanRecordInfoItem *item = [weakSelf.loanRecordArr safeObjectAtIndex:0];

        [weakSelf openDealViewWithId:[NSString stringWithFormat:@"%ld",(long)item.contract_id] apply_loan_id:[NSString stringWithFormat:@"%ld",(long)item.ID]  borrow_amount:item.title];

//        [weakSelf requestContract];
    };
    
    //完善个人信息
    self.mineCustomView.mineCustomViewCheckConsummateInfoBlock = ^(UILabel *tapLable, NSDictionary *dict) {
        PersonalLoanInfoViewController *vc = [[PersonalLoanInfoViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}
- (void)openDealViewWithId:(NSString *)ID  apply_loan_id:(NSString *)apply_loan_id borrow_amount:(NSString *)borrow_amount{
    __weak __typeof(self) weakSelf = self;
    
    [LSVProgressHUD showGIFImage];
//[NSString stringWithFormat:@"%ld",(long)item.ID] item.title
    [HomeApi requestLoanContractWithID:ID borrow_amount:borrow_amount apply_loan_id:apply_loan_id Success:^(ContractItem *contractItem, NSString *msg, NSInteger status) {
        [LSVProgressHUD dismiss];
        [weakSelf.view insertSubview:self.coverView belowSubview:self.dealView];
        [weakSelf.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.view);
        }];
        CGFloat H = [weakSelf.dealView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        weakSelf.dealView.frame = CGRectMake(0, LQScreemH , LQScreemW, H);
        weakSelf.dealView.htmlStr = contractItem.content;
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.dealView.lq_y =  LQScreemH - H;
        }];
//        weakSelf.view.lq_height = LQScreemH + H;
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        
    }];
    
    
}
- (void)shutDealView{
    __weak __typeof(self) weakSelf = self;
    [weakSelf.coverView removeFromSuperview];
    weakSelf.coverView = nil;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.dealView.lq_y = LQScreemH;
    } completion:^(BOOL finished) {
        [weakSelf.dealView removeFromSuperview];
        weakSelf.dealView = nil;
        
    }];
    
}


- (BOOL)canOpenQQ{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
}
#pragma mark - net
- (void)requestData{
    __weak __typeof(self) weakSelf = self;
    [AccountApi requestLoanRecordWithPage:@"1" Success:^(AccountHomeItem *accountHomeItem, NSString *msg, NSInteger status) {
        weakSelf.loanRecordArr = [NSMutableArray arrayWithArray:accountHomeItem.list];
        //处理掉当前贷款
        for (LoanRecordInfoItem *item in weakSelf.loanRecordArr) {
            if (item.is_current) {
            }else{
                [weakSelf.historyloanRecordArr addObject:item];
            }
        }
        weakSelf.page = accountHomeItem.pager.page + 1;
        if (weakSelf.loanRecordArr .count >= 10) {
            [weakSelf.customTableView addFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
        }
        
        [weakSelf.mineCustomView configUIWithItem:accountHomeItem finishi:^{
            //根据数据改变高度
            CGFloat H = [weakSelf.mineCustomView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            self.customTableView.tableHeaderView.lq_height = H;


        }];
        [weakSelf.customTableView endHeaderRefreshing];
        
        [weakSelf.customTableView reloadData];

    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.customTableView endHeaderRefreshing];

    }];
}

- (void)requestMoreData{
    
    __weak __typeof(self) weakSelf = self;
    
    [AccountApi requestLoanRecordWithPage:[NSString stringWithFormat:@"%ld",self.page] Success:^(AccountHomeItem *accountHomeItem, NSString *msg, NSInteger status) {
        [weakSelf.loanRecordArr addObjectsFromArray:accountHomeItem.list];
        weakSelf.page = accountHomeItem.pager.page + 1;
        [weakSelf.customTableView endFooterRefreshing];
        if (accountHomeItem.list.count < 10) {
            [weakSelf.customTableView endRefreshingWithNoMoreData];
        }
        [weakSelf.mineCustomView configUIWithItem:accountHomeItem finishi:^{
            
        }];
        [weakSelf.customTableView reloadData];
        
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.customTableView endHeaderRefreshing];
        
    }];
    
    
}

- (void)requestContract{
    __weak __typeof(self) weakSelf = self;
    LoanRecordInfoItem *item = [self.loanRecordArr safeObjectAtIndex:0];
    [LSVProgressHUD showGIFImage];
    [HomeApi requestLoanContractWithID:[NSString stringWithFormat:@"%ld",(long)item.ID] borrow_amount:item.title apply_loan_id:@"" Success:^(ContractItem *contractItem, NSString *msg, NSInteger status) {
        [LSVProgressHUD dismiss];
        
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        
    }];
    
}
#pragma mark -  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning ceshi
//    return self.loanRecordArr.count;

    return self.historyloanRecordArr.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//#warning ceshi
//    LoanRecordInfoItem *item = [self.loanRecordArr safeObjectAtIndex:indexPath.row];

    
    LoanRecordInfoItem *item = [self.historyloanRecordArr safeObjectAtIndex:indexPath.row];

    MineLoanRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineLoanRecordCell class])];
    __weak __typeof(self) weakSelf = self;
    cell.mineLoanRecordCellCheckContractBlock = ^(UILabel *tapLable, NSDictionary *dict) {
        [weakSelf.view addSubview:weakSelf.dealView];
        weakSelf.dealView.bottomAlertViewCloseBlock = ^{//关闭合同
            [weakSelf shutDealView];
        };
        //#warning ceshi
//        LoanRecordInfoItem *item1 = [weakSelf.loanRecordArr safeObjectAtIndex:indexPath.row];
        LoanRecordInfoItem *item1 = [weakSelf.historyloanRecordArr safeObjectAtIndex:indexPath.row];
        //查看服务协议
        [weakSelf openDealViewWithId:[NSString stringWithFormat:@"%ld",(long)item1.contract_id] apply_loan_id:[NSString stringWithFormat:@"%ld",(long)item.ID] borrow_amount:item1.title];

    };
    [cell configUIWithItem:item];
    return cell;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineLoanRecordCell *cell = (MineLoanRecordCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    CGFloat H = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return H;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Adaptor_Value(25);
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *secHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Adaptor_Value(25))];
    
    secHeader.backgroundColor = BackGroundColor;
    UILabel *lable = [[UILabel alloc] init];
    
    [secHeader addSubview:lable];
    lable.textColor = TitleBlackColor;
    lable.font = RegularFONT(15);
    if (self.historyloanRecordArr.count > 0) {
        lable.text = lqLocalized(@"历史贷款", nil);
    }else{
        lable.text = nil;
    }
    [lable sizeToFit];
    lable.lq_x = Adaptor_Value(25);
    
    
    return secHeader;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
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
        [_customTableView registerClass:[MineLoanRecordCell class] forCellReuseIdentifier:NSStringFromClass([MineLoanRecordCell class])];
        
        //下拉刷新
        [_customTableView addHeaderWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        [_customTableView beginHeaderRefreshing];
        _customTableView.tableFooterView = [UIView new];
        
    }
    return _customTableView;
}

- (MineCustomView *)mineCustomView{
    if (!_mineCustomView) {
        _mineCustomView = [[MineCustomView alloc] init];
        
    }
    return _mineCustomView;
}
- (BottomAlertView *)dealView{
    if (!_dealView) {
        _dealView = [[BottomAlertView alloc] init];
        
    }
    return _dealView;
}
- (UIView *)coverView{
    if (!_coverView) {
        _coverView = [UIView new];
        _coverView.backgroundColor = [UIColor clearColor];
    }
    return _coverView;
}
@end
