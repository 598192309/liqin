//
//  LoanConfirmationViewController.m
//  RabiBird
//
//  Created by Lqq on 2018/7/24.
//  Copyright © 2018年 Lq. All rights reserved.
// 会员待支付页面
#import "LoanConfirmationViewController.h"
#import "LoanConfirmationExtendView.h"
#import "LoanConfirmationContentView.h"
#import "BottomAlertView.h"
#import "FMDeviceManager.h"
#import "HomeApi.h"
#import "HomeModel.h"
#import "CeSuanViewController.h"
#import "BankViewController.h"

@interface LoanConfirmationViewController ()
@property (nonatomic,strong) LoanConfirmationContentView * contentView;
@property (nonatomic,strong) LoanConfirmationExtendView * extendView;

@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong)BottomAlertView *dealView;
@property(nonatomic,strong)UIView *coverView;//背后透明view  以防别处可点击

@property (nonatomic,strong)PayInfoItem * payInfoItem;
@property (nonatomic,strong)NSArray * loanTypeListArr;

@end

@implementation LoanConfirmationViewController
#pragma mark - 重写
-(void)backClick:(UIButton*)button{
    //前一个界面
    
    if ([[UIViewController secondViewController] isKindOfClass:[CeSuanViewController class]]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark -生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //开启系统右滑
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self setUpNav];
    [self addPageSubviews];
    [self layoutPageSubviews];
    [self requestData];
    NOTIFY_ADD(changeEduResult:, KChangeEduResult)
    if (_quto.length > 0) {
        [self.contentView setYucelabelText:[NSString stringWithFormat:NSLocalizedString(@"我的额度测算结果:%@", nil),_quto]];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    LQLog(@"dealloc---------%@",NSStringFromClass([self class]));
}
#pragma mark - ui
-(void)addPageSubviews{

    
    self.scrollView = [UIScrollView new];
    self.scrollView.showsVerticalScrollIndicator = nil;
    self.scrollView.showsHorizontalScrollIndicator = nil;
    [self.view addSubview:self.scrollView];
    __weak __typeof(self) weakSelf = self;

    self.extendView = [[LoanConfirmationExtendView alloc] init];
    [self.scrollView addSubview:self.extendView];
    
    self.extendView.loanConfirmationExtendViewChangeHeightBlock = ^(CGFloat height) {
        [weakSelf.extendView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];

    };
    self.contentView = [LoanConfirmationContentView new];
    //立即下款
    self.contentView.LoanConfirmationContentViewXiakuanBtnClickBlock = ^(UIButton *sender) {
        LoanTypeItem *item = [weakSelf.loanTypeListArr safeObjectAtIndex:weakSelf.contentView.row];
//        [LSVProgressHUD showInfoWithStatus:@"立即下款"];
        [weakSelf submitApplyLoan:sender amount:[NSString stringWithFormat:@"%ld",item.amount] moneyStr:[NSString stringWithFormat:@"%ld",item.total_fee]];
    };
    //服务合同
    self.contentView.LoanConfirmationContentViewDealBlock = ^(NSString *scope){
        [weakSelf.view addSubview:weakSelf.dealView];
        weakSelf.dealView.bottomAlertViewCloseBlock = ^{//关闭合同
            [weakSelf shutDealView];
        };
        [weakSelf openDealView:scope];
    };
    //额度预测
    self.contentView.LoanConfirmationContentViewCeSuanBtnClickBlock = ^{
        CeSuanViewController *vc = [[CeSuanViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    [self.scrollView insertSubview:self.contentView belowSubview:self.extendView];
    

    
}
-(void)layoutPageSubviews{
    __weak __typeof(self) weakSelf = self;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavMaxY);
        make.left.right.mas_equalTo(weakSelf.view);
        make.width.mas_equalTo(LQScreemW);
        make.bottom.mas_equalTo(weakSelf.view);
    }];
    [self.extendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.scrollView);
        make.left.mas_equalTo(weakSelf.scrollView);
        make.width.mas_equalTo(LQScreemW);

    }];
    CGFloat H = [self.extendView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;

    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(H);
        make.left.right.mas_equalTo(weakSelf.scrollView);
        make.bottom.mas_equalTo(weakSelf.scrollView);
        
    }];

}


#pragma mark - navigation
-(void)setUpNav{
  
    [self addNavigationView];
    self.navigationTextLabel.text = lqLocalized(@"会下款", nil);
    [self.navigationRightBtn setTitle:lqLocalized(@"联系客服", nil) forState:UIControlStateNormal];

    [self.navigationBackButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    

}
#pragma mark - 自定义
-(void)openQQ{
    if ([self canOpenQQ]) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",RI.customer_qq]];
        UIApplication *application = [UIApplication sharedApplication];
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [application openURL:url options:@{} completionHandler:nil];
        }else{
            [application openURL:url];
        }
    }else{
        [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"未安装QQ", nil)];
    }
}
- (BOOL)canOpenQQ{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
}

- (void)scrollsToBottomAnimated:(BOOL)animated
{
    CGFloat offset = self.scrollView.contentSize.height - self.scrollView.bounds.size.height;
    if (animated) {
        if (offset > 0)
        {
            [UIView animateWithDuration:0.5 animations:^{
                [self.scrollView setContentOffset:CGPointMake(0, offset)];
            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                [self.scrollView setContentOffset:CGPointMake(0, 0)];
            }];

        }
    }else{
        if (offset > 0)
        {
            
            [self.scrollView setContentOffset:CGPointMake(0, offset) animated:NO];
        }else{
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }
    }
    
}

- (void)openDealView:(NSString *)scope{
    __weak __typeof(self) weakSelf = self;

    [LSVProgressHUD showGIFImage];
    [HomeApi requestLoanContractWithID:[NSString stringWithFormat:@"%ld",(long)self.payInfoItem.a20] borrow_amount:scope apply_loan_id:@"" Success:^(ContractItem *contractItem, NSString *msg, NSInteger status) {
        [LSVProgressHUD dismiss];
        [self.view insertSubview:self.coverView belowSubview:self.dealView];
        [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.view);
        }];
        CGFloat H = [weakSelf.dealView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        weakSelf.dealView.frame = CGRectMake(0, LQScreemH , LQScreemW, H);
        weakSelf.dealView.htmlStr = contractItem.content;
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.view.lq_y =  - H;
        }];
        weakSelf.view.lq_height = LQScreemH + H;
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];

    }];
   
    
}
- (void)shutDealView{
    __weak __typeof(self) weakSelf = self;
    [weakSelf.coverView removeFromSuperview];
    weakSelf.coverView = nil;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.view.lq_y = 0;
    } completion:^(BOOL finished) {
        [weakSelf.dealView removeFromSuperview];
        weakSelf.dealView = nil;
        weakSelf.view.lq_height = LQScreemH;

    }];
    


}

- (void)changeEduResult:(NSNotification *)notification{
    NSString *quotaStr = [notification.userInfo safeObjectForKey: @"quota"];
    [self.contentView setYucelabelText:[NSString stringWithFormat:NSLocalizedString(@"我的额度测算结果:%@", nil),quotaStr]];
}

- (void)setQuto:(NSString *)quto{
    _quto = quto;
}
#pragma mark - 网络请求
- (void)requestData{
    __weak __typeof(self) weakSelf = self;
    [LSVProgressHUD showGIFImage];
    
    [HomeApi requestLoanTypePayInfoSuccess:^(PayInfoItem *payInfoItem, NSString *msg, NSInteger status) {
        [HomeApi requestLoanTypeListSuccess:^(NSArray *loanTypeListArr, NSString *msg, NSInteger status) {
            weakSelf.payInfoItem = payInfoItem;
            weakSelf.loanTypeListArr = loanTypeListArr;
            [weakSelf.extendView configUIWithItme:payInfoItem];
            [weakSelf.contentView configUIWithItmeArr:loanTypeListArr];
            [LSVProgressHUD dismiss];
            [self requesLoanList];

        } error:^(NSError *error, id resultObject) {
            [LSVProgressHUD showError:error];
        }];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        
    }];
}
//获取贷款案例  动画
- (void)requesLoanList{
    __weak __typeof(self) weakSelf = self;
    
    [HomeApi requestLoanListSuccess:^(NSArray *loanListArr, NSString *msg, NSInteger status) {
        [weakSelf.extendView setAnimationWithItemArr:loanListArr ];
        
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        
    }];
}

//正式申请
- (void)submitApplyLoan:(UIButton *)sender amount:(NSString *)amount moneyStr:(NSString *)moneyStr{
    sender.userInteractionEnabled = NO;
    [LSVProgressHUD showGIFImage];
    __weak __typeof(self) weakSelf = self;
    [HomeApi sumbmitLoanWithAmount:amount Success:^(NSString *loan_id, NSString *msg, NSInteger status) {
        //获取支付信息
        [HomeApi requestPayTypesSuccess:^(NSArray *paytypeItemArr, NSString *msg, NSInteger status) {
            sender.userInteractionEnabled = YES;
            //暂时只考虑银行卡 所以先这样写
            PaytypeItem *item = [paytypeItemArr safeObjectAtIndex:0];
            if ([item.code isEqualToString:@"joinpay"]) {
                BankViewController *vc = [[BankViewController alloc] init];
                vc.moneyStr = moneyStr;
                vc.loan_id = loan_id;
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
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        sender.userInteractionEnabled = YES;
    }];
    
}
#pragma mark - lazy
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
