//
//  
//  RongYi
//
//  Created by udspj on 13-12-6.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import "selectTableViewController.h"
#import "selectModel.h"

@interface selectTableViewController ()

@end

@implementation selectTableViewController

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
    
    myTableView = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 32, SCREEN_WIDTH, SCREEN_HEIGHT-20-44 -32) pullingDelegate:self];
    //myTableView.separatorColor = [Utils getViewBackgroundLightColor];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    [self.view addSubview:myTableView];
    
    listArray = [[NSMutableArray alloc] initWithCapacity:20];
    
    
#pragma  mark 获取选择结果
    __weak typeof(self) weekself = self;
    self.selectoverlay.didSelectDownAtRowDelegate = ^(NSString *name,NSString *code){
        typeof(self) strongself = weekself;
        int tagselect = weekself.selectoverlay.tagselect;
        [[weekself.btnarray objectAtIndex:tagselect] setTitle:name forState:UIControlStateNormal];
        [strongself setValue:code forKey:[NSString stringWithFormat:@"param%d",tagselect]];
        NSLog(@"%@",name);
        strongself->currentPage = 0;
        [weekself getDate:NO];
    };
    currentPage=0;
}

//-(void)setupSelectTagButtonData{
//
//    //[self getDate:NO];
//}


-(void)getDate:(BOOL)add{//yes是加载更多，no是删掉旧数据重新加载
    if (add) {
        currentPage++;
        if (currentPage>pagetotal && currentPage!=0) {
            return;
        }
    }else{
        currentPage=0;
        [listArray removeAllObjects];
    }
    
    [self refreshDataAfterGetdata];
}
-(void)refreshDataAfterGetdata{
    
}

#pragma mark - pullingRefreshTableView delegate
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    [self loadData];
}
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    refresh = YES;
    [self loadData];
}
#pragma mark - scrollView delegate
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [myTableView tableViewDidEndDragging:scrollView];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [myTableView tableViewDidScroll:scrollView];
}

- (void)loadData{
    if (refresh) {
        //下拉刷新
        refresh = NO;
        [myTableView tableViewDidFinishedLoading];
        [self getDate:NO];
        [myTableView reloadData];
    }else{
        //上拉加载
        [myTableView tableViewDidFinishedLoading];
        //more
        [self getDate:YES];
        [myTableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
