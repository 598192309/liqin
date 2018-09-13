//
//  OptionDateView.h
//  IUang
//
//  Created by jayden on 2018/5/18.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^OptionDateViewBlcok) (NSDate * _Nullable date);
typedef void(^OptionDateViewHidenViewBlcok) (void);

@interface OptionDateView : UIView
@property (nonatomic,copy)OptionDateViewBlcok _Nullable optionDateViewBlcok;
@property (nonatomic,copy)OptionDateViewHidenViewBlcok _Nullable optionDateViewHidenViewBlcok;

+(void)viewShowWhiteBlock:(nullable void (^)(NSDate * _Nullable date))block viewHiden:(nullable void(^)(void))hidenBlock;


@end
