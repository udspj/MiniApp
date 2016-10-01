//
//  
//  RongYi
//
//  Created by udspj on 13-12-6.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullingRefreshTableView.h"
#import "selectViewController.h"

@interface selectTableViewController : selectViewController<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>{
    
    PullingRefreshTableView *myTableView;
    NSMutableArray *listArray;
    
//    NSString *param0;
//    NSString *param1;
//    NSString *param2;
    int currentPage;
    int pagetotal;
    BOOL refresh;
    
     // 以下全部要删掉的
//    NSDictionary *zonedic;
//    NSDictionary *catedic;
//    
//    NSString *nameDic0;
//    NSString *nameDic1;
//    NSString *nameDic2;
//    NSMutableString *nameDicName0;
//    NSMutableString *nameDicName1;
//    NSMutableString *nameDicName2;
//    NSString *nameDicId0;
//    NSString *nameDicId1;
//    NSString *nameDicId2;
//    NSString *nameDicSecond0;
//    NSString *nameDicSecond1;
//    NSString *nameDicSecond2;
    
}

-(void)refreshDataAfterGetdata;
-(void)getDate:(BOOL)add;

@end
