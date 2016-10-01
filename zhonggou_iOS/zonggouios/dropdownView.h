//
//  dropdownView.h
//  shzine
//
//  Created by admin on 12-12-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol popoverDelegate <NSObject>

-(void)didSelectRow:(int)rownum;

@end

@interface dropdownView : UIView<UITableViewDelegate,UITableViewDataSource> {
    UITableView *tableview;//下拉列表
    BOOL showList;//是否弹出下拉列表
    int theight;//table下拉列表的高度
}

@property (nonatomic,retain) NSArray *tableArray;

@property (assign, nonatomic) id<popoverDelegate> delegate;

@end
