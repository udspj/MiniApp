//
//  WebpageView.m
//  zonggouios
//
//  Created by sunpeijia on 14-2-15.
//  Copyright (c) 2014年 sunpeijia. All rights reserved.
//

#import "WebpageView.h"
#import "AppDelegate.h"

@implementation WebpageView

@synthesize bkbtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        bkbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [bkbtn setBackgroundColor:[UIColor clearColor]];
        [bkbtn addTarget:self action:@selector(closeview) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bkbtn];
        
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH-50, SCREEN_HEIGHT)];
        webView.scalesPageToFit = YES;
        webView.backgroundColor = [UIColor whiteColor];
        webView.delegate = self;
        [self addSubview:webView];
    }
    return self;
}

-(void)openOverlayWebpage{
    NSURL *urlerror = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"error" ofType:@"html" inDirectory:@"error"]];
    if (![Utils checknetwork]) {
        [webView loadRequest:[NSURLRequest requestWithURL:urlerror]];
    }else{
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"api url/wap/index.php?moduleid=2"]]];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    BOOL hasauth = NO;
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSHTTPCookie *cookie;
    for (NSHTTPCookie *co in [cookieJar cookies]) {
        cookie = co;
        NSLog(@"cookiedelete %@",cookie);
        if ([[cookie.properties objectForKey:NSHTTPCookieName] isEqualToString:@"DYB_auth"]) {
            hasauth = YES;
        }
    }
    if (!hasauth) {
        [self closeview];
        
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies]) {
            [storage deleteCookie:cookie];
        }
        
        AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UINavigationController *viewController = (UINavigationController *)[appdelegate.nav.viewControllers objectAtIndex:0];
        [viewController.navigationController popToRootViewControllerAnimated:NO];
    }
}

-(void)closeview{
    [UIView beginAnimations:@"filpping" context:nil];
    [UIView setAnimationDuration:0.3f];
    [self setFrame:CGRectMake(-self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView commitAnimations];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
