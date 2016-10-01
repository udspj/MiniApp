//
//  ShowBox.m
//  RongYi
//
//  Created by BlueMobi BlueMobi on 13-6-26.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import "ShowBox.h"
#import "LoginViewController.h"
#import "Utils.h"
#import <MapKit/MapKit.h>
#import "Reachability.h"

@implementation ShowBox


+(void)showError:(NSString *)content
{

    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:content delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];

}

+(void)showSuccess:(NSString *)content

{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:content delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];

}


//检测网络状态
+(BOOL)checknetwork{
    BOOL isExistenceNetwork;
	Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
			isExistenceNetwork=FALSE;
            break;
        case ReachableViaWWAN:
			isExistenceNetwork=TRUE;
            break;
        case ReachableViaWiFi:
			isExistenceNetwork=TRUE;
            break;
    }
	if (!isExistenceNetwork) {
		UIAlertView *myalert = [[UIAlertView alloc] initWithTitle:@"网络错误"
                                                          message:@"无法链接网络，请检查网络是否正常"
                                                         delegate:self
                                                cancelButtonTitle:@"返回"
                                                otherButtonTitles:nil,nil];
		[myalert show];
	}
	return isExistenceNetwork;
}


@end
