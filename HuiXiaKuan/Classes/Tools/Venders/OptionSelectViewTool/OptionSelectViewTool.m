//
//  OptionSelectViewTool.m
//  IUang
//
//  Created by jayden on 2018/5/11.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "OptionSelectViewTool.h"

@interface OptionSelectViewTool()
<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong) UIPickerView * pickerView;
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) NSString * didSelectString;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic,assign) BOOL isSelect;
@property (nonatomic, strong) UIButton * leftButton;
@property (nonatomic, strong) UIButton * rightButton;
@end


@implementation OptionSelectViewTool

+(void)viewShowWhiteTitleArray:(NSArray*_Nullable)array block:(nullable void (^)(NSString * _Nullable title,NSInteger row))block viewHiden:(nullable void(^)(void))hidenBlock{
    OptionSelectViewTool * view = [[OptionSelectViewTool alloc]initWithFrame:CGRectMake(0, Main_Screen_Height, Main_Screen_Width, Main_Screen_Height)];;
    view.dataArray = array;
    view.didSelectString = [array safeObjectAtIndex:0];
    view.optionSelectViewCallBackBlock = block;
    view.optionSelectViewHidenViewBlcok = hidenBlock;
    
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


-(void)viewHiden{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.5 animations:^{
        self.lq_y = Main_Screen_Height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
    if (self.isSelect) {
        if (self.optionSelectViewCallBackBlock) {
            self.optionSelectViewCallBackBlock(self.didSelectString,self.row);
        }
    } else{
        if (self.optionSelectViewHidenViewBlcok) {
            self.optionSelectViewHidenViewBlcok();
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
    self.pickerView = [UIPickerView new];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.pickerView.mas_top);
        make.height.mas_equalTo(80);
    }];

    self.leftButton = [UIButton new];
    [self.leftButton setTitle:lqStrings(@"取消") forState:UIControlStateNormal];
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
    [self.rightButton setTitle:lqStrings(@"确认") forState:UIControlStateNormal];
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


#pragma mark UIPickerView DataSource Method
//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}
#pragma mark UIPickerView Delegate Method
//指定每行如何展示数据
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataArray[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.didSelectString = [self.dataArray safeObjectAtIndex:row];
    self.row = row;
}


@end
