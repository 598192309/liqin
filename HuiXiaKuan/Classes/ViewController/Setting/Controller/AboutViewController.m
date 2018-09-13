//
//  AboutViewController.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/9/4.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "AboutViewController.h"
#import "Setting.h"
#import "SettingApi.h"
#import "AboutCustomView.h"
@interface AboutViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView  *customTableView;
@property (nonatomic,strong)AboutCustomView *aboutCustomView;
@property (nonatomic,strong)AboutItem *aboutItem;
@end

@implementation AboutViewController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self requestData];
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
    [tableHeaderView addSubview:self.aboutCustomView];
    [self.aboutCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;
    
    [self aboutCustomViewAct];
    
    //导航栏
    [self addNavigationView];
    self.navigationTextLabel.text = lqLocalized(@"会下款", nil);
    [self.navigationRightBtn setTitle:lqLocalized(@"联系客服", nil) forState:UIControlStateNormal];
}

#pragma mark - act
- (void)aboutCustomViewAct{
    
}
#pragma mark - net
- (void)requestData{
    __weak __typeof(self) weakSelf = self;
    [SettingApi requestAboutInfoSuccess:^(AboutItem *aboutItem, NSString *msg, NSInteger status) {
        [weakSelf.aboutCustomView configUIWithItem:aboutItem finishi:^{
            CGFloat H = [weakSelf.aboutCustomView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            weakSelf.customTableView.tableHeaderView.lq_height = H;
            CGSize w = weakSelf.customTableView.contentSize ;
            weakSelf.customTableView.contentSize = CGSizeMake(LQScreemW, H);

        }];
    
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
        
    }
    return _customTableView;
}
- (AboutCustomView *)aboutCustomView{
    if (!_aboutCustomView) {
        _aboutCustomView = [[AboutCustomView alloc] init];
    }
    return _aboutCustomView;
}
@end
