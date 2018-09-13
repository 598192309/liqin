//
//  HomeViewController.m
//  IUang
//
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCustomView.h"
#import "HomeModel.h"
#import "HomeApi.h"
#import "CommonApi.h"
#import "LorginApi.h"
#import "LoanConfirmationViewController.h"
#import "LorginViewController.h"
#import "PersonalLoanInfoViewController.h"
#import "CeSuanViewController.h"
@interface HomeViewController()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *customTableView;

@property (nonatomic,strong)HomeCustomView *homeCustomView;
@property (nonatomic,strong)HomeDataItem *dataItem;
@end

@implementation HomeViewController
#pragma mark - 重写


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
    [self requesLoanList];
    [self requestCommon];
    
    //监听用户登录 退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI) name:kUserSignIn object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI) name:kUserSignOut object:nil];


}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.notFirstAppear) {
        [self requestCommon];
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
    UIView *tableHeaderView = [[UIView alloc] init];
    [tableHeaderView addSubview:self.homeCustomView];
    [self.homeCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;

    [self homeCustomViewAct];

    //导航栏
    [self addNavigationView];
    self.navigationTextLabel.text = lqLocalized(@"会下款", nil);
    [self.navigationRightBtn setTitle:lqLocalized(@"联系客服", nil) forState:UIControlStateNormal];

    self.navigationBackButton.hidden = YES;
}

- (void)refreshUI{
    __weak __typeof(self) weakSelf = self;
    [self.homeCustomView refreshUIWithIsLorgin:RI.is_logined finishBlock:^() {
        [weakSelf calculateHeight];
    }];
}

#pragma mark - act
- (void)homeCustomViewAct{
    //立即下款
    __weak __typeof(self) weakSelf = self;
    self.homeCustomView.homeCustomViewConfirmBtnClickBlock = ^(UIButton *sender, NSDictionary *dict) {
        NSString *mobile = [dict safeObjectForKey:@"mobile"];
        NSString *code = [dict safeObjectForKey:@"code"];
//#warning ceshi
//        PersonalLoanInfoViewController *vc = [[PersonalLoanInfoViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//        return ;
        if (!(mobile.length > 0)) {
            
            if (RI.quota == 0) {//进入额度测算
                CeSuanViewController *vc = [[CeSuanViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];

            }else if (RI.quota > 0 && RI.loanID > 0 && !RI.is_perfected) {
                PersonalLoanInfoViewController *vc = [[PersonalLoanInfoViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];

            }else if (RI.quota > 0  && RI.is_perfected) {
                //进入我的账户首页
                AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
                MainTabBarController *vc =(MainTabBarController *)del.window.rootViewController;
                vc.selectedIndex = 1;

            }else {
                //直接下款 进入流程
                LoanConfirmationViewController * vc = [[LoanConfirmationViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }

        }else{
            //登录
            [weakSelf loginWithMobile:mobile code:code sender:sender];
        }
    };
    //图形验证码
    self.homeCustomView.homeCustomViewTuxingImageVTapBlock = ^(UIImageView *imageV, NSDictionary *dict) {
        [weakSelf requestTuxing:imageV];
        [weakSelf calculateHeight];
    };

    //获取验证码
    self.homeCustomView.homeCustomViewCodeBtnClickBlock = ^(UIButton *sender, NSDictionary *dict) {
        NSString *mobile = [dict safeObjectForKey:@"mobile"];
        NSString *captcha = [dict safeObjectForKey:@"captcha"];
        [weakSelf requesCode:sender mobile:mobile captcha:captcha];
    };
    //重新获取动画数组
    self.homeCustomView.homeCustomViewReloadAnimateBlock = ^{
        [weakSelf requesLoanList];
    };
}

- (void)calculateHeight{
    CGFloat h = [self.homeCustomView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.customTableView.tableHeaderView.lq_height = h;
    [self.customTableView reloadData];

}
#pragma mark - net
- (void)requestData{
    __weak __typeof(self) weakSelf = self;
    [HomeApi requestHomeDataSuccess:^(HomeDataItem *homeDataItem, NSString *msg, NSInteger status) {
        [weakSelf.customTableView reloadData];
        weakSelf.dataItem = homeDataItem;
        [weakSelf.homeCustomView configUIWithItem:homeDataItem finishBlock:^{

        }];
        [weakSelf.customTableView endHeaderRefreshing];

    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.customTableView endHeaderRefreshing];

    }];
    
}

//获取贷款案例  动画
- (void)requesLoanList{
    __weak __typeof(self) weakSelf = self;
  
    [HomeApi requestLoanListSuccess:^(NSArray *loanListArr, NSString *msg, NSInteger status) {
        [weakSelf.homeCustomView setAnimationWithItemArr:loanListArr ];

    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];

    }];
}

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
//获取短信验证码
- (void)requesCode:(UIButton *)sender mobile:(NSString *)mobile captcha:(NSString *)captcha{
    [LSVProgressHUD showGIFImage];
    __weak __typeof(self) weakSelf = self;

    [LorginApi requsteLoginCodeWithMoblie:mobile captcha:captcha success:^(NSString *msg) {
        [LSVProgressHUD showInfoWithStatus:msg];
        [weakSelf.homeCustomView setCodeTFBackHidden:NO];
        [sender startWithTime:60 title:NSLocalizedString(@"获取验证码", nil) titleColor:TitleGrayColor countDownTitle:NSLocalizedString(@"s", nil) countDownTitleColor:TitleGrayColor mainColor:[UIColor clearColor] countColor:[UIColor whiteColor]];

    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
    }];
}
//登录
- (void)loginWithMobile:(NSString *)mobile code:(NSString *)code  sender:(UIButton *)sender{
    [LSVProgressHUD showGIFImage];
    __weak __typeof(self) weakSelf = self;
    sender.userInteractionEnabled = NO;
    [LorginApi loginWithMobile:mobile code:code success:^(LorginModel *loginItem, NSString *msg) {
        [LSVProgressHUD dismiss];
        [weakSelf.homeCustomView refreshUIWithIsLorgin:RI.is_logined finishBlock:^() {
            [weakSelf calculateHeight];
        }];
        sender.userInteractionEnabled = YES;
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        sender.userInteractionEnabled = YES;

    }];
}

//通用信息
- (void)requestCommon{
    [CommonApi requestCommonInfoSuccess:^(NSString *msg, NSInteger status, CommonInfoItem *commonInfoItem) {
        
    } error:^(NSError *error, id resultObject) {
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

#pragma mark - lazy
- (UITableView *)customTableView
{
    if (_customTableView == nil) {
        _customTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LQScreemW, LQScreemH) style:UITableViewStylePlain];
        _customTableView.delegate = self;
        _customTableView.dataSource = self;
        _customTableView.showsVerticalScrollIndicator = NO;
        _customTableView.showsHorizontalScrollIndicator = NO;
        _customTableView.backgroundColor = [UIColor whiteColor];
        _customTableView.tableFooterView = [UIView new];
        //下拉刷新
        [_customTableView addHeaderWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        [_customTableView beginHeaderRefreshing];

    }
    return _customTableView;
}



- (HomeCustomView *)homeCustomView{
    if (!_homeCustomView) {
        _homeCustomView = [HomeCustomView new];
        
    }
    return _homeCustomView;
}
@end
