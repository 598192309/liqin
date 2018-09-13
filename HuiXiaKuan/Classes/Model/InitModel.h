//
//  InitModel.h
//  IUang
//
//  Created by jayden on 2018/4/25.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import <Foundation/Foundation.h>
/**  Version*/
@interface VersionInfoItem : NSObject
@property(nonatomic,strong)NSString *lastest_version;// 最新的三位版本号,如 1.0.12
@property(nonatomic,strong)NSString *forced_upgrade; // 是否强制升级 false,
@property(nonatomic,strong)NSString *upgrade_msg;// 升级提示信息,如果带有{current_version}和{lastest_version},app端可以替换为当前版本号和最新版本@end
@property(nonatomic,strong)NSString *download_url; // 下载app的链接

@end
/**  引导页信息*/
@interface NewFeatureInfoItem : NSObject
@property(nonatomic,strong)NSString *update_time;
@property(nonatomic,strong)NSArray *data;
@end

/**  广告*/
@interface ADItem : NSObject
/**  */
@property(nonatomic,strong)NSString *id;
/**  广告名称*/
@property(nonatomic,strong)NSString *title;
/**  广告图片 */
@property(nonatomic,strong)NSString *photo;
/**广告链接 */
@property(nonatomic,strong)NSString *url;
/**  停留时间，单位为秒 */
@property(nonatomic,strong)NSString *pause_time;

/**  script */
@property(nonatomic,strong)NSString *script;

@end
@interface InitModel : NSObject
@property (nonatomic, assign) long status;
@property (nonatomic,strong) NSString *deal_types;  //null类型
@property (nonatomic,strong) NewFeatureInfoItem *guide_page;
@property (nonatomic,strong) VersionInfoItem *version;
@property (nonatomic,strong) ADItem *Init_ads;
@property (nonatomic,strong) NSString *borrow_list;  //null类型
@property (nonatomic, assign) long open_screenshot;
@property (nonatomic, assign) BOOL is_logined;
@property (nonatomic, assign) BOOL has_user_name;
@property (nonatomic,copy) NSString *user_name;
@property (nonatomic,strong) NSString *data;  //null类型
@property (nonatomic,strong) NSDictionary *customers;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,strong) NSString *adv_list;  //null类型
@property (nonatomic, assign) long ios_released;
@end
