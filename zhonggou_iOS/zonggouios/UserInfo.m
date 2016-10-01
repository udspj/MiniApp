//
//  UserInfo.m
//  RongYi
//
//  Created by 潘鸿吉 on 13-6-4.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import "UserInfo.h"

static UserInfo * _userInfo;

@implementation UserInfo
@synthesize loginName , loginPassword , memberCode ,coordX, coordY,cityName,isUserLogin,SubLocality,memberName,usualAddress,sex,phone,bindingPhone,memberImg,gpsCity,point;

#pragma mark - 获取单例
+ (id)sharedManager{
    if (!_userInfo) {
        _userInfo = [[UserInfo alloc]init];
    }
    
    return _userInfo;
}


@end
