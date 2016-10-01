//
//  UINavigationItem.m
//  shanghaizine
//
//  Created by admin on 13-5-17.
//  Copyright (c) 2013年 admin. All rights reserved.
//

@implementation UINavigationItem(UINavigationItemCategory)

-(void)setTitle:(NSString *)title
{
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setBackgroundColor:[UIColor clearColor]];
    [customLab setTextAlignment:NSTextAlignmentCenter];
    [customLab setText:title];
    customLab.font = [UIFont systemFontOfSize:20];
    self.titleView = customLab;
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc] init];
    back.title = @" ";
    UIImage *backbtn = [[UIImage imageNamed:@"back_btn_icon.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [back setBackButtonBackgroundImage:backbtn forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [back setStyle:UIBarButtonItemStyleBordered];
    self.backBarButtonItem = back;
}

@end

