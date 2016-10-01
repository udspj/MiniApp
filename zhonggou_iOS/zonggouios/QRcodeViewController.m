//
//  QRcodeViewController.m
//  RongYi
//
//  Created by sunpeijia on 13-11-10.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import "QRcodeViewController.h"

@interface QRcodeViewController ()

@end

@implementation QRcodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    hasqrcode = NO;
    
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE to: 0];
    [self presentModalViewController: reader animated: YES];
    
    UIImageView *qroverimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"13-touming.png"]];
    qroverimg.frame = CGRectMake(0, 0, qroverimg.frame.size.width/2, qroverimg.frame.size.height/2);
    [reader.view addSubview:qroverimg];
}

- (void) imagePickerController: (UIImagePickerController*)reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    if (hasqrcode) {
        return;
    }
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    //[reader dismissModalViewControllerAnimated: YES];
    
    //判断是否包含 头'http:'
    NSString *regex = @"http+:[^\\s]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    urlstr = symbol.data;
    if ([predicate evaluateWithObject:urlstr]) {
        NSLog(@"%@",urlstr);
        NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"www.rongyi.com"];
        NSPredicate *p2 = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",@"test.rongyi.com"];
        QRarray = [urlstr componentsSeparatedByString:@"/"];
        NSPredicate *type = [NSPredicate predicateWithFormat: @"SELF IN { 'malls', 'shops', 'activities' }"];
        if (([p evaluateWithObject:urlstr] || [p2 evaluateWithObject:urlstr]) && [QRarray count]==5 && [type evaluateWithObject:[QRarray objectAtIndex:3]]) {
            NSLog(@"%@",QRarray);
            //打印出来的信息
//            "http:",
//            "",
//            "www.rongyi.com",
//            malls,
//            5236ae116038b5c93f000001
            [reader dismissModalViewControllerAnimated:YES];
            [self.navigationController popViewControllerAnimated:NO];
            [self gotoDetailPageQianDao];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil
                                                            message:@"要打开二维码的网址吗？"
                                                           delegate:nil
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确认", nil];
            alert.delegate = self;
            [alert show];
            hasqrcode = YES;
        }
    }else{
        //[ShowBox showError:@"无法识别的二维码"];
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        hasqrcode = NO;
    }
    if (buttonIndex==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlstr]];
    }
}

-(void)gotoDetailPageQianDao{
 
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
