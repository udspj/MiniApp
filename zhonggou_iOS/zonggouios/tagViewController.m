//
//  tagViewController.m
//  componenttest
//
//  Created by admin on 13-6-28.
//  Copyright (c) 2013年 admin. All rights reserved.
//

#import "tagViewController.h"

@interface tagViewController ()

@end

@implementation tagViewController

@synthesize upImage;
@synthesize downImage;
@synthesize upColor;
@synthesize downColor;
@synthesize tagLabels;
@synthesize btntag;
@synthesize btncount;
//@synthesize bottomView;
@synthesize fontsize;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
	// Do any additional setup after loading the view.
    
    self.upColor = [UIColor grayColor];
    self.downColor = [UIColor whiteColor];
    self.fontsize = 12;
    _btnarray = [[NSMutableArray alloc] initWithCapacity:5];
}

-(void)buildTagButtons:(int)btnnum btnSize:(CGSize)btnsize btnupImg:(UIImage *)btnupimg{
    self.btncount = btnnum;
    self.upImage = btnupimg;
    self.btnsize = btnsize;
    int fixpx = 10;
    CGFloat maxspace = self.view.bounds.size.width / btnnum;
    CGFloat btnspace;
    if (btnsize.width > maxspace + fixpx) {
        btnspace = (self.view.bounds.size.width - (btnsize.width - maxspace)) / btnnum + 1;
    }else{// if (btnsize.width < maxspace - fixpx) {
        btnspace = (self.view.bounds.size.width + (maxspace - btnsize.width)) / btnnum + 1;
    }
    
//    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, btnsize.height, self.view.bounds.size.width, self.view.bounds.size.width - btnsize.height)];
//    [self.view addSubview:bottomView];
    _btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, btnsize.height)];
    [self.view addSubview:_btnView];
    
    if (tagLabels == Nil) {
        tagLabels = [[NSMutableArray alloc] initWithCapacity:btncount];
        for (int i = 0; i < btncount; i ++) {
            [tagLabels addObject:@""];
        }
    }
    for (int i = 0; i < btncount; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * btnspace, 0, btnsize.width, btnsize.height)];
        btn.tag = i;
        [btn setTitle:[tagLabels objectAtIndex:i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:fontsize]];
        [btn setTitleColor:upColor forState:UIControlStateNormal];
        [btn setBackgroundImage:upImage forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClicked:)forControlEvents:UIControlEventTouchUpInside];
        [_btnView addSubview:btn];
        [_btnarray addObject:btn];
        [_btnView sendSubviewToBack:btn];
    }
    [[_btnarray objectAtIndex:0] setTitleColor:downColor forState:UIControlStateNormal];
    if (downImage != Nil) {
        [[_btnarray objectAtIndex:0] setBackgroundImage:downImage forState:UIControlStateNormal];
    }
}
-(void)buttonClicked:(UIButton *)sender{
    btntag = sender.tag;
    for (int i = 0; i < btncount; i ++) {
        [[_btnarray objectAtIndex:i] setTitleColor:upColor forState:UIControlStateNormal];
        [[_btnarray objectAtIndex:i] setBackgroundImage:upImage forState:UIControlStateNormal];
        [_btnView sendSubviewToBack:[_btnarray objectAtIndex:i]];
    }
    [sender setTitleColor:downColor forState:UIControlStateNormal];
    [_btnView bringSubviewToFront:sender];
    if (downImage != Nil) {
        [sender setBackgroundImage:downImage forState:UIControlStateNormal];
    }
    [self dosomthingTagClicked:sender];
}
-(void)dosomthingTagClicked:(UIButton *)clickedtag{
    // do somthing when tag is clicked
}


//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
