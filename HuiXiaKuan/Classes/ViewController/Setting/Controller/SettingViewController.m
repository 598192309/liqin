//
//  SettingViewController.m
//  RabiBird
//
//  Created by Lqq on 16/8/12.
//  Copyright © 2016年 Lq. All rights reserved.
//

#import "SettingViewController.h"

#import "LorginApi.h"
#import "CustomAlertView.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "AboutViewController.h"
#import "LorginViewController.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *nameTipLabel;

@property (weak, nonatomic) UIButton *lorginOutBtn;
@property (strong, nonatomic)  UILabel *versionLabel;
@property (nonatomic, strong)UITableView *customTableView;


@property(nonatomic,strong)LAContext *context;
@end

@implementation SettingViewController
#pragma mark - lazy
- (UITableView *)customTableView
{
    if (_customTableView == nil) {
        _customTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavMaxY, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
        _customTableView.delegate = self;
        _customTableView.dataSource = self;
        _customTableView.showsVerticalScrollIndicator = NO;
        _customTableView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        _customTableView.separatorColor = ViewBackGroundColor;
        
    }
    return _customTableView;
}


#pragma  mark - act
- (void)lorginOutBtnClick:(UIButton *)sender {
    sender.userInteractionEnabled = NO;
    __weak __typeof(self) weakSelf = self;
        if (RI.is_logined) {
            [LSVProgressHUD showGIFImage];

            [LorginApi loginOutSuccess:^(NSString *msg) {
                sender.userInteractionEnabled = YES;
               

                [LSVProgressHUD showInfoWithStatus:msg];
                NOTIFY_POST(kUserSignOut);
                [weakSelf.customTableView reloadData];
            } error:^(NSError *error, id resultObject) {
                [LSVProgressHUD showError:error];
                
                sender.userInteractionEnabled = YES;

            }];
        }else{
            //跳入登录界面
            [AppDelegate presentLoginViewContrller];
            sender.userInteractionEnabled = YES;

        }
  
}


#pragma mark -  类方法
+ (instancetype)instanceController
{
    SettingViewController *vc = [[SettingViewController alloc] init];
    return vc;
}
#pragma mark -  生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.customTableView];
    //监听用户退出登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configUI) name:kUserSignOut object:nil];
    //监听用户登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configUI) name:kUserSignIn object:nil];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LQScreemW, AdaptedHeight(150)- NavMaxY)];
//    header.backgroundColor = [UIColor whiteColor];
//    UILabel *titleLabel = [UILabel lableWithText:NSLocalizedString(@"更多", nil) textColor:[UIColor colorWithHexString:@"#222020"] fontSize:AdaptedFontSize(36) lableSize:CGRectZero textAliment:NSTextAlignmentLeft];
//    [header addSubview:titleLabel];
//    titleLabel.lq_x = AdaptedWidth(17.5);
//    titleLabel.lq_y = AdaptedHeight(15);
//    self.customTableView.tableHeaderView = header;
//    self.customTableView.tableHeaderView.lq_height = header.lq_height;
    
    
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LQScreemW, LQScreemH - self.customTableView.tableHeaderView.lq_height - 70 *3 - NavMaxY )];
    footer.backgroundColor = ViewBackGroundColor;
    self.customTableView.tableFooterView = footer;
    self.customTableView.tableFooterView.lq_height = footer.lq_height;
    
    self.customTableView.scrollEnabled = NO;

    [self configUI];
    [self setUpNav];
  
    


}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)dealloc{
    LQLog(@"dealloc -- %@",NSStringFromClass([self class]));
}
#pragma  mark - 刷新ui
- (void)configUI{
   
    [self.customTableView reloadData];

}

- (void)setUpNav{
    //导航栏
    [self addNavigationView];
    self.navigationTextLabel.text = lqLocalized(@"会下款", nil);
    [self.navigationRightBtn setTitle:lqLocalized(@"联系客服", nil) forState:UIControlStateNormal];
    
    self.navigationBackButton.hidden = YES;

}
#pragma  mark - 网络请求
#pragma mark -  uitableview datesource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])]
        ;
    }

    cell.textLabel.textColor = [UIColor colorWithHexString:@"#202020"];
    cell.textLabel.font = AdaptedFontSize(17);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Going-1"]];
//        cell.textLabel.text = NSLocalizedString(@" 说出你的建议", nil);
        cell.textLabel.text = NSLocalizedString(@" 关于我们", nil);

    }else if (indexPath.row == 1) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Going-1"]];
        //        cell.textLabel.text = NSLocalizedString(@" 说出你的建议", nil);
        cell.textLabel.text = RI.is_logined ? lqLocalized(@" 退出登录", nil) : lqLocalized(@" 登录/注册", nil);
        
    }
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AboutViewController *vc = [[AboutViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }if (indexPath.row == 1) {
        [self lorginOutBtnClick:nil];
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
@end
