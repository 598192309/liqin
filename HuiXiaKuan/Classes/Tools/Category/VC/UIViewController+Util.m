//
//  UIViewController+Util.m
//  stock
//

//

#import "UIViewController+Util.h"

@implementation UIViewController (Util)
-(void)setGoBackOrDismissButtonAuto
{
    if([self.navigationController.viewControllers count]>1){
        [self setBackButton];
    }else{
        [self setCancelButton];
    }
}

-(void)dismissAutomatically
{
    if([self.navigationController.viewControllers count]>1){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)setBackButton
{
    UIBarButtonItem *leftButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"back"] highImage:[UIImage imageNamed:@"back"] target:self action:@selector(popViewControllerAnimated)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    

}
- (void)setBackButtonBlack{
    UIBarButtonItem *leftButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"back_"] highImage:[UIImage imageNamed:@"back_"] target:self action:@selector(popViewControllerAnimated)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    


}
-(void)setCancelButton
{
    UIBarButtonItem *leftButtonItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bar_icon_close"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissModalViewController)];
//    [leftButtonItem setTintColor:TP.barTintColor];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

- (void)setRightBarButtonWithImage:(UIImage*)image target:(id)aTarget action:(SEL)aAction
{
    UIBarButtonItem *ButtonItem =[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:aTarget action:aAction];
//    [ButtonItem setTintColor:TP.barTintColor];
    self.navigationItem.rightBarButtonItem = ButtonItem;
}

- (void)setLeftBarButtonWithImage:(UIImage*)image target:(id)aTarget action:(SEL)aAction
{
    UIBarButtonItem *ButtonItem =[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:aTarget action:aAction];
//    [ButtonItem setTintColor:TP.barTintColor];
    self.navigationItem.leftBarButtonItem = ButtonItem;
}

//-(void)showLoading
//{
//    [AV showTitle:NSLocalizedString(@"请求中...", nil) type:AlertTypeLoading];
//}


//-(void)hideLoading
//{
//    [AV hide];
//}

- (void)setRightBarButtonWithTitle:(NSString*)aTitle target:(id)aTarget action:(SEL)aAction
{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:aTitle style:UIBarButtonItemStylePlain target:self action:aAction];
}

//- (void)showError:(NSError *)error
//{
//    [AV showTitle:nil details:[Toolkit getErrorMsg:error]];
//}


//- (void)showText:(NSString*)str
//{
//    if(![str isKindOfClass:[NSString class]]){
//        return;
//    }
//    if ([str length] > 0) {
//        [AV showTitle:NSLocalizedString(@"提示", nil) details:str];
//    }
//}

-(void)popViewControllerAnimated
{
    [self selfWillPop];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissModalViewController
{
    [self selfWillPop];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)selfWillPop{
    
}



@end
