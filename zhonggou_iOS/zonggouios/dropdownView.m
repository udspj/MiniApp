//
//  dropdownView.m
//  shzine
//
//  Created by admin on 12-12-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "dropdownView.h"

@implementation dropdownView

@synthesize tableArray;

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        tableview = [[UITableView alloc] initWithFrame:CGRectMake(3, 17, frame.size.width-6, frame.size.height)];
        tableview.delegate = self;
        tableview.dataSource = self;  
        tableview.backgroundColor = [UIColor whiteColor];
        tableview.separatorColor = [UIColor lightGrayColor];
        tableview.showsVerticalScrollIndicator = NO;
        tableview.scrollEnabled = NO;
        //tableview.hidden = YES;
        UIImageView *imgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popoverui.png"]];
        [self addSubview:imgview];
        [self addSubview:tableview];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [tableArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [delegate didSelectRow:indexPath.row];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
