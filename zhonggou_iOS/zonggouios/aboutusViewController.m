//
//  aboutusViewController.m
//  zonggouios
//
//  Created by sunpeijia on 14-2-17.
//  Copyright (c) 2014年 sunpeijia. All rights reserved.
//

#import "aboutusViewController.h"

@interface aboutusViewController ()

@end

@implementation aboutusViewController

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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 30)];
    label.text = @"东莞市众购网络有限公司";
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
