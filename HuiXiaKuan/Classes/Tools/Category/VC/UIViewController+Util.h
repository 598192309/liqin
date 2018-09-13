//
//  UIViewController+Util.h
//  stock
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (Util)
- (void)setBackButton;
- (void)setBackButtonBlack;

- (void)setCancelButton;
- (void)setGoBackOrDismissButtonAuto;
-(void)dismissAutomatically;
//- (void) showLoading;
//-(void)showLoadingOnLandscape;
//- (void) hideLoading;
//- (void) showText:(NSString*)str;
//- (void) showError:(NSError*)error;
- (void) setRightBarButtonWithTitle:(NSString*)aTitle target:(id)aTarget action:(SEL)aAction;
- (void) setRightBarButtonWithImage:(UIImage*)image target:(id)aTarget action:(SEL)aAction;
- (void) setLeftBarButtonWithImage:(UIImage*)image target:(id)aTarget action:(SEL)aAction;


@end
