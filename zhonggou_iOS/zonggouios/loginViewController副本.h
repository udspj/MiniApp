//
//  loginViewController.h
//  zonggouios
//
//  Created by sunpeijia on 14-2-19.
//  Copyright (c) 2014年 sunpeijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : baseViewController<UITextFieldDelegate>{
    
    UITextField *userNameText;
    UITextField *passWordText;
}

@end
