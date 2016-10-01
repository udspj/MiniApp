//
//  ShowBox.h
//  RongYi
//
//  Created by BlueMobi BlueMobi on 13-6-26.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowBox : NSObject
+(void)showError:(NSString *)content;
+(BOOL)alertEmail:(NSString *)Email;
+(BOOL)alertPhoneNo:(NSString *)phoneNo;
+(BOOL)alertTextNull:(NSString *)text message:(NSString *)message;

+(void)showSuccess:(NSString *)content;
//判断是否登录  登录返回NO 不登录返回yes 有alert
+(BOOL)alertNoLogin;

//判断是否登录  登录返回yes 不登录返回no 无alert
+(BOOL) isLogin;

//判断字符串是否为空
+(BOOL)isstring:(NSString *)str;
+ (BOOL) alertYiJianFeedBack : (NSString*) str;
+(BOOL)alertEmail:(NSString *)Email require:(BOOL)require;
+(BOOL)alertPhoneNo:(NSString *)phoneNo require:(BOOL)require;
+(BOOL)alertPassWord:(NSString *)password;
+(BOOL)alertCardNo:(NSString *)cardNo require:(BOOL)require;
+(BOOL)alertNoLoginWithPush:(UIViewController *) view;
+(BOOL)alertNoLoginWithPushFromappDelegate:(UINavigationController *) view;
+(BOOL)alertLoginName:(NSString *)loginName require:(BOOL)require;

//检测网络状态
+(BOOL)checknetwork;

@end
