

#ifndef Constant_h
#define Constant_h 


// 应用苹果商店ID
#define APPLE_ID        @""
//APP名字
#define APP_NAME @"HuiXiaKuan"

// 应用版本号
#define APP_VERSION     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define APPDelegate     [UIApplication sharedApplication].delegate

#define APPlication    [UIApplication sharedApplication]

// 应用版本审核
#define APP_AUDIT_CONDICATION   @"1.0.0"

//base url
#ifdef DEBUG
#define SCE_HOST    @"http://test.api.iuang.rabibird.com"
#else

#define SCE_HOST    @"http://api.sxacn.com:8010/api"

#endif


// 注册通知
#define NOTIFY_ADD(_noParamsFunc, _notifyName)  [[NSNotificationCenter defaultCenter] \
addObserver:self \
selector:@selector(_noParamsFunc) \
name:_notifyName \
object:nil];

// 发送通知
#define NOTIFY_POST(_notifyName)   [[NSNotificationCenter defaultCenter] postNotificationName:_notifyName object:nil];
#define NOTIFY_POST_Dict(_notifyName, _dict) [[NSNotificationCenter defaultCenter] postNotificationName:_notifyName object:nil userInfo:_dict];


// 移除通知
#define NOTIFY_REMOVE(_notifyName) [[NSNotificationCenter defaultCenter] removeObserver:self name:_notifyName object:nil];
// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]


//中文字体
//#define CHINESE_FONT_NAME  @"Heiti SC"
#define CHINESE_FONT_NAME  @"Helvetica Neue"


#define CHINESE_SYSTEM(x) [UIFont fontWithName:CHINESE_FONT_NAME size:x]


//不同屏幕尺寸字体适配（375，667是因为效果图为IPHONE6 如果不是则根据实际情况修改）
#define kScreenWidthRatio  (LQScreemW / 375.0)
#define kScreenHeightRatio (LQScreemH / 667.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
#define AdaptedFontSize(R)    (IS_IPHONEX ? CHINESE_SYSTEM(AdaptedWidth(R)) :CHINESE_SYSTEM(AdaptedWidth(R)))
#define AdaptedBoldFontSize(R)    [UIFont boldSystemFontOfSize:R]

/*************** 颜色 *******************/
#define LQColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:1]
#define LQRandColor [UIColor colorWithHue:arc4random()% 255 / 255.0 saturation:arc4random()% 255 / 255.0 brightness:arc4random()% 255 / 255.0 alpha:1]


/*************** 尺寸 *******************/
#define LQScreemW [UIScreen mainScreen].bounds.size.width
#define LQScreemH [UIScreen mainScreen].bounds.size.height
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )480) < DBL_EPSILON )
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )667) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )736) < DBL_EPSILON )
#define IS_IPHONEX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define TabbarH  (IS_IPHONEX ? 83 : 49)
#define NavMaxY  (IS_IPHONEX ? 88 : 64)
#define SafeAreaTopHeight  (IS_IPHONEX ? 24 : 0) //导航栏 粪叉显示栏多了24
#define SafeAreaBottomHeight  (IS_IPHONEX ? 34 : 0) //导航栏 粪叉显示栏多了24

// 3.5英寸
#define is3Inch_Laters          [UIScreen mainScreen].bounds.size.height == 480
// 4英寸
#define is4Inch                 [UIScreen mainScreen].bounds.size.height == 568
// 4.7inch
#define is4Inch_Laters          [UIScreen mainScreen].bounds.size.height == 667
// 5.5inch
#define is5Inch_Laters          [UIScreen mainScreen].bounds.size.height == 736


// MainScreen Height&Width
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

// Screen adaptation to iphone6 as the standard
#define Screen_Adaptor_Scale    Main_Screen_Width/375.0f

#define Adaptor_Value(v)        (v)*Screen_Adaptor_Scale
#define BottomAdaptor_Value(v)       (IS_IPHONEX ? (v + 34)*Screen_Adaptor_Scale : (v)*Screen_Adaptor_Scale) 
/*************** 打印 *******************/

#define LQFunc LQLog(@"%s",__func__)

/*自定义Log*/
// 调试
#ifdef DEBUG
#define LQLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else
#define LQLog(...)

#endif

//#ifdef DEBUG
#define KHOST @"http://test.api.sxj360.com"

//#else
//#define KHOST @"https://app.api.rabibird.com"
//
//#endif


// 是否大于等于IOS7
#define isIOS7                  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
// 是否IOS6
#define isIOS6                  ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0)
// 是否大于等于IOS8
#define isIOS8                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=8.0)
// 是否大于IOS9
#define isIOS9                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0)
// 是否大于IOS9
#define isIOS10                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=10.0)

// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//#define AboveIOS9  ([UIDevice currentDevice].systemVersion.floatValue >= 9.0)


// 是否空对象
#define IS_NULL_CLASS(OBJECT) [OBJECT isKindOfClass:[NSNull class]]


//像素
#define kOnePX (1 / [UIScreen mainScreen].scale)


/**
 *  触发UIAlerView
 */
#define ALERT(_title_,_msg_) ([[[UIAlertView alloc] initWithTitle:_title_ message:_msg_ delegate:nil cancelButtonTitle:lqLocalized(@"Oke", nil) otherButtonTitles:nil, nil] show])
//国际化
#define lqLocalized(key,comment) NSLocalizedStringFromTable(key, @"lqlocal", comment)
#define lqStrings(string) NSLocalizedStringFromTable(string, @"lqlocal", nil)

//number转String
#define IntTranslateStr(int_str) [NSString stringWithFormat:@"%d",int_str];
#define FloatTranslateStr(float_str) [NSString stringWithFormat:@"%.2d",float_str];
/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self

/**阴影*/
#define ViewYellowGradient(view,farm) NSArray *colorArray = @[(__bridge id)[UIColor colorWithHexString:@"#ffc600"].CGColor,(__bridge id)  [UIColor colorWithHexString:@"#ed8233"].CGColor]; \
CAGradientLayer *layer = [CAGradientLayer new]; \
layer.colors = colorArray; \
layer.startPoint = CGPointMake(0.0, 0.0); \
layer.endPoint = CGPointMake(0.5, 0); \
layer.frame = farm; \
[view.layer insertSublayer:layer atIndex:0];

#define ViewGradient(view,color1,color2,farm) NSArray *colorArray = @[(__bridge id)[UIColor colorWithHexString:color1].CGColor,(__bridge id)  [UIColor colorWithHexString:color2].CGColor]; \
CAGradientLayer *layer = [CAGradientLayer new]; \
layer.colors = colorArray; \
layer.startPoint = CGPointMake(0.0, 0.0); \
layer.endPoint = CGPointMake(0.5, 0); \
layer.frame = farm; \
[view.layer insertSublayer:layer atIndex:0];
/**
 APP通用的一些设置
 */
#define BackGroundColor   [UIColor colorWithHexString:@"f8f8f8"]
// RGB颜色转换（16进制->10进制）
#define HexRGB(rgbValue)        HexRGBA(rgbValue, 1.0)

#define HexRGBA(rgbValue, a)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:(a)]

#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define TitleBlackColor   RGBCOLOR(34, 32, 32)
#define TitleGrayColor   RGBCOLOR(188, 188, 188)
#define BackGrayColor   [UIColor colorWithHexString:@"edf1f7"]
#define BackGroundColor   [UIColor colorWithHexString:@"edf1f7"]
#define BlueJianbian1   [UIColor colorWithHexString:@"02cfc1"]
#define BlueJianbian2   [UIColor colorWithHexString:@"28a4f0"]
#define YinYingColor   [UIColor colorWithHexString:@"dddddd" alpha:0.4]
#define TitleRedColor  RGBCOLOR(255, 62, 62)

#define ViewBackGroundColor [UIColor colorWithHexString:@"F0EFF5"]

// 主题色
#define Theme_Color     HexRGB(0xDC2E29)

// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)    [UIFont boldSystemFontOfSize:FONTSIZE]

#define SYSTEMFONT(FONTSIZE)        [UIFont systemFontOfSize:FONTSIZE]
#define Semibold_FONT_NAME  @"PingFangSC-Semibold"
#define Regular_FONT_NAME  @"PingFangSC-Regular"

#define SemiboldFONT(FONTSIZE)      [UIFont fontWithName:Semibold_FONT_NAME size:(Adaptor_Value(FONTSIZE))]
#define RegularFONT(FONTSIZE)      [UIFont fontWithName:Regular_FONT_NAME size:(Adaptor_Value(FONTSIZE))]
#define FONT(NAME, FONTSIZE)        [UIFont fontWithName:(NAME) size:(FONTSIZE)]

/**
 通知
 */
#define KNotification_ReLorigin @"KNotification_ReLorigin"//多人登录 在其他设备登录 需要重新登录

#define KNotification_ReLoriginSuccess @"KNotification_ReLoriginSuccess"//多人登录 在其他设备登录 需要重新登录  重新登录成功

#define KNotification_RegisterSuccess @"KNotification_RegisterSuccess"//注册成功 并登陆成功
#define KupdateUserInfoNotification @"KupdateUserInfoNotification"
#define KmodifyNameNotification  @"KmodifyNameNotification"


// 登录、登出
#define kUserSignIn         @"user_sign_in"
#define kUserSignOut        @"user_sign_out"
//用户信息
#define KMobile             @"KMobile"
#define KRealName             @"KRealName"
#define KQuota           @"KQuota"
#define KCustomer_qq            @"KCustomer_qq"
#define KCustomer_qq_link            @"KCustomer_qq_link"
#define KSaler_qq_link            @"KSaler_qq_link"
#define KPre_service_tel            @"KPre_service_tel"
#define KTel            @"KTel"
#define KIs_perfected            @"KIs_perfected"
#define KIs_vest            @"KIs_vest"
#define KLoanID            @"KLoanID"





#define KAuthorization            @"KAuthorization"

//额度测试结果
#define  KChangeEduResult   @"KChangeEduResult"

#endif
