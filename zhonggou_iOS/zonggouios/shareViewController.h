//
//  YiJianFeedBackViewController.h
//  RongYi
//
//  Created by Nancy on 13-6-14.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface shareViewController : baseViewController<UITextViewDelegate,UITextFieldDelegate>{
    UITextView* myTextView;
    UILabel* myLabel;
    UITextField* myTextField;
}

-(void)tiJiao:(id)sender;

@end
