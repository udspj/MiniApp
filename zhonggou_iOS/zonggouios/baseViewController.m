//
//  baseViewController.m
//  RongYi
//
//  Created by udspj on 13-10-12.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import "baseViewController.h"

@interface baseViewController ()

@end

@implementation baseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    //[[NetManager sharedManager] cancelAllURLRequest];
}

@end
