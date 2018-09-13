//
//  BankViewController.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/4.
//  Copyright © 2018年 Lq. All rights reserved.
//  银行卡支付

#import "BankViewController.h"
#import "BankCustomView.h"
#import "HomeApi.h"
#import "HomeModel.h"
#import "CustomAlertView.h"
#import "CustomTextfieldView.h"
#import "PersonalLoanInfoViewController.h"
#import "XiakuanCommissionViewController.h"

@interface BankViewController ()<UITableViewDelegate,UITableViewDataSource,CustomTextfieldViewDelegate>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,strong)BankCustomView *bankCustomView;
@property (nonatomic,strong)PaytypeItem *paytypeItem;
@property(nonatomic,strong)CustomAlertView *infoAlert;//弹窗
@property (nonatomic,strong)CustomTextfieldView *customTfView;
@property (nonatomic,strong)NSDictionary *infoDict;
@property (nonatomic,assign)NSInteger payment_notice_id;

@end

@implementation BankViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

#pragma mark - ui
- (void)configUI{
    self.view.backgroundColor = BackGroundColor;
    [self.view addSubview:self.customTableView];
    __weak __typeof(self) weakSelf = self;
    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(NavMaxY);
    }];
    UIView *tableHeaderView = [[UIView alloc] init];
    [tableHeaderView addSubview:self.bankCustomView];
    [self.bankCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;
    
    [self bankCustomViewAct];
    
    //导航栏
    [self addNavigationView];
    self.navigationTextLabel.text = lqLocalized(@"会下款", nil);
    [self.navigationRightBtn setTitle:lqLocalized(@"联系客服", nil) forState:UIControlStateNormal];
    
}

#pragma mark - setter
- (void)setMoneyStr:(NSString *)moneyStr{
    _moneyStr = moneyStr;
    self.bankCustomView.moneyStr = moneyStr;
}
- (void)setLoan_id:(NSString *)loan_id{
    _loan_id = loan_id;
}
- (void)setPayment_code:(NSString *)payment_code{
    _payment_code = payment_code;
}
- (void)setCommission_token:(NSString *)commission_token{
    _commission_token = commission_token;
}
#pragma mark - act
- (void)bankCustomViewAct{
    __weak __typeof(self) weakSelf = self;
    //点击下一步
    self.bankCustomView.bankCustomViewConfirmBtnClickBlock = ^(UIButton *sender, NSDictionary *dict) {
        weakSelf.infoDict = dict;
        [weakSelf gopayWithDict:dict sender:sender code:nil];
    };
}

//汇潮查询
- (void)huichaoActQuery{
    if ([[UIViewController topViewController] isKindOfClass:[self class]] ) {//正在当前屏幕
        [self.infoAlert refreshUIWithTitle:@"" titleColor: [UIColor colorWithHexString:@"#222020"] titleFont:[UIFont boldSystemFontOfSize:AdaptedWidth(17)] titleAliment:NSTextAlignmentCenter subTitle:NSLocalizedString(@"请在新打开的支付宝页面完成支付，支付完成前请不要关闭该窗口", nil) subTitleColor: [UIColor colorWithHexString:@"#222020"] subTitleFont:[UIFont systemFontOfSize:AdaptedWidth(16)] subTitleAliment:NSTextAlignmentLeft firstBtnTitle:NSLocalizedString(@"联系客服", nil) firstBtnTitleColor:TitleBlackColor secBtnTitle:NSLocalizedString(@"我已支付", nil) secBtnTitleColor:[UIColor colorWithHexString:@"#ffc600"] singleBtnHidden:YES singleBtnTitle:@"" singleBtnTitleColor:nil];
        [[UIApplication sharedApplication].keyWindow addSubview:self.infoAlert];
        
    }
}
#pragma mark - net


//去支付
- (void)gopayWithDict:(NSDictionary *)dict sender:(UIButton *)sender code:(NSString *)code{
    [LSVProgressHUD showGIFImage];
    __weak __typeof(self) weakSelf = self;
    sender.userInteractionEnabled = NO;
    NSString *bankcard = [dict safeObjectForKey:@"bankcard"];
    NSString *idno = [dict safeObjectForKey:@"idno"];
    NSString *real_name = [dict safeObjectForKey:@"real_name"];
    NSString *mobile = [dict safeObjectForKey:@"mobile"];
    [HomeApi gopayWithLoan_id:self.loan_id mobile:mobile type:@"service" bankcard:bankcard idno:idno real_name:real_name commission_token:self.commission_token payment_code:self.payment_code payment_notice_id:self.payment_notice_id verify_code:code success:^(GoPayDetailItem *goPayDetailItem, NSString *msg, NSInteger status) {
        
        weakSelf.payment_notice_id = goPayDetailItem.payment_notice_id;
        sender.userInteractionEnabled = YES;

        if (status == -1) {//-1 的状态是未完成支付，需要等待下一步操作
            [LSVProgressHUD showInfoWithStatus:msg];
            if (!weakSelf.customTfView) {
                weakSelf.customTfView = [[CustomTextfieldView alloc] init];
                weakSelf.customTfView.mobile = mobile;
                weakSelf.customTfView.delegate = weakSelf;
                [weakSelf.customTfView showPayPopView];
            }
            
        }else{
            [weakSelf.customTfView remove];
            weakSelf.customTfView = nil;
            //支付成功
            //先查询结果
            [weakSelf queryPaymentResultWithKey:goPayDetailItem.key sender:sender];
        }
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        if (_customTfView) {
            [weakSelf.customTfView didInputPayPasswordError];
        }
        sender.userInteractionEnabled = YES;

    }];
}


//查询结果
- (void)queryPaymentResultWithKey:(NSString *)key sender:(UIButton *)sender{
    __weak __typeof(self) weakSelf = self;
    [HomeApi queryPaymentResultWithkey:key success:^(NSString *msg, NSInteger status) {
        if (status == -1) {// 未查询到结果(需要轮询当前接口获取结果，建议每5秒轮询一次)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf queryPaymentResultWithKey:key sender:sender];
                
            });
        }else{
            [LSVProgressHUD showInfoWithStatus:msg];
            sender.userInteractionEnabled = YES;
            if ([[UIViewController secondViewController] isKindOfClass:[XiakuanCommissionViewController class]]) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                PersonalLoanInfoViewController *vc = [[PersonalLoanInfoViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
                
            }
            

        }
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        sender.userInteractionEnabled = YES;

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
#pragma mark -  CustomTextfieldViewDelegate
- (void)didPasswordInputFinished:(NSString *)password{

    [self gopayWithDict:self.infoDict sender:nil code:password];
}


- (void)didAuthBtnClick {
    [self gopayWithDict:self.infoDict sender:nil code:nil];
}

- (void)didClose{
    self.payment_notice_id = @"";
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
        
    }
    return _customTableView;
}

- (BankCustomView *)bankCustomView{
    if (!_bankCustomView) {
        _bankCustomView = [[BankCustomView alloc] init];
    }
    return _bankCustomView;
}
- (CustomAlertView *)infoAlert{
    if (_infoAlert == nil) {
        _infoAlert = [CustomAlertView instanceView];
        
        _infoAlert.lq_y = 0;
        _infoAlert.lq_x = 0;
        _infoAlert.lq_width = LQScreemW;
        _infoAlert.lq_height = LQScreemH;
        __weak __typeof(self) weakSelf = self;
        
        _infoAlert.CustomAlertViewBlock = ^(NSInteger index,NSString *str){
            if (index == 1) {
                [weakSelf.infoAlert removeFromSuperview];
                weakSelf.infoAlert = nil;
                
                
            }else if (index == 2) {
                [weakSelf.infoAlert removeFromSuperview];
                weakSelf.infoAlert = nil;
          
                
            }else if (index == 3) {
                
                [weakSelf.infoAlert removeFromSuperview];
                weakSelf.infoAlert = nil;
                
                
            }else if (index == 4) {
                
                [weakSelf.infoAlert removeFromSuperview];
                weakSelf.infoAlert = nil;
  
                
            }
            
        };
    }
    
    return _infoAlert;
    
}
@end
