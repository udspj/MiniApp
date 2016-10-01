//
//  WebpageView.h
//  zonggouios
//
//  Created by sunpeijia on 14-2-15.
//  Copyright (c) 2014年 sunpeijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebpageView : UIView<UIWebViewDelegate>{
    UIWebView *webView;
}

@property(nonatomic,retain)UIButton *bkbtn;

-(void)openOverlayWebpage;

@end
