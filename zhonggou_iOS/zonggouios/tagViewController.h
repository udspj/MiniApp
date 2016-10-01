//
//  tagViewController.h
//  componenttest
//
//  Created by admin on 13-6-28.
//  Copyright (c) 2013年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"

@interface tagViewController : baseViewController{
    
}

@property(nonatomic,strong)NSMutableArray *btnarray;
@property(nonatomic,strong)UIView *btnView;
@property(nonatomic,strong)UIImage *upImage;
@property(nonatomic,strong)UIImage *downImage;
@property(nonatomic,strong)UIColor *upColor;
@property(nonatomic,strong)UIColor *downColor;
@property(nonatomic,strong)NSMutableArray *tagLabels;

//@property(nonatomic,strong)UIView *bottomView;

@property(nonatomic,assign)int btntag;
@property(nonatomic,assign)int btncount;
@property(nonatomic,assign)CGSize btnsize;
@property(nonatomic,assign)CGFloat fontsize;

-(void)buildTagButtons:(int)btnnum btnSize:(CGSize)btnsize btnupImg:(UIImage *)btnupimg;
-(void)dosomthingTagClicked:(UIButton *)clickedtag;


@end
