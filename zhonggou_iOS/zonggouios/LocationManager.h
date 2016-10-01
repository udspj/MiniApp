//
//  LocationManager.h
//  RongYi
//
//  Created by 潘鸿吉 on 13-6-26.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager *locManager;
}
+ (id)sharedManager;
- (void) initLocationManager;
@end
