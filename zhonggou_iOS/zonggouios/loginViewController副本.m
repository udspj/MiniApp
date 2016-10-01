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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *topbkimg= [UIImage imageNamed:@"navigationbar_bg.png"];
    [self.navigationController.navigationBar setBackgroundImage:topbkimg forBarMetrics:UIBarMetricsDefault];
    
    //用户名
    UILabel *namelabel = [Utils getBaseTitleLabel:@"用户名"];
    namelabel.frame = CGRectMake(12, 40, 51, 21);
    [self.view addSubview:namelabel];
    
    userNameText = [Utils getCustomMiddleTextField:@"请输入您的手机号或用户名"];
    userNameText.frame = CGRectMake(70, 35, userNameText.frame.size.width, userNameText.frame.size.height);
    userNameText.delegate = self;
    [self.view addSubview:userNameText];
    
    //密码
    UILabel *phonelabel = [Utils getBaseTitleLabel:@"密   码"];
    phonelabel.frame = CGRectMake(12, 90, 51, 21);
    [self.view addSubview:phonelabel];
    
    passWordText = [Utils getCustomMiddleTextField:@"请输入您的密码"];
    passWordText.frame = CGRectMake(70, 85, passWordText.frame.size.width, passWordText.frame.size.height);
    passWordText.delegate = self;
    [passWordText setSecureTextEntry:YES];
    [self.view addSubview:passWordText];
    
    //登陆按钮
    UIButton *btnNextStep = [Utils getCustomLongButton:@"登陆"];
    btnNextStep.frame = CGRectMake(SCREEN_WIDTH/2 - btnNextStep.frame.size.width/2, 182, btnNextStep.frame.size.width, btnNextStep.frame.size.height);
    [btnNextStep addTarget:self action:@selector(gotoLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnNextStep];
}

#pragma mark 登录
-(void)gotoLogin:(id)sender{
    ViewController *viewcontroller = [[ViewController alloc] init];
    [self.navigationController pushViewController:viewcontroller animated:YES];
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
