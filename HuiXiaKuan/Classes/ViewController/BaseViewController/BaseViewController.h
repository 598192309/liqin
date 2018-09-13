//
//  BaseViewController.h
//  IUang
//
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController
@property (nonatomic, assign) BOOL notFirstAppear;

@property (nonatomic, assign) BOOL isHideBackItem;
@property (nonatomic,strong) MBProgressHUD* hud;
/**
 在VC的view上加HUD，
 
 @param msg 显示的文本，nil为不显示任何文本
 */
- (void)showHUDToViewMessage:(NSString *)msg;

- (void)showHUDToWindowMessage:(NSString *)msg;

-(void)showHUD:(NSString*)msg;
-(void)showHUDToWindow:(NSString*)msg;

-(void)showErrorHUD:(id) resultObject;

- (void)removeHUD;
///右滑返回功能，默认开启（YES）
- (BOOL)gestureRecognizerShouldBegin;

-(NSString *)backItemImageName;


//添加导航栏
@property (nonatomic,strong) UIView * navigationView;
@property (nonatomic,strong) UIButton * navigationBackButton;
@property (nonatomic,strong) UIView * navigationbackgroundLine;
@property (nonatomic,strong) UILabel * navigationTextLabel;
@property (nonatomic,strong) UIButton * navigationRightBtn;
@property (nonatomic,strong) UIButton * navigationRightSecBtn;


-(void)addNavigationView;

@end
