//
//  
//  RongYi
//
//  Created by udspj on 13-10-15.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tagViewController.h"
#import "selectdownView.h"

#define kPAGE_MAIN_MALL @"kmainmall"

@interface selectViewController : baseViewController{
    
    
    NSArray *arrayNameDic;
    NSArray *arrayNameDicName;
    NSArray *arrayNameDicId;
    NSArray *arrayNameDicSecond;
    NSArray *arrayNameDicImg;
    
    int maxcount;
    CGSize arrowsize;
    
    NSString *param0;
    NSString *param1;
    NSString *param2;
    NSString *param3;
    NSString *param4;
    
    NSString *nameDic0;
    NSString *nameDic1;
    NSString *nameDic2;
    NSMutableString *nameDicName0;
    NSMutableString *nameDicName1;
    NSMutableString *nameDicName2;
    NSString *nameDicId0;
    NSString *nameDicId1;
    NSString *nameDicId2;
    NSString *nameDicSecond0;
    NSString *nameDicSecond1;
    NSString *nameDicSecond2;
}
@property(nonatomic,strong)NSObject *delegateobj;

@property(nonatomic,strong)NSMutableArray *btnarray;
@property(nonatomic,strong)NSMutableArray *arrowarray;
@property(nonatomic,strong)UIImage *upImage;
@property(nonatomic,strong)UIView *btnView;

@property(nonatomic,strong)UIView *bottomView;

@property(assign)int btntag;
@property(assign)int btncount;
@property(assign)CGSize btnsize;

@property(nonatomic,retain)NSMutableArray *listarray1;
@property(nonatomic,retain)NSMutableArray *listarray2;
@property(nonatomic,retain)NSMutableArray *listarray3;
@property(nonatomic,retain)NSMutableArray *listarray4;
@property(nonatomic,retain)NSMutableArray *listarray0;

@property(assign)BOOL hasSecondTable0;
@property(assign)BOOL hasSecondTable1;
@property(assign)BOOL hasSecondTable2;
@property(assign)BOOL hasSecondTable3;
@property(assign)BOOL hasSecondTable4;

@property(nonatomic,strong)selectdownView *selectoverlay;

-(void)setupSelectButton:(int)btnnum btnupImg:(UIImage *)btnupimg;
-(void)setupSelectOverlay;
-(void)setupButtonArrow;

-(void)getWhichPageParam:(NSString *)kpagename;
-(void)setInitParamValueWithNum:(int)paramnum nameStr:(NSString *)namestr idStr:(NSString *)idstr;

-(void)delegateChangeParam;

@end
