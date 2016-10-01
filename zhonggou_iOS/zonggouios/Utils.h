//
//  Utils.h
//  TestApplication
//
//  Created by 潘鸿吉 on 13-4-22.
//  Copyright (c) 2013年 潘鸿吉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/utsname.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject {
    
}

@property(assign) BOOL *hasnet;

//获取系统日期时间
+(NSString *)getSystemDataTime;
+ (BOOL) isIphoneSimulator;

+(BOOL)checknetwork;

+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

+(UITextField *)getCustomMiddleTextField:(NSString *)string;
+(UITextField *)getCustomSmallTextField:(NSString *)string;
+(UITextField *)getCustomLongTextField:(NSString *)string;
+(UITextView *)getCustomBigTextView:(NSString *)string;

+(UIButton *)getCustomLongButton:(NSString *)string;
+(UIButton *)getCustomShortButton:(NSString *)string;
+(UIButton *)getCustomSmallButton:(NSString *)string;
+(UIButton *)getCustomPointButton:(NSString *)string;

+(UILabel *)getBaseTitleLabel:(NSString *)string;

@end
