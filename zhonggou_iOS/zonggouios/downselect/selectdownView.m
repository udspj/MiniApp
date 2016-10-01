//
//  
//  RongYi
//
//  Created by udspj on 13-9-12.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import "selectdownView.h"
#import "selectModel.h"

#define VIEW_WIDTH (self.bounds.size.width)

@implementation selectdownView

@synthesize canopentable2;
@synthesize tagselect;
@synthesize imgArray;
@synthesize txtArray;
@synthesize didSelectDownAtRowDelegate;

@synthesize selectnum,selectrownum;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"selectdownView" owner:self options:nil];
        UIView *view = [views objectAtIndex:0];
		[self addSubview:view];
        
        imgArray = [[NSMutableArray alloc] initWithCapacity:10];
        txtArray = [[NSMutableArray alloc] initWithCapacity:10];
        
        canopentable2 = YES;
        whichtable = 0;
        
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.separatorColor = [UIColor grayColor];
        
        //[tableview reloadData];
        
        tableview2.delegate = self;
        tableview2.dataSource = self;
        tableview2.backgroundColor = [UIColor grayColor];
        [tableview2 setHidden:YES];
        
    }
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tableview) {
        return [txtArray count];
    }
    if (tableView == tableview2) {
        return row2num;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UIFont *font = [UIFont systemFontOfSize:15];
    cell.textLabel.font = font;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    selectModel *model;
    if (tableView == tableview) {
        model = (selectModel *)[txtArray objectAtIndex:indexPath.row];
        cell.textLabel.text = model.name;
        if (model.imgficon.length == 0) {
            cell.imageView.image = Nil;
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
        }else{
//            if (model.imgficon.length > 1) {
//                cell.imageView.image = [UIImage imageNamed:@"classify_0_n.png"];
//            }
//            if (model.imgficon.length > 20) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.imgficon]]];
//                });
//
        }
        
    }
    if (tableView == tableview2) {
        model = (selectModel *)[txtArray objectAtIndex:whichtable];
        cell.textLabel.text = [[model.secondarray objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
    }
    NSLog(@"model.secondarray %@",model.secondarray);

    return cell;
}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == tableview) {
        selectModel *model = (selectModel *)[txtArray objectAtIndex:indexPath.row];
        if (canopentable2) {
            whichtable = indexPath.row;
            row2num = [model.secondarray count];
            if (row2num == 0) {
                if (self.didSelectDownAtRowDelegate) {
                    self.didSelectDownAtRowDelegate(model.name,model.code);
                    [self setHidden:YES];
                }
                return;
            }
            [tableview2 reloadData];
        }else{
            if (self.didSelectDownAtRowDelegate) {
                self.didSelectDownAtRowDelegate(model.name,model.code);
                [self setHidden:YES];
            }
        }
    }
    if (tableView == tableview2) {
        selectModel *model = (selectModel *)[txtArray objectAtIndex:whichtable];
        if (self.didSelectDownAtRowDelegate) {
            //self.didSelectRowAtIndexPathDelegate([[model.secondarray objectAtIndex:indexPath.row] objectForKey:@"name"],indexPath.row,whichtable);
            self.didSelectDownAtRowDelegate([[model.secondarray objectAtIndex:indexPath.row] objectForKey:@"name"],[[model.secondarray objectAtIndex:indexPath.row] objectForKey:@"id"]);
            [self setHidden:YES];
        }
    }
    selectrownum = indexPath.row;
}

-(void)changejiantou:(int)posnum{
    [jiantouimg setFrame:CGRectMake(VIEW_WIDTH/selectnum * posnum + VIEW_WIDTH/6, jiantouimg.frame.origin.y, jiantouimg.frame.size.width, jiantouimg.frame.size.height)];
}

-(IBAction)selfhidden:(id)sender{
    [self setHidden:YES];
}

-(void)updateSelects{
    [tableview2 setHidden:YES];
    [tableview reloadData];
    if (canopentable2) {
        whichtable = 0;
        row2num = [[[txtArray objectAtIndex:0] secondarray] count];
        [tableview2 setHidden:NO];
        [tableview2 reloadData];
    }
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
