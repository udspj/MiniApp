//
//  loginViewController.m
//  zonggouios
//
//  Created by sunpeijia on 14-2-19.
//  Copyright (c) 2014年 sunpeijia. All rights reserved.
//

#import "loginViewController.h"
#import "ViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    isfirstopen = YES;
    [self openOverlayWebpage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSLog(@"screenheight %f",[UIScreen mainScreen].bounds.size.height);
    
    NSLog(@"viewheight %f",self.view.frame.size.height);
    
    NSLog(@"viewheight %f",self.view.bounds.size.height);
    
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *topbkimg= [UIImage imageNamed:@"navigationbar_bg.png"];
    [self.navigationController.navigationBar setBackgroundImage:topbkimg forBarMetrics:UIBarMetricsDefault];
    
    isfirstopen = YES;
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    webView.scalesPageToFit = YES;
    webView.backgroundColor = [UIColor whiteColor];
    webView.delegate = self;
    [self.view addSubview:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    if (!isfirstopen) {
//        return;
//    }
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSHTTPCookie *cookie;
    for (NSHTTPCookie *co in [cookieJar cookies]) {
        cookie = co;
        NSLog(@"cookie %@ %@",cookie,[cookie.properties objectForKey:NSHTTPCookieName]);
        if ([[cookie.properties objectForKey:NSHTTPCookieName] isEqualToString:@"DYB_auth"]) {
            isfirstopen = NO;
            ViewController *vc = [[ViewController alloc] init];
            [self.navigationController pushViewController:vc animated:NO];
        }
    }
}

-(void)openOverlayWebpage{
    NSURL *urlerror = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"error" ofType:@"html" inDirectory:@"error"]];
    if (![Utils checknetwork]) {
        [webView loadRequest:[NSURLRequest requestWithURL:urlerror]];
    }else{
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"api url/wap/index.php?moduleid=2&action=login"]]];
    }
}

#pragma mark -textField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
