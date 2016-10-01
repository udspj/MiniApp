//
//  estoreViewController.m
//  zonggouios
//
//  Created by sunpeijia on 14-3-1.
//  Copyright (c) 2014年 sunpeijia. All rights reserved.
//

#import "estoreViewController.h"
#import "estoreCell.h"

@interface estoreViewController ()

@end

@implementation estoreViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getWhichPageParam:kPAGE_MAIN_MALL];
    [self getDate:NO];
}

#pragma mark 获取数据 非初始化
-(void)refreshDataAfterGetdata{
    [[NetManager sharedManager] getEstoreListWithCoord_x : [[UserInfo sharedManager] coordX]
                                                 coord_y : [[UserInfo sharedManager] coordY]
                                                 pageNum : currentPage
                                                  param0 : param0
                                                  param1 : param1
                                                        success:^(id response){
                                                            pagetotal=[[response objectForKey:@"page_total"] integerValue];
                                                            if ([[response objectForKey:@"result"] count]==0) {
                                                                return;
                                                            }
                                                            [listArray addObjectsFromArray:[response objectForKey:@"result"]];
                                                            [myTableView reloadData];
                                                        } failure:^(id response){
                                                            NSLog(@"附近response===%@",response);
                                                        }];
}

#pragma  mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"cell_sectionaa"];
    estoreCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[estoreCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma mark 页面跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
