//
//  loginViewController.h
//  zonggouios
//
//  Created by sunpeijia on 14-2-19.
//  Copyright (c) 2014年 sunpeijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : UIViewController<UITextFieldDelegate,UIWebViewDelegate>
{
    UIWebView *webView;
    
    BOOL isfirstopen;
}

@end
