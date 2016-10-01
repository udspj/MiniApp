//
//  
//  RongYi
//
//  Created by udspj on 13-10-15.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import "selectViewController.h"
#import "NetManager.h"

@interface selectViewController ()

@end

@implementation selectViewController

@synthesize selectoverlay,listarray1,listarray2,listarray3,listarray4,listarray0;
@synthesize btnarray,arrowarray,bottomView,btncount,btnsize,btntag,upImage,btnView;
@synthesize hasSecondTable0,hasSecondTable1,hasSecondTable2,hasSecondTable3,hasSecondTable4;

@synthesize delegateobj;

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
    
    btnarray = [[NSMutableArray alloc] initWithCapacity:5];
    arrowarray = [[NSMutableArray alloc] initWithCapacity:5];
    
    listarray0  = [[NSMutableArray alloc] initWithCapacity:20];
    listarray1  = [[NSMutableArray alloc] initWithCapacity:20];
    listarray2  = [[NSMutableArray alloc] initWithCapacity:20];
    listarray3  = [[NSMutableArray alloc] initWithCapacity:20];
    listarray4  = [[NSMutableArray alloc] initWithCapacity:20];
    
    hasSecondTable0 = NO;
    hasSecondTable1 = NO;
    hasSecondTable2 = NO;
    hasSecondTable3 = NO;
    hasSecondTable4 = NO;
    
    //    self.btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, btnsize.height)];
    //    [self.view addSubview:self.btnView];
    
    maxcount = 5;
    
    //初始化顶部三个按钮
    for (int i = 0; i < maxcount; i ++) {
        //UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * btnsize.width/2, 0, btnsize.width/2, btnsize.height/2)];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * (VC_WIDTH/maxcount+1), 0, VC_WIDTH/maxcount+1, 60/2)];
        btn.tag = i;
        [btn setTitle:@"分类" forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //[btn setBackgroundImage:upImage forState:UIControlStateNormal];
        [btn addTarget:delegateobj action:@selector(selectButtonWithTag:)forControlEvents:UIControlEventTouchUpInside];
        btn.enabled = NO;
        [self.btnarray addObject:btn];
        [self.view addSubview:[self.btnarray objectAtIndex:i]];
    }
    
    //初始化下拉列表
    self.selectoverlay = [[selectdownView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.selectoverlay.tagselect = 10;
    self.selectoverlay.selectnum = maxcount;
    [self.navigationController.view addSubview:self.selectoverlay];
    [self.selectoverlay setHidden:YES];
    
    //初始化按钮的箭头
    UIImage *arrowimg = [UIImage imageNamed:@"select_black.png"];
    for (int i = 0; i < maxcount; i ++) {
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VC_WIDTH/maxcount+1) - 20, self.btnsize.height/4 - arrowimg.size.height/4, arrowimg.size.width/2, arrowimg.size.height/2)];
        [arrowImageView setImage:arrowimg];
        [arrowarray addObject:arrowImageView];
        [[self.btnarray objectAtIndex:i] addSubview:[arrowarray objectAtIndex:i]];
    }
    arrowsize = arrowimg.size;
    
}

-(void)setupSelectButton:(int)btnnum btnupImg:(UIImage *)btnupimg{
    
    self.btncount = btnnum;
    self.upImage = btnupimg;
    self.btnsize = btnupimg.size;
    
    for (int i = 0; i < maxcount; i ++) {
        if (i < self.btncount) {
            [[self.btnarray objectAtIndex:i] setHidden:NO];
            [[self.btnarray objectAtIndex:i] setBackgroundImage:upImage forState:UIControlStateNormal];
            [[self.btnarray objectAtIndex:i] setBackgroundImage:upImage forState:UIControlStateDisabled];
            [[self.btnarray objectAtIndex:i] setFrame:CGRectMake(i * (VC_WIDTH/btnnum+1), 0, VC_WIDTH/btnnum+1, btnsize.height/2)];
            
            [[self.arrowarray objectAtIndex:i] setHidden:NO];
            [[self.arrowarray objectAtIndex:i] setFrame:CGRectMake((VC_WIDTH/btnnum+1) - 20, self.btnsize.height/4 - arrowsize.height/4, arrowsize.width/2, arrowsize.height/2)];
        }else{
            [[self.btnarray objectAtIndex:i] setHidden:YES];
            [[self.arrowarray objectAtIndex:i] setHidden:YES];
        }
    }
    
    self.selectoverlay.selectnum = self.btncount;
}

-(void)getKeynamesFromArray:(NSArray *)array paraNum:(int)paranum{
    int arraycount = [array count];
    NSMutableArray *modelarray = [[NSMutableArray alloc] initWithCapacity:20];
    
    for (int n = 0; n < arraycount; n ++) {
        selectModel *model = [[selectModel alloc] init];
        model.name = [array objectAtIndex:n];
        model.code = [NSString stringWithFormat:@"%d",n];
        [modelarray addObject:model];
    }
    [self setValue:modelarray forKey:[NSString stringWithFormat:@"listarray%d",paranum]];
    
    [[self.btnarray objectAtIndex:paranum] setEnabled:YES];
    
    [self delegateChangeParam];
}


#pragma mark -点击按钮－－顶部3个分类btn
- (void)selectButtonWithTag:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    [selectoverlay.txtArray removeAllObjects];
    
    switch (btn.tag) {
        case 0:{
            selectoverlay.canopentable2 = hasSecondTable0;
            [selectoverlay.txtArray addObjectsFromArray:listarray0];
        }
            break;
        case 1:{
            selectoverlay.canopentable2 = hasSecondTable1;
            [selectoverlay.txtArray addObjectsFromArray:listarray1];
        }
            break;
        case 2:{
            selectoverlay.canopentable2 = hasSecondTable2;
            [selectoverlay.txtArray addObjectsFromArray:listarray2];
        }
            break;
        case 3:{
            selectoverlay.canopentable2 = hasSecondTable3;
            [selectoverlay.txtArray addObjectsFromArray:listarray3];
        }
            break;
        case 4:{
            selectoverlay.canopentable2 = hasSecondTable4;
            [selectoverlay.txtArray addObjectsFromArray:listarray4];
        }
            break;
            
        default:
            break;
    }
    
    selectoverlay.tagselect = btn.tag;
    [selectoverlay changejiantou:btn.tag];
    [selectoverlay setHidden:NO];
    [selectoverlay updateSelects];
}


#pragma mark - //////////////////////////////////////////////////////////////////
#pragma mark - 选择该页面的筛选项
#pragma mark - //////////////////////////////////////////////////////////////////

-(void)getWhichPageParam:(NSString *)kpagename{
    for (int i = 0; i < maxcount; i ++) {
        [[self.btnarray objectAtIndex:i] setEnabled:NO];
        [self setValue:@(NO) forKey:[NSString stringWithFormat:@"hasSecondTable%d",i]];
    }
    if ([kpagename isEqualToString:kPAGE_MAIN_MALL]) {
        [self setPageParamMainMall];
    }
}

#pragma mark - 首页－商场
-(void)setPageParamMainMall{
    [self setupSelectButton:2 btnupImg:[UIImage imageNamed:@"select_tag_btn.png"]];
    [self getParamsArea:0];
    [self getParamsCategory:1];
}


#pragma mark - //////////////////////////////////////////////////////////////////
#pragma mark - 请求筛选项
#pragma mark - //////////////////////////////////////////////////////////////////

#pragma mark - 获取地区（二级）
-(void)getParamsArea:(int)ordernum{
    [self setInitParamValueWithNum:ordernum nameStr:@"行业" idStr:@"0"];
    [[NetManager sharedManager] getParam0ListWithSuccess:^(id responseDic) {
        NSLog(@"diqu:;%@",responseDic);
        //[[responseDic objectForKey:@"result"] insertObject:@"行业" atIndex:0];
        [[responseDic objectForKey:@"result"] setObject:@"行业" atIndex:0];
        [self getKeynamesFromArray:[responseDic objectForKey:@"result"] paraNum:ordernum];
    }
                                                   failure:^(id errorString) {
                                                       NSLog(@"errorString : %@" , errorString);
                                                   }];
    
//    NSArray *arr = [NSArray arrayWithObjects:@"行业", @"啊",@"爸爸吧",@"从此次",@"事实上",nil];
//    [self getKeynamesFromArray:arr paraNum:ordernum];
}
#pragma mark - 获取分类（二级，手动加个“全部分类”）
-(void)getParamsCategory:(int)ordernum{
    [self setInitParamValueWithNum:ordernum nameStr:@"距离" idStr:@"0"];
    [[NetManager sharedManager] getParam1ListWithSuccess:^(id responseDic) {
        NSLog(@"fenlei:;%@",responseDic);
        //[[responseDic objectForKey:@"result"] insertObject:@"距离" atIndex:0];
        [[responseDic objectForKey:@"result"] setObject:@"距离" atIndex:0];
        [self getKeynamesFromArray:[responseDic objectForKey:@"result"] paraNum:ordernum];
    }
                                                 failure:^(id errorString) {
                                                     NSLog(@"errorString : %@" , errorString);
                                                 }];
    
//    NSArray *arr = [NSArray arrayWithObjects:@"距离", @"sdafadsg",@"tghertw吧",nil];
//    [self getKeynamesFromArray:arr paraNum:ordernum];
}



#pragma mark - 手动设置筛选按钮的初始标题
-(void)setInitParamValueWithNum:(int)paramnum nameStr:(NSString *)namestr idStr:(NSString *)idstr{//设置筛选按钮的标题
    [self setValue:idstr forKey:[NSString stringWithFormat:@"param%d",paramnum]];
    [[self.btnarray objectAtIndex:paramnum] setTitle:namestr forState:UIControlStateNormal];
}
-(void)delegateChangeParam{
    
}
#pragma mark - 设置筛选按钮的标题格式
-(NSDictionary *)setUnchangeParamArray:(NSArray *)namearray idArray:(NSArray *)idarray{
    int midcount = [namearray count];
    NSMutableArray *midarray = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i = 0; i < midcount; i ++) {
        NSMutableDictionary *alldic = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[namearray objectAtIndex:i],[idarray objectAtIndex:i], nil] forKeys:[NSArray arrayWithObjects:@"name",@"id", nil]];
        [midarray addObject:alldic];
    }
    NSDictionary *middic = [NSDictionary dictionaryWithObject:midarray forKey:@"result"];
    return middic;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
