//
//  CeSuanViewController.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/31.
//  Copyright © 2018年 Lq. All rights reserved.
//  测算额度界面

#import "CeSuanViewController.h"
#import "CeSuanCustomView.h"
#import "HomeApi.h"
#import "HomeModel.h"
#import "LoanConfirmationViewController.h"
@interface CeSuanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,strong)CeSuanCustomView *ceSuanCustomView;
@property (nonatomic,strong)EDuThemeItem *eDuThemeItem;
@property (nonatomic,strong)NSArray *eDuQuestionItemArr;
@property (nonatomic,assign)NSInteger quota;

@end

@implementation CeSuanViewController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self requestThemeData];
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
    [tableHeaderView addSubview:self.ceSuanCustomView];
    [self.ceSuanCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;
    
    [self ceSuanCustomViewAct];
    
    //导航栏
    [self addNavigationView];
    self.navigationTextLabel.text = lqLocalized(@"会下款", nil);
    [self.navigationRightBtn setTitle:lqLocalized(@"联系客服", nil) forState:UIControlStateNormal];
    
}
#pragma mark - act
- (void)ceSuanCustomViewAct{
    __weak typeof(self)weakSelf = self;
    //改变高度
    self.ceSuanCustomView.CeSuanCustomViewChangeHeightBlock = ^{
//        CGFloat H = [weakSelf.ceSuanCustomView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//        weakSelf.customTableView.tableHeaderView.lq_height = H;

        [weakSelf refreshHeaderViewHeight];
    };
    
    self.ceSuanCustomView.ceSuanCustomViewCesuanBtnClickBlock = ^(UIButton *sender, NSDictionary *dict) {
        CommonBtn *btn = (CommonBtn *)sender;
        if (btn.selected) {
            NSString *options = [dict safeObjectForKey:@"options"];
            [weakSelf submitCesuan:sender options:options];
        }else{
            UIViewController *vc = [UIViewController secondViewController];
            if ([vc isKindOfClass:[LoanConfirmationViewController class]]) {
                NOTIFY_POST_Dict(KChangeEduResult, (@{@"quota":[NSString stringWithFormat:@"%ld",self.quota]}));
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                LoanConfirmationViewController *vc = [[LoanConfirmationViewController alloc] init];
                vc.quto =[NSString stringWithFormat:@"%ld",self.quota];
                RI.quota = self.quota;
                [[NSUserDefaults standardUserDefaults] setObject:@(self.quota) forKey:KQuota];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }
       
    };
}
- (void)refreshHeaderViewHeight{
    UIView *tableHeaderView = [[UIView alloc] init];
    [tableHeaderView addSubview:self.ceSuanCustomView];
    [self.ceSuanCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = H;
    self.customTableView.tableHeaderView.lq_height = H;
    
    self.customTableView.tableHeaderView = tableHeaderView;
    
    
}

#pragma mark - net
- (void)requestThemeData{
    [LSVProgressHUD showGIFImage];
    __weak __typeof(self) weakSelf = self;
    [HomeApi requestEDuThemeSuccess:^(EDuThemeItem *eDuThemeItem, NSString *msg, NSInteger status) {
        weakSelf.eDuThemeItem = eDuThemeItem;
        [HomeApi requestEDuQuestionListSuccess:^(NSArray *eDuQuestionItemArr, NSString *msg, NSInteger status) {
            weakSelf.eDuQuestionItemArr = eDuQuestionItemArr;
            [weakSelf.ceSuanCustomView configUIWithItem:eDuThemeItem eduQuestionList:eDuQuestionItemArr finishBlock:^{
                CGFloat H = [weakSelf.ceSuanCustomView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
                self.customTableView.tableHeaderView.lq_height = H;

            }];
            [LSVProgressHUD dismiss];
        } error:^(NSError *error, id resultObject) {
            [LSVProgressHUD showError:error];

        }];
        
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
    }];
}
//提交测试
- (void)submitCesuan: (UIButton *)sender options:(NSString *)options{
    [LSVProgressHUD showGIFImage];
    __weak __typeof(self) weakSelf = self;
    sender.userInteractionEnabled = NO;
    [HomeApi submitEDuQuestionListWithOptions:options success:^(NSInteger quota, NSString *msg, NSInteger status) {
        [LSVProgressHUD dismiss];
        [weakSelf.ceSuanCustomView setEduLable:quota];
        CommonBtn *btn = (CommonBtn*)sender;
        btn.btnEnable = YES;
        btn.btnSeleted = NO;
        
        weakSelf.quota = quota;
        sender.userInteractionEnabled = YES;

//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            UIViewController *vc = [UIViewController secondViewController];
//            if ([vc isKindOfClass:[LoanConfirmationViewController class]]) {
//                NOTIFY_POST_Dict(KChangeEduResult, (@{@"quota":[NSString stringWithFormat:@"%ld",quota]}));
//                [weakSelf.navigationController popViewControllerAnimated:YES];
//                sender.userInteractionEnabled = YES;
//            }else{
//                LoanConfirmationViewController *vc = [[LoanConfirmationViewController alloc] init];
//                vc.quto =[NSString stringWithFormat:@"%ld",quota];
//                RI.quota = quota;
//                [[NSUserDefaults standardUserDefaults] setObject:@(quota) forKey:KQuota];
//                [weakSelf.navigationController pushViewController:vc animated:YES];
//                sender.userInteractionEnabled = YES;
//            }
//
//        });

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
        _customTableView.contentInset = UIEdgeInsetsMake(0, 0, TabbarH, 0);
        
    }
    return _customTableView;
}

- (CeSuanCustomView *)ceSuanCustomView{
    if (!_ceSuanCustomView) {
        _ceSuanCustomView = [[CeSuanCustomView alloc] init];
        
    }
    return _ceSuanCustomView;
}

@end
