//
//  UserInfo.h
//  RongYi
//
//  Created by 潘鸿吉 on 13-6-4.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
+ (id)sharedManager;

@property (nonatomic , strong) NSString *loginName;
@property (nonatomic , strong) NSString *loginPassword;
@property (nonatomic , strong) NSString *memberCode;
@property (nonatomic , assign) float  coordX;//经度
//@property(nonatomic,retain)NSString *coordlo;
@property (nonatomic , assign) float  coordY;//纬度
//@property(nonatomic,retain)NSString *coordla;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *gpsCity;
@property (nonatomic,copy) NSString *isUserLogin;
@property (nonatomic,strong) NSString * SubLocality;

@property(nonatomic,copy)NSString *memberName;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *usualAddress;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *bindingPhone;
@property(nonatomic,copy)NSString *memberImg;//头像

@property (assign) int point;//积分

@end
