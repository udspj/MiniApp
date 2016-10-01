//
//  webpageViewController.m
//  RongYi
//
//  Created by udspj on 13-11-25.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import "webpageViewController.h"

@interface webpageViewController ()

@end

@implementation webpageViewController

@synthesize weburl,title;

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
    
    title = @"";
    self.navigationItem.title = title;
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20-44)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:weburl]]];
    webView.scalesPageToFit = YES;
    webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
