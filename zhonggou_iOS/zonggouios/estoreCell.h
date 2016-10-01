//
//  estoreCell.h
//  zonggouios
//
//  Created by sunpeijia on 14-2-23.
//  Copyright (c) 2014年 sunpeijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface estoreCell : UITableViewCell

@property(nonatomic,retain)UIImageView *icon;
@property(nonatomic,retain)UILabel *title;
@property(nonatomic,retain)UILabel *content;
@property(nonatomic,retain)UILabel *address;
@property(nonatomic,retain)UIButton *btn;
@property(nonatomic,retain)UILabel *distance;
@property(nonatomic,copy)NSString *surl;


@end
