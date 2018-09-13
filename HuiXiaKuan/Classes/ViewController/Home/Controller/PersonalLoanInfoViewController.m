//
//  PersonalLoanInfoViewController.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/5.
//  Copyright © 2018年 Lq. All rights reserved.
//  填写个人信息

#import "PersonalLoanInfoViewController.h"
#import "PersonalLoanCustomView.h"
#import "HomeApi.h"
#import "HomeModel.h"
#import "multipleChoiceCell.h"
#import "PersonalLoanCustomBottomView.h"
#import "CommonApi.h"
#import "Contact.h"
#import <AddressBookUI/AddressBookUI.h>

@interface PersonalLoanInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,strong)PersonalLoanCustomView *personalLoanCustomView;
@property (nonatomic,strong)PersonalLoanCustomBottomView *personalLoanCustomBottomView;
@property (nonatomic,strong)LoanBuildInfoItem *loanBuildInfoItem ;
@property (nonatomic,strong)NSArray *provinceList ;
@property (nonatomic,strong)NSArray *cityList ;
@property (nonatomic,strong)NSMutableDictionary *creditInfoDict;
@property (nonatomic,strong)NSMutableDictionary *creditInfoDictStr;

@property (nonatomic,strong)NSArray *adressList;
@property (nonatomic,strong)NVMContactManager *manager;
@property(nonatomic,strong)UIAlertController *contactAlert;//通讯录获取权限拒绝时 提醒弹框

@end

@implementation PersonalLoanInfoViewController
#pragma mark - 重写
//右滑返回功能，默认开启（YES）
- (BOOL)gestureRecognizerShouldBegin{
    return NO;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //监听访问通讯录获取
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contactAlertShow) name:NVMContactAccessFailedNotification object:nil];

    [self configUI];
    [self requestData];
    [self getAdressListArr];

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
    [self refreshHeaderView];
    
    [self refreshFooterView];

    
    [self personalLoanCustomViewAct];
    
    //导航栏
    [self addNavigationView];
    self.navigationTextLabel.text = lqLocalized(@"会下款", nil);
    [self.navigationRightBtn setTitle:lqLocalized(@"联系客服", nil) forState:UIControlStateNormal];
    
}
#pragma mark - act
- (void)personalLoanCustomViewAct{
    __weak __typeof(self) weakSelf = self;
    //获取city
    self.personalLoanCustomView.personalLoanCustomViewCityClickBlock = ^(UIButton *sender, NSString *province) {
        if (province.length > 0) {
            [weakSelf requestCityWithProvince:province];
        }else{
            [LSVProgressHUD showInfoWithStatus:@"请先选择省份"];
        }
    };
    
    //提交信息
    self.personalLoanCustomBottomView.personalLoanCustomBottomViewConfirmBtnClickBlock = ^(UIButton *sender, NSString *loan_platform) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:weakSelf.personalLoanCustomView.infoDict];
        [dict setObject:[NSString stringWithFormat:@"%ld",RI.loanID] forKey:@"loan_id"];
        NSArray *creditArr = weakSelf.loanBuildInfoItem.credit_info;
        for (int i = 0; i < creditArr.count; i++) {
            CreditInfoItem *creditItem = [creditArr safeObjectAtIndex:i];
             NSMutableArray *arr = [weakSelf.creditInfoDict safeObjectForKey:[NSString stringWithFormat:@"%ld",creditItem.cat_id]];
            BOOL allSel = YES;
            for ( NSNumber *a in arr) {
                if ([a integerValue] == 1000) {
                    allSel = NO;
                }
            }
            
            if (!allSel) {
                [LSVProgressHUD showInfoWithStatus:@"请将选择题回答完整"];
                return ;
            }else{
                NSString *str = [arr componentsJoinedByString:@","];
                [weakSelf.creditInfoDictStr setObject:str forKey:[NSString stringWithFormat:@"%ld",creditItem.cat_id]];
            }

        }
        

        [dict setObject:SAFE_NIL_STRING(weakSelf.creditInfoDictStr) forKey:@"credit_info"];

        [dict setObject:loan_platform forKeyedSubscript:@"loan_platform"];
        [weakSelf submitLoanInfoWithDict:dict sender:sender];
    };
}
- (void)refreshHeaderView{
    UIView *tableHeaderView = [[UIView alloc] init];
    [tableHeaderView addSubview:self.personalLoanCustomView];
    [self.personalLoanCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = H;
    self.customTableView.tableHeaderView.lq_height = H;

    self.customTableView.tableHeaderView = tableHeaderView;


}
- (void)refreshFooterView{
    UIView *tableFooterView = [[UIView alloc] init];
    [tableFooterView addSubview:self.personalLoanCustomBottomView];
    [self.personalLoanCustomBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableFooterView);
    }];
    CGFloat footerH = [tableFooterView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableFooterView.lq_height = footerH;
    self.customTableView.tableFooterView.lq_height = footerH;

    self.customTableView.tableFooterView = tableFooterView;

}

- (void)getAdressListArr{
    NVMContactManager *manager = [NVMContactManager manager];
    _manager = manager;
    [manager loadAllPeople :nil];
    __weak __typeof(manager) weakSelfManager = manager;
    __weak __typeof(self) weakSelf = self;
    manager.ContactUploadSucBlock = ^(NSString *msg){ //授权获取通讯录 上传成功进入下一页 就是银行界面咯
        weakSelf.adressList = weakSelfManager.allPeople;
        if ([msg containsString:@"success"]) {
            
        }else if([msg containsString:@"failed"]){
        }
    };
}
//获取通讯录授权弹框
- (void)contactAlertShow{
    
//    [self.contactAlert show];
    [self presentViewController:self.contactAlert animated:YES completion:nil];

    
}

#pragma mark - net
- (void)requestData{
    [LSVProgressHUD showGIFImage];
    __weak __typeof(self) weakSelf = self;
    //先获取commoninfo  需要用到里面的loanID
    [CommonApi requestCommonInfoSuccess:^(NSString *msg, NSInteger status, CommonInfoItem *commonInfoItem) {
        [HomeApi requestLoanBuildInfoWithLoan_id:[NSString stringWithFormat:@"%ld",RI.loanID] success:^(LoanBuildInfoItem *loanBuildInfoItem, NSString *msg, NSInteger status) {
            weakSelf.loanBuildInfoItem = loanBuildInfoItem;
            [LSVProgressHUD dismiss];
            [weakSelf.personalLoanCustomView configUIWithItem:loanBuildInfoItem finishBlock:^{
                [weakSelf refreshHeaderView];
            }];
            
            [weakSelf.personalLoanCustomBottomView configUIWithItem:loanBuildInfoItem finishBlock:^{
                [weakSelf refreshFooterView];
            }];
            [weakSelf requestProvince];
            
            if (loanBuildInfoItem.base_info.province.length > 0) {
                [weakSelf requestCityWithProvince:loanBuildInfoItem.base_info.province];
                
            }
            [weakSelf.customTableView reloadData];
            
            weakSelf.creditInfoDict = [NSMutableDictionary dictionary];
            weakSelf.creditInfoDictStr = [NSMutableDictionary dictionary];
            NSArray *creditArr = weakSelf.loanBuildInfoItem.credit_info;
            for (int i = 0; i < creditArr.count; i++) {
                CreditInfoItem *creditItem = [creditArr safeObjectAtIndex:i];
                NSMutableArray *optionsArr = [NSMutableArray array];
                //            for (int j = 0; i < creditArr.count; j++) {
                for (EDuQuestionItem *item in creditItem.questions) {
                    [optionsArr addObject:@(1000)];
                }
                //            }
                [ weakSelf.creditInfoDict setObject:optionsArr forKey:[NSString stringWithFormat:@"%ld",creditItem.cat_id]];
                [ weakSelf.creditInfoDictStr setObject:optionsArr forKey:[NSString stringWithFormat:@"%ld",creditItem.cat_id]];
                
                
            }
            
        } error:^(NSError *error, id resultObject) {
            [LSVProgressHUD showError:error];
        }];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
    }];
    
}
- (void)requestProvince{
    __weak __typeof(self) weakSelf = self;
    [HomeApi requestProvinceListSuccess:^(NSArray *provinceList, NSString *msg, NSInteger status) {
        weakSelf.provinceList = provinceList;
        weakSelf.personalLoanCustomView.provinceArr = provinceList;
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
    }];
}
- (void)requestCityWithProvince:(NSString *)province{
    __weak __typeof(self) weakSelf = self;
    [HomeApi requestCityListWithProvice:province success:^(NSArray *cityList, NSString *msg, NSInteger status) {
        weakSelf.cityList = cityList;
        weakSelf.personalLoanCustomView.cityArr = cityList;
        [weakSelf.personalLoanCustomView cityShow];

    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];

    }];
}

- (void)submitLoanInfoWithDict:(NSDictionary *)dict sender:(UIButton *)sender{
    __weak typeof(self)weakSelf = self;
    
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    if (status == kABAuthorizationStatusDenied) {
//        [self.contactAlert show];
        [self presentViewController:self.contactAlert animated:YES completion:nil];

        return;
    }else if (self.adressList.count == 0){
        //重新获取
        [self.manager loadAllPeople:sender];
        self.adressList = self.manager.allPeople;
    }
    
    NSString *loanid = [dict safeObjectForKey:@"loan_id"];
    NSString *real_name = [dict safeObjectForKey:@"real_name"];
    NSString *bankcard = [dict safeObjectForKey:@"bankcard"];
    NSString *idno = [dict safeObjectForKey:@"idno"];
    NSString *mobile = [dict safeObjectForKey:@"mobile"];
    NSString *zhima = [dict safeObjectForKey:@"zhima"];
    NSString *qq = [dict safeObjectForKey:@"qq"];
    NSString *education = [dict safeObjectForKey:@"education"];
    NSString *graduation = [dict safeObjectForKey:@"graduation"];
    NSString *province = [dict safeObjectForKey:@"province"];
    NSString *city = [dict safeObjectForKey:@"city"];
    NSMutableDictionary *credit_info = [dict safeObjectForKey:@"credit_info"];
    NSString *loan_platform = [dict safeObjectForKey:@"loan_platform"];
    weakSelf.adressList = weakSelf.manager.allPeople;
    if (!(loanid.length > 0 && real_name.length > 0 && bankcard.length > 0 && idno.length > 0  && mobile.length > 0 && zhima .length > 0 && qq.length > 0 && education.length > 0 && graduation.length > 0 && province.length > 0 && city.length > 0 && loan_platform.length > 0)) {
        [LSVProgressHUD showInfoWithStatus:lqLocalized(@"请确保信息填写完整", nil)];
        return;
    }

    [LSVProgressHUD showGIFImage];
    [HomeApi requestLoanBuildInfoWithLoan_id:loanid real_name:real_name bankcard:bankcard idno:idno mobile:mobile zhima:zhima qq:qq education:education graduation:graduation province:province city:city credit_info:credit_info loan_platform:loan_platform   addresslist:self.manager.allPeople success:^(NSString *msg, NSInteger status) {
        [LSVProgressHUD dismiss];
        //进入我的账户首页
        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
        MainTabBarController *vc =(MainTabBarController *)del.window.rootViewController;
        vc.selectedIndex = 1;
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];


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
    return self.loanBuildInfoItem.credit_info.count;
//    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    multipleChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([multipleChoiceCell class] ) forIndexPath:indexPath ];
    __weak __typeof(self) weakSelf = self;
    CreditInfoItem *item = [self.loanBuildInfoItem.credit_info safeObjectAtIndex:indexPath.row];
    [cell configUIWithItem:item finishBlock:^{
        
    }];
    
    cell.multipleChoiceCellChooseBlock = ^(NSInteger seletedIndex ,NSInteger row) {
        NSInteger pathRow = row;
//        NSMutableArray *arr = [weakSelf.creditInfoDict safeObjectForKey:@(item.cat_id)];
        NSMutableArray *arr = [weakSelf.creditInfoDict safeObjectForKey:[NSString stringWithFormat:@"%ld",item.cat_id]];
        NSMutableArray *arr1 = [weakSelf.creditInfoDictStr safeObjectForKey:[NSString stringWithFormat:@"%ld",item.cat_id]];


        [arr setObject:@(seletedIndex) atIndexedSubscript:pathRow];
        [arr1 setObject:@(seletedIndex) atIndexedSubscript:pathRow];

    };

    return cell;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    multipleChoiceCell *cell = (multipleChoiceCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
//    CGFloat H = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    return H;
//}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
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
        [_customTableView registerClass:[multipleChoiceCell class] forCellReuseIdentifier:NSStringFromClass([multipleChoiceCell class])];
        
    }
    return _customTableView;
}
- (PersonalLoanCustomView *)personalLoanCustomView{
    if (!_personalLoanCustomView) {
        _personalLoanCustomView = [[PersonalLoanCustomView alloc] init];
    }
    return _personalLoanCustomView;
}
- (PersonalLoanCustomBottomView *)personalLoanCustomBottomView{
    if (!_personalLoanCustomBottomView) {
        _personalLoanCustomBottomView = [[PersonalLoanCustomBottomView alloc] init];
    }
    return _personalLoanCustomBottomView;
}
- (UIAlertController *)contactAlert{
    if (_contactAlert == nil) {
//        _contactAlert = [[UIAlertView alloc]initWithTitle:nil
//                                                  message:NSLocalizedString(@"你未对\"拉比鸟\"开放获取通讯录权限，请前往手机\"设置-隐私\"进行修改！", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"知道了", nil) otherButtonTitles:nil, nil];
        
        _contactAlert = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"你未对\"拉比鸟\"开放获取通讯录权限，请前往手机\"设置-隐私\"进行修改！", nil) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *done = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [_contactAlert addAction:done];
    }
    return _contactAlert;
}

@end
