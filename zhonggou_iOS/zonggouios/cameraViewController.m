//
//  cameraViewController.m
//  zonggouios
//
//  Created by sunpeijia on 14-2-19.
//  Copyright (c) 2014年 sunpeijia. All rights reserved.
//

#import "cameraViewController.h"

@interface cameraViewController ()

@end

@implementation cameraViewController

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
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
//    if (buttonIndex == 0){
//        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }else if (buttonIndex == 1){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    }
    [self presentModalViewController:imagePicker animated:YES];
}

#pragma mark 系统相册代理方法
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //[NSDictionary dictionaryWithObject:[info objectForKey:@"UIImagePickerControllerEditedImage"] forKey:@"file"]
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
