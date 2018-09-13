//
//  BaseWebViewController.m
//  IUang
//
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "BaseWebViewController.h"
#import "UIViewController+popBlock.h"

@interface BaseWebViewController ()<WKNavigationDelegate>
@property(nonatomic,strong)WKWebView *webView;

@end

@implementation BaseWebViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
-(WKWebView *)webView{
    if (_webView==nil) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, NavMaxY, LQScreemW, LQScreemH-NavMaxY-SafeAreaBottomHeight)];
        _webView.navigationDelegate = self;
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationView];

    [self.view addSubview:self.webView];
    [self showHUDToViewMessage:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [self.webView loadRequest:request];
    
    WEAKSELF;
    self.popBlock = ^(UIBarButtonItem *backItem){
        if ([weakSelf.webView canGoBack]) {
            [weakSelf.webView goBack];
        }else{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };

}
#pragma mark ----- WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation { // 类似UIWebView的 -webViewDidStartLoad:
    NSLog(@"didStartProvisionalNavigation");
}
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
        
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        
    }
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"didCommitNavigation");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation { // 类似 UIWebView 的 －webViewDidFinishLoad:
    NSLog(@"didFinishNavigation");
    if (webView.title.length > 0) {
        self.navigationTextLabel.text = webView.title;
    }
    [self removeHUD];
}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self removeHUD];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    // 类似 UIWebView 的- webView:didFailLoadWithError:
    
    NSLog(@"didFailProvisionalNavigation");
    
}


// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}


// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
    NSLog(@"4.%@",navigationAction.request);
//    NSString *url = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//- (BOOL)shouldAutorotate{
//    //是否允许转屏
//    BOOL result = [super shouldAutorotate];
//    return result;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    UIInterfaceOrientationMask result = [super supportedInterfaceOrientations];
//    //viewController所支持的全部旋转方向
//    return result;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    UIInterfaceOrientation result = [super preferredInterfaceOrientationForPresentation];
//    //viewController初始显示的方向
//    return result;
//}
- (void)dealloc
{
    NSLog(@"%s dealloc",object_getClassName(self));
}

- (BOOL)shouldAutorotate//是否支持旋转屏幕
{
    return YES;
}
//先隐藏
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations//支持哪些方向
//{
//    return UIInterfaceOrientationMaskLandscape;
//}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation//默认显示的方向
{
    return UIInterfaceOrientationLandscapeLeft;
}

@end
