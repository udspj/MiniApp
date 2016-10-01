//
//  ViewController.h
//  zonggouios
//
//  Created by sunpeijia on 14-2-15.
//  Copyright (c) 2014年 sunpeijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebpageView.h"
#import "dropdownView.h"
#import "selectTableViewController.h"

@interface ViewController : selectTableViewController<popoverDelegate>{
    
    UIButton *locButton;
    UIButton *favButton;
    UIButton *cardButton;
    UIButton *shopButton;
    UIButton *myButton;
    
    NSURL *url0;
    NSURL *url1;
    NSURL *url2;
    NSURL *url3;
    NSURL *url4;
    NSURL *urlerror;
    
    UIWebView *webView;
    
    WebpageView *overlay;
    dropdownView *ddview;
    UIView *storeview;
}

//code4app.com/requirement/50e7e2616803fab247000004

@end
