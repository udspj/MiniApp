//
//  QRcodeViewController.h
//  RongYi
//
//  Created by sunpeijia on 13-11-10.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface QRcodeViewController : baseViewController<ZBarReaderDelegate,UIAlertViewDelegate>{
    NSString *urlstr;
    BOOL hasqrcode;
    NSArray *QRarray;
}

@end
