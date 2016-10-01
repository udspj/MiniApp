//
//  YiJianFeedBackViewController.m
//  RongYi
//
//  Created by Nancy on 13-6-14.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import "shareViewController.h"

#define NUMBERS @"/-\\:;()$&!\",?<>[]{}#%^*+=|~€₤¥₣£／：；（）「」＂。，、？！'•＞＜〜" //屏蔽非字母数字字符
@interface shareViewController ()

@end

@implementation shareViewController

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
    
    [self.navigationItem setTitle:@"分享好友"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    //输入意见内容
    myTextView = [Utils getCustomBigTextView:@""];
    myTextView.frame = CGRectMake(self.view.frame.size.width/2 - myTextView.frame.size.width/2, 68, myTextView.frame.size.width, myTextView.frame.size.height);
    myTextView.delegate = self;
    [self.view addSubview:myTextView];
    
    //字数提示框
    UILabel *zishulabel = [[UILabel alloc] initWithFrame:CGRectMake(19, 243, 133, 21)];
    zishulabel.text = @"还可输入          字";
    zishulabel.font = [UIFont systemFontOfSize:15];
    zishulabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:zishulabel];
    
    myLabel = [[UILabel alloc]initWithFrame:CGRectMake(79, 243, 43, 21)];
    myLabel.textAlignment = UITextAlignmentCenter;
    [myLabel setBackgroundColor:[UIColor clearColor]];
    [myLabel setFont:[UIFont systemFontOfSize:15]];
    [myLabel setTextColor:[UIColor orangeColor]];
    [self.view addSubview:myLabel];
    [myLabel setText:@"300"];
    
    
    //提交按钮
    UIButton *btnNextStep = [Utils getCustomLongButton:@"提交"];
    btnNextStep.frame = CGRectMake(self.view.frame.size.width/2 - btnNextStep.frame.size.width/2, 323, btnNextStep.frame.size.width, btnNextStep.frame.size.height);
    [btnNextStep addTarget:self action:@selector(tiJiao:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnNextStep];
}


#pragma mark -  提交 button click
-(void)tiJiao:(id)sender{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"默认分享内容，没内容时显示"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.sharesdk.cn"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}


#pragma mark - textView delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    CGSize size = self.view.frame.size;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.3];
    [self.view setFrame:CGRectMake(0, -60, size.width, size.height)];
    [UIView commitAnimations];
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    CGSize size = self.view.frame.size;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.3];
    [self.view setFrame:CGRectMake(0, 0, size.width, size.height)];
    [UIView commitAnimations];
}
- (void)textViewDidChange:(UITextView *)textView{
    [myLabel setText:[NSString stringWithFormat:@"%d",300-[textView.text length]]];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];//换行符
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    if (location != NSNotFound){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - textField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGSize size = self.view.frame.size;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.3];
    [self.view setFrame:CGRectMake(0, -120, size.width, size.height)];
    [UIView commitAnimations];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    CGSize size = self.view.frame.size;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.3];
    [self.view setFrame:CGRectMake(0, 0, size.width, size.height)];
    [UIView commitAnimations];
}
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
