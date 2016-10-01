//
//  
//  RongYi
//
//  Created by udspj on 13-9-12.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "selectModel.h"

typedef void (^didSelectDownAtRowDelegate) (NSString *,NSString *);

@interface selectdownView : UIView<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *tableview;
    IBOutlet UITableView *tableview2;
    IBOutlet UIImageView *jiantouimg;
    NSString *selectname;
    int whichtable;
    int row2num;
}

@property(assign)BOOL canopentable2;
@property (assign) int tagselect;
@property (assign) int selectnum;
@property (assign) int selectrownum;
@property (nonatomic,strong) NSMutableArray *imgArray;
@property (nonatomic,strong) NSMutableArray *txtArray;
@property (nonatomic,copy) didSelectDownAtRowDelegate didSelectDownAtRowDelegate;

@property (nonatomic,copy)NSString *selectname0;
@property (nonatomic,copy)NSString *selectname1;
@property (nonatomic,copy)NSString *selectname2;
@property (nonatomic,copy)NSString *selectname3;
@property (nonatomic,copy)NSString *selectname4;

@property(nonatomic,copy)NSString *secondlistname;

-(void)changejiantou:(int)posnum;

-(void)updateSelects;

-(IBAction)selfhidden:(id)sender;

@end
