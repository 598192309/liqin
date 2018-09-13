//
//  UItextViewPlaceholder.h
//  TARANADA
//
//  Created by wen on 2017/8/17.
//  Copyright © 2017年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UItextViewPlaceholder : UITextView


@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, strong) UIFont * placeholderFont;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
