//
//  GIFImage.h
//  RabiBird
//
//  Created by jayden on 2018/3/27.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GIFImage : NSObject
+ (GIFImage *)shareInstance;
@property (nonatomic, strong) UIImage * gifImage;
@end
