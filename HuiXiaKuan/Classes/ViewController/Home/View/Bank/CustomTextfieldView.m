//
//  CustomTextfieldView.m
//  IUang
//
//  Created by Lqq on 2018/4/27.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "CustomTextfieldView.h"
#define PasswordBoxWidth AdaptedWidth(50)
#define PasswordBoxSpace AdaptedWidth(4)
//#define PasswordBoxMargin AdaptedWidth(18)
#define PasswordBoxNumber 6

@interface CustomPasswordView ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray <UILabel*> *labelBoxArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSString *currentText;
@end
@implementation CustomPasswordView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, LQScreemW, AdaptedWidth(50));
        [self addSubview:self.textField];
        //        [self.textField becomeFirstResponder];
        [self initData];
    }
    return self;
}

- (void)initData
{
    self.currentText = @"";
    for (int i = 0; i < PasswordBoxNumber; i ++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(  i * (PasswordBoxWidth + PasswordBoxSpace), 0, PasswordBoxWidth, PasswordBoxWidth)];
        label.textColor = TitleBlackColor;
        label.layer.borderWidth = kOnePX *3;
        label.layer.borderColor = TitleGrayColor.CGColor;
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = AdaptedFontSize(20);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showKeybord:)];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tap];
        [self addSubview:label];
        
        [self.labelBoxArray addObject:label];
    }
}

- (void)startShakeViewAnimation
{
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    shake.values = @[@0,@-10,@10,@-10,@0];
    shake.additive = YES;
    shake.duration = 0.25;
    [self.layer addAnimation:shake forKey:@"shake"];
}
- (void)showKeybord:(UITapGestureRecognizer *)tap{
    [self.textField becomeFirstResponder];
}
- (void)textDidChanged:(UITextField *)textField
{
    if (textField.text.length > PasswordBoxNumber)
    {
        textField.text = [textField.text substringToIndex:PasswordBoxNumber];
    }
    
    [self updateLabelBoxWithText:textField.text];
    if (textField.text.length == PasswordBoxNumber)
    {
        if (self.completionBlock)
        {
            self.completionBlock(self.textField.text);
        }
    }
}

#pragma mark - setter
- (void)setSpace:(CGFloat )space{
    _space = space;
    for (int i = 0; i < PasswordBoxNumber; i++)
    {
        UILabel *label = self.labelBoxArray[i];
        label.frame = CGRectMake(  i * (PasswordBoxWidth + space), 0, PasswordBoxWidth, PasswordBoxWidth);
    }

}

#pragma mark - Public

- (void)updateLabelBoxWithText:(NSString *)text
{
    //输入时
    if (text.length > self.currentText.length) {
        for (int i = 0; i < PasswordBoxNumber; i++)
        {
            UILabel *label = self.labelBoxArray[i];
            if (i < text.length - 1)
            {
//                //特殊字符不居中显示，设置文本向下偏移
//                NSAttributedString * att1 = [[NSAttributedString alloc] initWithString:@"*" attributes:@{NSBaselineOffsetAttributeName:@(-3)}];
//                label.attributedText = att1;
                label.text = [text substringWithRange:NSMakeRange(i, 1)];
//                [self animationShowTextInLabel: label];

            }
            else if (i == text.length - 1)
            {
                label.text = [text substringWithRange:NSMakeRange(i, 1)];
//                [self animationShowTextInLabel: label];
            }
            else
            {
                label.text = @"";
            }
        }
    }
    //删除时
    else
    {
        for (int i = 0; i < PasswordBoxNumber; i++)
        {
            UILabel *label = self.labelBoxArray[i];
            if (i < text.length)
            {
//                //特殊字符不居中显示，设置文本向下偏移
//                NSAttributedString * att1 = [[NSAttributedString alloc] initWithString:@"*" attributes:@{NSBaselineOffsetAttributeName:@(-3)}];
//                label.attributedText = att1;
                label.text = @"";

            }
            else
            {
                label.text = @"";
            }
        }
    }
    self.textField.text = text;
    self.currentText = text;
}

- (void)animationShowTextInLabel:(UILabel *)label
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //特殊字符不居中显示，设置文本向下偏移
        NSAttributedString * att1 = [[NSAttributedString alloc] initWithString:@"*" attributes:@{NSBaselineOffsetAttributeName:@(-3)}];
        label.attributedText = att1;
    });
}

- (void)didInputPasswordError
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startShakeViewAnimation];
        self.textField.text = @"";
        [self updateAllLabelTextToNone];
    });
}

- (void)updateAllLabelTextToNone
{
    for (int i = 0; i < PasswordBoxNumber; i++)
    {
        UILabel *label = self.labelBoxArray[i];
        label.text = @"";
    }
}

- (void)transformTextInTextField:(UITextField *)textField
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        textField.text = @"*";
    });
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

#pragma mark - Getter/Setter

- (NSMutableArray *)labelBoxArray
{
    if (!_labelBoxArray)
    {
        _labelBoxArray = [NSMutableArray array];
    }
    return _labelBoxArray;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] init];
        [_textField addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.delegate = self;
    }
    return _textField;
}

@end


#define AnimationTimeInterval 0.1
#define SupeViewAlpha 0.3

@interface CustomTextfieldView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) UIView *payPopupView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *authBtn;

@property (nonatomic, strong) CustomPasswordView* passwordView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UITextField *textField;

@end


@implementation CustomTextfieldView
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
        //键盘即将显示
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
        //键盘即将消失
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)createUI
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.superView];
    [self.superView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(window);
    }];
    
    [self.superView addSubview:self];
    __weak __typeof(self) weakSelf = self;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(AdaptedWidth(10));
        make.right.mas_equalTo(_superView).mas_equalTo(-AdaptedWidth(10));
        make.centerY.mas_equalTo(_superView);
        make.height.mas_equalTo(AdaptedWidth(240));
    }];
    ViewRadius(self, 5);
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(AdaptedWidth(35));
        make.left.mas_equalTo(AdaptedWidth(20));
    }];
    [self addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).with.offset(AdaptedWidth(5));
        make.left.mas_equalTo(weakSelf.titleLabel);
    }];
    [self addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-AdaptedWidth(20));
        make.width.height.mas_equalTo(AdaptedWidth(20));
        make.top.mas_equalTo(AdaptedWidth(20));
    }];
    
    [self addSubview:self.passwordView];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLabel);
        make.top.equalTo(weakSelf.phoneLabel.mas_bottom).with.offset(AdaptedWidth(25));
        make.height.mas_equalTo(AdaptedWidth(50));
//        make.width.mas_equalTo(Main_Screen_Width);
        make.right.equalTo(weakSelf);
    }];
    [self addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passwordView.mas_bottom).with.offset(AdaptedWidth(10));
        make.left.mas_equalTo(weakSelf.titleLabel);
    }];
    
    [self addSubview:self.authBtn];
    [self.authBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).with.offset(-AdaptedWidth(20));
        make.centerX.mas_equalTo(weakSelf);

    }];
}

#pragma mark -act

- (void)authBtnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(didAuthBtnClick)]) {
        [self.delegate didAuthBtnClick];
    }

}



- (void)showPayPopView
{
    [self.authBtn startWithTime:60 title:NSLocalizedString(@"重新获取", nil) titleColor:[UIColor redColor] countDownTitle:NSLocalizedString(@"s", nil) countDownTitleColor:TitleGrayColor mainColor:[UIColor clearColor] countColor:[UIColor whiteColor]];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:AnimationTimeInterval animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.superView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidePayPopView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:AnimationTimeInterval animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.superView.alpha = 0.0;
        strongSelf.frame = CGRectMake(strongSelf.frame.origin.x, LQScreemH, strongSelf.frame.size.width, strongSelf.frame.size.height);
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
//        [strongSelf.superView removeFromSuperview];
//        strongSelf.superView = nil;
        if ([strongSelf.delegate respondsToSelector:@selector(didClose)])
        {
            [strongSelf.delegate didClose];
        }

    }];
}

- (void)remove{
    [self.superView removeFromSuperview];
    self.superView = nil;
    [self removeFromSuperview];


}

- (void)didInputPayPasswordError
{
    [self.passwordView didInputPasswordError];
    self.tipLabel.hidden = NO;
}

/**倒计时*/
- (void)countdowm{
    [self.authBtn startWithTime:60 title:NSLocalizedString(@"重新获取", nil) titleColor:[UIColor redColor] countDownTitle:NSLocalizedString(@"s", nil) countDownTitleColor:TitleGrayColor mainColor:[UIColor clearColor] countColor:[UIColor whiteColor]];
    
}

#pragma mark - setter
- (void)setMobile:(NSString *)mobile{
    _mobile = mobile;
    _phoneLabel.text = mobile;
}
#pragma mark - 键盘
//键盘即将显示
-(void)keyboardWillShow:(NSNotification *)note{
    // 获得通知信息
    NSDictionary *userInfo = note.userInfo;
    // 获取键盘的高度
    CGRect frame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 获得键盘执行动画的时间
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration delay:0.0 options:7 << 16 animations:^{
        CGFloat h = LQScreemH - AdaptedWidth(240) -frame.size.height;
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(AdaptedWidth(10));
            make.right.mas_equalTo(weakSelf.superView).mas_equalTo(-AdaptedWidth(10));
            make.top.mas_equalTo(h);
            make.height.mas_equalTo(AdaptedWidth(240));

        }];
        
    } completion:nil];
}

//键盘即将消失
-(void)keyboardWillHide:(NSNotification *)note{
    NSDictionary *userInfo = note.userInfo;
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(AdaptedWidth(10));
            make.right.mas_equalTo(_superView).mas_equalTo(-AdaptedWidth(10));
            make.centerY.mas_equalTo(_superView);
            make.height.mas_equalTo(AdaptedWidth(240));
            
        }];
        
    }];
}
#pragma mark -Setter/Getter

- (CustomPasswordView *)passwordView
{
    if (!_passwordView)
    {
        _passwordView = [[CustomPasswordView alloc] init];
        __weak typeof(self) weakSelf = self;
        _passwordView.completionBlock = ^(NSString *password) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if ([strongSelf.delegate respondsToSelector:@selector(didPasswordInputFinished:)])
            {
                [strongSelf.delegate didPasswordInputFinished:password];
            }
        };
    }
    return _passwordView;
}

- (UIView *)superView
{
    if (!_superView)
    {
        _superView = [[UIView alloc] init];
    }
    return _superView;
}

- (UIView *)payPopupView
{
    if (!_payPopupView)
    {
        _payPopupView = [[UIView alloc] init];
        _payPopupView.backgroundColor = [UIColor whiteColor];
    }
    return _payPopupView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = TitleBlackColor;
        _titleLabel.font = AdaptedFontSize(15);
        _titleLabel.text = NSLocalizedString(@"输入短信验证码", nil);
    }
    return _titleLabel;
}

- (UILabel *)phoneLabel
{
    if (!_phoneLabel)
    {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.textColor = TitleBlackColor;
        _phoneLabel.font = AdaptedFontSize(15);
    }
    return _phoneLabel;
}
- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = [UIColor redColor];
        _tipLabel.font = AdaptedFontSize(12);
        _tipLabel.text = NSLocalizedString(@"验证码错误", nil);
        //默认隐藏
        _tipLabel.hidden = YES;
    }
    return _tipLabel;
}


- (UIButton *)closeButton
{
    if (!_closeButton)
    {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(hidePayPopView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}


- (UIButton *)authBtn
{
    if (!_authBtn)
    {
        _authBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_authBtn setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateNormal];
        [_authBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _authBtn.titleLabel.font = AdaptedFontSize(15);
        [_authBtn addTarget:self action:@selector(authBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _authBtn;
}


@end
