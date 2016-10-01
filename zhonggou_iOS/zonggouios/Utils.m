//
//  Utils.m
//  TestApplication
//
//  Created by 潘鸿吉 on 13-4-22.
//  Copyright (c) 2013年 潘鸿吉. All rights reserved.
//

#import "Utils.h"
#import "Reachability.h"

@implementation Utils

//获取系统日期时间
+(NSString *)getSystemDataTime{
    NSDate *senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    NSString *morelocationString=[dateformatter stringFromDate:senddate];
    
    return morelocationString;
}


+ (BOOL) isIphoneSimulator
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"i386"]) return YES;
    if ([platform isEqualToString:@"x86_64"]) return YES;
    
    return NO;
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

+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

//

+(UITextField *)getCustomMiddleTextField:(NSString *)string{
    UIImage *image = [UIImage imageNamed:@"input_text_bk.png"];
    UITextField *baseTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, image.size.width/2.0, image.size.height/2.0)];
    [baseTextField setBackgroundColor:[UIColor clearColor]];
    [baseTextField setFont:[UIFont systemFontOfSize:15]];
    [baseTextField setTextColor:[UIColor orangeColor]];
    [baseTextField setPlaceholder:string];
    baseTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [baseTextField setBorderStyle:UITextBorderStyleNone];
    baseTextField.background = [UIImage imageNamed:@"input_text_bk.png"];
    [baseTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    baseTextField.leftView = paddingView;
    baseTextField.leftViewMode = UITextFieldViewModeAlways;
    baseTextField.returnKeyType = UIReturnKeyDone;
    
    return baseTextField;
}
+(UITextField *)getCustomSmallTextField:(NSString *)string{
    UIImage *image = [UIImage imageNamed:@"input_text_bk_small.png"];
    UITextField *baseTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, image.size.width/2.0, image.size.height/2.0)];
    [baseTextField setBackgroundColor:[UIColor clearColor]];
    [baseTextField setFont:[UIFont systemFontOfSize:15]];
    [baseTextField setTextColor:[UIColor orangeColor]];
    [baseTextField setPlaceholder:string];
    baseTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [baseTextField setBorderStyle:UITextBorderStyleNone];
    baseTextField.background = [UIImage imageNamed:@"input_text_bk_small.png"];
    [baseTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    baseTextField.leftView = paddingView;
    baseTextField.leftViewMode = UITextFieldViewModeAlways;
    baseTextField.returnKeyType = UIReturnKeyDone;
    
    return baseTextField;
}
+(UITextField *)getCustomLongTextField:(NSString *)string{
    UIImage *image = [UIImage imageNamed:@"input_text_bk_long.png"];
    UITextField *baseTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, image.size.width/2.0, image.size.height/2.0)];
    [baseTextField setBackgroundColor:[UIColor clearColor]];
    [baseTextField setFont:[UIFont systemFontOfSize:15]];
    [baseTextField setTextColor:[UIColor orangeColor]];
    [baseTextField setPlaceholder:string];
    baseTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [baseTextField setBorderStyle:UITextBorderStyleNone];
    baseTextField.background = [UIImage imageNamed:@"input_text_bk_long.png"];
    [baseTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    baseTextField.leftView = paddingView;
    baseTextField.leftViewMode = UITextFieldViewModeAlways;
    baseTextField.returnKeyType = UIReturnKeyDone;
    
    return baseTextField;
}
+(UITextView *)getCustomBigTextView:(NSString *)string{
    UIImage *image = [UIImage imageNamed:@"input_text_bk_big.png"];
    UITextView *baseTextField = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, image.size.width/2.0, image.size.height/2.0)];
    [baseTextField setBackgroundColor:[UIColor clearColor]];
    [baseTextField setFont:[UIFont systemFontOfSize:15]];
    [baseTextField setTextColor:[UIColor orangeColor]];
    image = [Utils scaleImage:image toScale:0.5];
    UIColor *color = [UIColor colorWithPatternImage:image];
    baseTextField.backgroundColor = color;
    //    [textView addSubview: imgView];
    //    [textView sendSubviewToBack: imgView];
    baseTextField.returnKeyType = UIReturnKeyDone;
    
    return baseTextField;
}

+(UILabel *)getBaseTitleLabel:(NSString *)string{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 240, 21)];
    label.textColor = [UIColor orangeColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = string;
    
    return label;
}

+(UIButton *)getCustomLongButton:(NSString *)string{
    UIImage *image = [UIImage imageNamed:@"button_up.png"];
    UIButton *baseButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, image.size.width/2.0, image.size.height/2.0)];
    baseButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [baseButton setTitle:string forState:UIControlStateNormal];
    [baseButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [baseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [baseButton setBackgroundImage:[UIImage imageNamed:@"button_up.png"] forState:UIControlStateNormal];
    [baseButton setBackgroundImage:[UIImage imageNamed:@"button_down.png"] forState:UIControlStateHighlighted];
    
    return baseButton;
}
+(UIButton *)getCustomShortButton:(NSString *)string{
    UIImage *image = [UIImage imageNamed:@"button_short_up.png"];
    UIButton *baseButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, image.size.width/2.0, image.size.height/2.0)];
    baseButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [baseButton setTitle:string forState:UIControlStateNormal];
    [baseButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [baseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [baseButton setBackgroundImage:[UIImage imageNamed:@"button_short_up.png"] forState:UIControlStateNormal];
    [baseButton setBackgroundImage:[UIImage imageNamed:@"button_short_down.png"] forState:UIControlStateHighlighted];
    
    return baseButton;
}
+(UIButton *)getCustomSmallButton:(NSString *)string{
    UIImage *image = [UIImage imageNamed:@"button_small_up.png"];
    UIButton *baseButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, image.size.width/2.0, image.size.height/2.0)];
    baseButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [baseButton setTitle:string forState:UIControlStateNormal];
    [baseButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [baseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [baseButton setBackgroundImage:[UIImage imageNamed:@"button_small_up.png"] forState:UIControlStateNormal];
    [baseButton setBackgroundImage:[UIImage imageNamed:@"button_small_down.png"] forState:UIControlStateHighlighted];
    
    return baseButton;
}
+(UIButton *)getCustomPointButton:(NSString *)string{
    UIImage *image = [UIImage imageNamed:@"button_getpoint_up.png"];
    UIButton *baseButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, image.size.width/2.0, image.size.height/2.0)];
    baseButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [baseButton setTitle:string forState:UIControlStateNormal];
    [baseButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [baseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [baseButton setBackgroundImage:[UIImage imageNamed:@"button_getpoint_up.png"] forState:UIControlStateNormal];
    [baseButton setBackgroundImage:[UIImage imageNamed:@"button_getpoint_down.png"] forState:UIControlStateHighlighted];
    
    return baseButton;
}


@end
