//
//  OptionDateView.m
//  IUang
//
//  Created by jayden on 2018/5/18.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "OptionDateView.h"


@interface OptionDateView()

@property (nonatomic,strong) UIDatePicker * datePicker;
@property (nonatomic,assign) BOOL isSelect;
@property (nonatomic, strong) UIButton * leftButton;
@property (nonatomic, strong) UIButton * rightButton;

@end


@implementation OptionDateView
+(void)viewShowWhiteBlock:(nullable void (^)(NSDate * _Nullable date))block viewHiden:(nullable void(^)(void))hidenBlock{
    OptionDateView * view = [[OptionDateView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height, Main_Screen_Width, Main_Screen_Height)];;
    view.optionDateViewBlcok = block;
    view.optionDateViewHidenViewBlcok = hidenBlock;
    
    UIViewController * vc = [self getPresentedViewController];
    [vc.view addSubview:view];
//    [[[[AppDelegate shareAppDelegate] rootTabbar] view] addSubview:view];
    
    [UIView animateWithDuration:0.5 animations:^{
        view.lq_y = 0;
    }completion:^(BOOL finished) {
        view.backgroundColor = HexRGBA(0x000000, 0.5);
    }];
}
+ (UIViewController *)getPresentedViewController{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
- (void)show:(nullable void (^)(NSDate * _Nullable date))block{
    self.optionDateViewBlcok = block;


    [UIView animateWithDuration:0.2 animations:^{
        self.lq_y = 0;
    }completion:^(BOOL finished) {
        self.backgroundColor = HexRGBA(0x000000, 0.5);
    }];

}
-(void)viewHiden{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.2 animations:^{
        self.lq_y = Main_Screen_Height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
    if (self.isSelect) {
        if (self.optionDateViewBlcok) {
            self.optionDateViewBlcok(self.datePicker.date);
        }
    } else{
        if (self.optionDateViewHidenViewBlcok) {
            self.optionDateViewHidenViewBlcok();
        }
    }
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewHiden)];
        [self addGestureRecognizer:tap];
        
        [self configUI];
    }
    return self;
}
-(void)configUI{
    self.datePicker = [UIDatePicker new];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
//    [self.datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.datePicker];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.datePicker.mas_top);
        make.height.mas_equalTo(80);
    }];
    
    self.leftButton = [UIButton new];
    [self.leftButton setTitle:lqStrings(@"Batal") forState:UIControlStateNormal];
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(viewHiden) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.leftButton];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(view);
        make.width.mas_equalTo(100);
    }];
    
    self.rightButton = [UIButton new];
    [self.rightButton setTitle:lqStrings(@"Kamu yakin") forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(self.leftButton);
    }];
    self.isSelect = NO;
}


-(void)confirm:(UIButton*)button{
    self.isSelect = YES;
    [self viewHiden];
}

- (void)dateChange:(UIDatePicker *)datePicker{
    NSDate *theDate = datePicker.date;
    LQLog(@"%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd HH-mm-ss";
    LQLog(@"%@",[dateFormatter stringFromDate:theDate]);
}
- (void)dealloc{
    
    
}
@end
