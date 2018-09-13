//
//  CommonBtn.m
//  IUang
//
//  Created by Lqq on 2018/4/20.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "CommonBtn.h"
@interface CommonBtn()
@property (nonatomic,strong)CAGradientLayer *disableLayer;
@property (nonatomic,strong)CAGradientLayer *ableLayer;
@property (nonatomic,strong)CAGradientLayer *selectedLayer;


@end
@implementation CommonBtn
#pragma mark - 生命周期
-(instancetype)init{
    if (self = [super init]) {
        [self configUI];
        
    }
    return self;
}
#pragma mark - ui
-(void)configUI{
//    [self setTitle:lqLocalized(@"Otorisasi", nil) forState:UIControlStateNormal];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = SemiboldFONT(15);
    ViewRadius(self, 5);
    [self.layer insertSublayer:self.ableLayer atIndex:0];

    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressTap:)];
    press.minimumPressDuration = 0.5;
    [self addGestureRecognizer:press];
}
- (void)setBtnEnable:(BOOL)btnEnable{
    self.enabled = btnEnable;
    if (btnEnable) {
        if (self.disableLayer.superlayer) {
            [self.disableLayer removeFromSuperlayer];
        }
        [self.layer insertSublayer:self.ableLayer atIndex:0];
    }else{
        if (self.ableLayer.superlayer) {
            [self.ableLayer removeFromSuperlayer];
        }
        [self.layer insertSublayer:self.disableLayer atIndex:0];

    }
}

- (void)setBtnSeleted:(BOOL)btnSeleted{
    self.selected = btnSeleted;
    
    if (btnSeleted) {
        if (self.disableLayer.superlayer) {
            [self.disableLayer removeFromSuperlayer];
        }
        if (self.ableLayer.superlayer) {
            [self.ableLayer removeFromSuperlayer];
        }
        [self.layer insertSublayer:self.selectedLayer atIndex:0];
    }else{
        if (self.selectedLayer.superlayer) {
            [self.selectedLayer removeFromSuperlayer];
        }
        if (self.enabled) {
            if (self.disableLayer.superlayer) {
                [self.disableLayer removeFromSuperlayer];
            }
            [self.layer insertSublayer:self.ableLayer atIndex:0];
        }else{
            if (self.ableLayer.superlayer) {
                [self.ableLayer removeFromSuperlayer];
            }
            [self.layer insertSublayer:self.disableLayer atIndex:0];
            
        }
    }

}
- (void)pressTap:(UILongPressGestureRecognizer *)tap{
    if (tap.state == UIGestureRecognizerStateEnded || tap.state == UIGestureRecognizerStateCancelled ) {
        self.titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        if (self.CommonBtnEndLongPressBlock) {
            self.CommonBtnEndLongPressBlock(self);
        }
    }else{
        self.titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    }
}

-(CAGradientLayer *)disableLayer{
    if (!_disableLayer) {
        NSArray *colorArray = @[(__bridge id)[UIColor colorWithHexString:@"#989c9e"].CGColor,(__bridge id)  [UIColor colorWithHexString:@"#989c9e"].CGColor];
        CAGradientLayer *layer = [CAGradientLayer new];
        layer.colors = colorArray;
        layer.startPoint = CGPointMake(0.0, 0.0);
        layer.endPoint = CGPointMake(0.5, 0);
        layer.frame = CGRectMake(0, 0, Main_Screen_Width - Adaptor_Value(20), Adaptor_Value(60));
        _disableLayer = layer;
    }
    return _disableLayer;
}

-(CAGradientLayer *)ableLayer{
    if (!_ableLayer) {
        NSArray *colorArray = @[(__bridge id)[UIColor colorWithHexString:@"#ffc600"].CGColor,(__bridge id)  [UIColor colorWithHexString:@"#ed8233"].CGColor];
        CAGradientLayer *layer = [CAGradientLayer new];
        layer.colors = colorArray;
        layer.startPoint = CGPointMake(0.0, 0.0);
        layer.endPoint = CGPointMake(0.5, 0);
        layer.frame = CGRectMake(0, 0, Main_Screen_Width - Adaptor_Value(20), Adaptor_Value(60));
        _ableLayer = layer;
    }
    return _ableLayer;
}

-(CAGradientLayer *)selectedLayer{
    if (!_selectedLayer) {
        NSArray *colorArray = @[(__bridge id)BlueJianbian1.CGColor,(__bridge id)  BlueJianbian2.CGColor];
        CAGradientLayer *layer = [CAGradientLayer new];
        layer.colors = colorArray;
        layer.startPoint = CGPointMake(0.0, 0.0);
        layer.endPoint = CGPointMake(0.5, 0);
        layer.frame = CGRectMake(0, 0, Main_Screen_Width - Adaptor_Value(20), Adaptor_Value(60));
        _selectedLayer = layer;
    }
    return _selectedLayer;
}

@end
