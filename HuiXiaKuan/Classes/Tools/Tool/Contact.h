//
//  Contact.h
//  contactlist
//
//  Created by Lqq on 16/8/23.
//  Copyright © 2016年 Lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@end
extern NSString *const NVMContactAccessAllowedNotification;//only received when asked for the first time and chose YES
extern NSString *const NVMContactAccessDeniedNotification;//only received when asked for the first time and chose NO
extern NSString *const NVMContactAccessFailedNotification;//only received when denied or restricted (not for the first time)

@interface NVMContact : NSObject
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *middleName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSArray *phoneNumbers;//NSString Collection
@end

@interface NVMContactManager : NSObject
+ (instancetype) manager;
- (void)loadAllPeople:(UIButton *)btn;
@property (nonatomic, strong, readonly) NSArray *allPeople;
@property(nonatomic,copy) void(^ContactUploadSucBlock)(NSString *msg);

@end
