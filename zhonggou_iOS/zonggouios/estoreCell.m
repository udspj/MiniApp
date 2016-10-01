//
//  estoreCell.m
//  zonggouios
//
//  Created by sunpeijia on 14-2-23.
//  Copyright (c) 2014年 sunpeijia. All rights reserved.
//

#import "estoreCell.h"

@implementation estoreCell

@synthesize title,address,distance,content,surl,icon,btn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        icon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 90, 60)];
        [self.contentView addSubview:icon];
        
        title = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 190, 16)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:title];
        
        content = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, 220, 16)];
        content.backgroundColor = [UIColor clearColor];
        content.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:content];
        
        address=[[UILabel alloc]initWithFrame:CGRectMake(100, 47 , 150, 15)];
        address.backgroundColor = [UIColor clearColor];
        address.font=[UIFont systemFontOfSize:14];
        [self addSubview:address];
        
        btn=[[UIButton alloc]initWithFrame:CGRectMake(100, 47 , 300, 15)];
        [self addSubview:btn];
        
        UIImage *lubiaoimg = [UIImage imageNamed:@"shop_pos.png"];
        UIImageView *loctionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(260, 50, lubiaoimg.size.width/2, lubiaoimg.size.height/2)];
        [self.contentView addSubview:loctionImageView];
        
        distance = [[UILabel alloc] initWithFrame:CGRectMake(265,50 , 120, 11)];
        distance.backgroundColor = [UIColor clearColor];
        distance.font=[UIFont systemFontOfSize:10];
        [self.contentView addSubview:distance];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
