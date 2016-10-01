//
//  ViewController.m
//  zonggouios
//
//  Created by sunpeijia on 14-2-15.
//  Copyright (c) 2014年 sunpeijia. All rights reserved.
//

#import "ViewController.h"
#import "QRcodeViewController.h"
#import "shareViewController.h"
#import "aboutusViewController.h"
#import "cameraViewController.h"
#import "estoreViewController.h"
#import "estoreCell.h"
#import "MapViewController.h"
#import "webpageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavBar];
    [self initWebview];
    [self initTabbutton];
    
    overlay = [[WebpageView alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.navigationController.view addSubview:overlay];
    [overlay openOverlayWebpage];
    
    ddview = [[dropdownView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-106, 0, 106, 200)];
    [self.view addSubview:ddview];
    ddview.hidden = YES;
    ddview.tableArray = [NSArray arrayWithObjects:@"扫描二维码", @"分享好友", @"关于我们", @"检查新版本", nil];
    ddview.delegate = self;
    
    
    myTableView.frame = CGRectMake(0, 32, SCREEN_WIDTH, SCREEN_HEIGHT-45-44-20-32);
    [self getWhichPageParam:kPAGE_MAIN_MALL];
    [self getDate:NO];
}
-(void)didSelectRow:(int)rownum{
    switch (rownum) {
        case 0:{
            QRcodeViewController *vc = [[QRcodeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:{
            shareViewController *vc = [[shareViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:{
            aboutusViewController *vc = [[aboutusViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:{
            
            break;
        }
        default:
            break;
    }
    ddview.hidden = YES;
}

-(void)initNavBar{
    UIImage *img1 = [UIImage imageNamed: @"draw_icon.png"];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setBackgroundImage:img1 forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(showoverlay) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(0, 0, img1.size.width/2.0 , img1.size.height/2.0);
    UIBarButtonItem *menuButton1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    self.navigationItem.leftBarButtonItem = menuButton1;
    
    UIImage *img2 = [UIImage imageNamed: @"coll_icon_n.png"];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setBackgroundImage:img2 forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(showtoollist) forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(0, 0, img1.size.width/2.0 , img1.size.height/2.0);
    UIBarButtonItem *menuButton2 = [[UIBarButtonItem alloc] initWithCustomView:button2];
    self.navigationItem.rightBarButtonItem = menuButton2;
}
-(void)showoverlay{
    [UIView beginAnimations:@"filpping" context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [overlay setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [UIView commitAnimations];
    [overlay openOverlayWebpage];
}
-(void)showtoollist{
    if (ddview.hidden) {
        ddview.hidden = NO;
    }else{
        ddview.hidden = YES;
    }
}

-(void)initWebview{
    url0 = [NSURL URLWithString:@"http://www.baidu.com"];
    url1 = [NSURL URLWithString:@"http://www.baidu.com"];
    url2 = [NSURL URLWithString:@"http://www.baidu.com"];
    url3 = [NSURL URLWithString:@"http://www.baidu.com"];
    url4 = [NSURL URLWithString:@"http://www.baidu.com"];
    urlerror = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"error" ofType:@"html" inDirectory:@"error"]];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-45-44-20)];
    if (![Utils checknetwork]) {
        [webView loadRequest:[NSURLRequest requestWithURL:urlerror]];
    }else{
        [webView loadRequest:[NSURLRequest requestWithURL:url0]];
    }
    webView.scalesPageToFit = YES;
    webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:webView];
}

#pragma mark 底部3个分类按钮

- (void)initTabbutton{
    
    myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myButton.tag = 0;
    [myButton setFrame:CGRectMake(SCREEN_WIDTH/4 * 0, SCREEN_HEIGHT-44-20-90/2, SCREEN_WIDTH/4, 90/2)];
    [myButton setImage:[UIImage imageNamed:@"xiadaohangiconhuise_01.png"] forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(selectwhichtab:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myButton];
    
    locButton = [UIButton buttonWithType:UIButtonTypeCustom];
    locButton.tag = 1;
    [locButton setFrame:CGRectMake(SCREEN_WIDTH/4 * 1, SCREEN_HEIGHT-44-20-90/2, SCREEN_WIDTH/4, 90/2)];
    [locButton setImage:[UIImage imageNamed:@"xiadaohangiconhuise_02.png"] forState:UIControlStateNormal];
    [locButton addTarget:self action:@selector(selectwhichtab:) forControlEvents:UIControlEventTouchUpInside];
    [locButton setSelected:YES];
    [self.view addSubview:locButton];
    
    shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shopButton.tag = 2;
    [shopButton setFrame:CGRectMake(SCREEN_WIDTH/4 * 2, SCREEN_HEIGHT-44-20-90/2, SCREEN_WIDTH/4, 90/2)];
    [shopButton setImage:[UIImage imageNamed:@"xiadaohangiconhuise_03.png"] forState:UIControlStateNormal];
    [shopButton addTarget:self action:@selector(selectwhichtab:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shopButton];
    
//    favButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    favButton.tag = 3;
//    [favButton setFrame:CGRectMake(SCREEN_WIDTH/5 * 3, SCREEN_HEIGHT-44-20-90/2, SCREEN_WIDTH/5, 90/2)];
//    [favButton setImage:[UIImage imageNamed:@"xiadaohangiconhuise_04.png"] forState:UIControlStateNormal];
//    [favButton addTarget:self action:@selector(selectwhichtab:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:favButton];
    
    cardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cardButton.tag = 3;//4;
    [cardButton setFrame:CGRectMake(SCREEN_WIDTH/4 * 3, SCREEN_HEIGHT-44-20-90/2, SCREEN_WIDTH/4, 90/2)];
    [cardButton setImage:[UIImage imageNamed:@"xiadaohangiconhuise_05.png"] forState:UIControlStateNormal];
    [cardButton addTarget:self action:@selector(selectwhichtab:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cardButton];
}

-(void)selectwhichtab:(id)sender{
    if (![Utils checknetwork]) {
        [webView loadRequest:[NSURLRequest requestWithURL:urlerror]];
        return;
    }
    [webView setHidden:NO];
    switch ([sender tag]) {
        case 0:
            [webView loadRequest:[NSURLRequest requestWithURL:url0]];
            break;
        case 1:
            //[webView loadRequest:[NSURLRequest requestWithURL:url1]];
            [webView setHidden:YES];
            break;
        case 2:
            [webView loadRequest:[NSURLRequest requestWithURL:url2]];
            break;
        case 3:
//            [webView loadRequest:[NSURLRequest requestWithURL:url3]];
//            break;
//        case 4:
            [webView loadRequest:[NSURLRequest requestWithURL:url4]];
            break;
            
        default:
            break;
    }
}







#pragma mark 获取数据 非初始化
-(void)refreshDataAfterGetdata{
    [[NetManager sharedManager] getEstoreListWithCoord_x : [[UserInfo sharedManager] coordX]
                                                 coord_y : [[UserInfo sharedManager] coordY]
                                                 pageNum : currentPage
                                                  param0 : param0
                                                  param1 : param1
                                                  success:^(id response){
                                                      NSLog(@"response %@",response);
                                                      if ([[response objectForKey:@"result"] count]==0) {
                                                          [ShowBox showError:@"没有对应的内容"];
                                                          return;
                                                      }
                                                      pagetotal=[[response objectForKey:@"page_total"] integerValue];
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
    cell.title.text = [[listArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.content.text = [[listArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.address.text = [[listArray objectAtIndex:indexPath.row] objectForKey:@"addr"];
    cell.btn.tag = indexPath.row;
    [cell.btn addTarget:self action:@selector(btngotomap:) forControlEvents:UIControlEventTouchUpInside];
    cell.distance.text = [[listArray objectAtIndex:indexPath.row] objectForKey:@"distance"];
    [cell.icon setImageWithURL:[NSURL URLWithString:[[listArray objectAtIndex:indexPath.row] objectForKey:@"thumb"]] placeholderImage:[UIImage imageNamed:@"defaulticon.png"]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
#pragma mark 页面跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    webpageViewController *mvc = [[webpageViewController alloc] init];
    mvc.weburl = @"http://www.baidu.com";
    [self.navigationController pushViewController:mvc animated:YES];
}
     
-(void)btngotomap:(id)sender{
    NSLog(@"%ld",(long)[sender tag]);
    int tagnum = [sender tag];
    MapViewController *mvc = [[MapViewController alloc] init];
    mvc.shoplo = [[[listArray objectAtIndex:tagnum] objectForKey:@"coordx"] floatValue];
    mvc.shopla = [[[listArray objectAtIndex:tagnum] objectForKey:@"coordy"] floatValue];
    [self.navigationController pushViewController:mvc animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
