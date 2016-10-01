//
//  LocationManager.m
//  RongYi
//
//  Created by 潘鸿吉 on 13-6-26.
//  Copyright (c) 2013年 bluemobi. All rights reserved.
//

#import "LocationManager.h"
static LocationManager * _locationManager;
@implementation LocationManager


+ (id)sharedManager{
    if (!_locationManager) {
        _locationManager = [[LocationManager alloc]init];
    }
    
    return _locationManager;
}

- (void) initLocationManager
{
    if (locManager) {
        return;
    }
    locManager = [[CLLocationManager alloc] init];
    [locManager setDelegate:self];
    [locManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locManager startUpdatingLocation];
    [[UserInfo sharedManager]setCoordY:23.025];
    [[UserInfo sharedManager]setCoordX:113.760];
    //    [[UserInfo sharedManager]setCoordX:-1];
    //    [[UserInfo sharedManager]setCoordY:-1];
    [[UserInfo sharedManager] setCityName:@"上海市"];
    [[UserInfo sharedManager] setSubLocality:@"上海市"];
}

#pragma mark Location manager
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D loc = [newLocation coordinate];
    NSString *lat =[NSString stringWithFormat:@"%f",loc.latitude];//get latitude
    NSString *lon =[NSString stringWithFormat:@"%f",loc.longitude];//get longitude
    
//    NSLog(@"*********************** Location manager Delegate ***********************");
    UserInfo *_ui = [UserInfo sharedManager];
    if ([lat floatValue] != _ui.coordX) {
        //NSLog(@"coordX : %@" , lon);
        [_ui setCoordX:[lon floatValue]];
    }
    if ([lon floatValue] != _ui.coordY) {
        //NSLog(@"coordY : %@" , lat);
        [_ui setCoordY:[lat floatValue]];
    }
    if ([Utils isIphoneSimulator]) {
        //NSLog(@"isIphoneSimulator");
        [[UserInfo sharedManager]setCoordY:23.025];
        [[UserInfo sharedManager]setCoordX:113.760];
    }else{
        //NSLog(@"zhen ji qi");
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error)
         {
             //[[UserInfo sharedManager] setCityName:@"上海市"];
             return;
         }
         if(placemarks.count > 0)
         {
             //NSString *MyAddress = @"";
             NSString *city = @"";
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
//             if([placemark.addressDictionary objectForKey: @"FormattedAddressLines"] != NULL)
//                 MyAddress = [[placemark.addressDictionary objectForKey: @"FormattedAddressLines"] componentsJoinedByString: @", "];
//             else
//                 MyAddress = @"Address Not founded";
             
             NSLog(@"地址字典====%@",placemark.addressDictionary );
//             if([placemark.addressDictionary objectForKey: @"SubAdministrativeArea"] != NULL)
//                 city = [placemark.addressDictionary objectForKey: @"SubAdministrativeArea"];
//             else if([placemark.addressDictionary objectForKey: @"City"] != NULL)
//                 city = [placemark.addressDictionary objectForKey: @"City"];
//             else if([placemark.addressDictionary objectForKey: @"Country"] != NULL)
//                 city = [placemark.addressDictionary objectForKey: @"Country"];
            
//             NSLog(@"city====%@",[placemark.addressDictionary objectForKey: @"City"]);//city====上海市
//             if ([Utils systemVersion] < 6.0f) {
//                 if([placemark.addressDictionary objectForKey: @"City"] != NULL ){
//                     city = [placemark.addressDictionary objectForKey: @"City"];
//                     [[UserInfo sharedManager] setGpsCity:city];
//                 }
//             }else{
//                 if ([placemark administrativeArea]) {//[placemark locality]
//                     city = [placemark administrativeArea];
//                     [[UserInfo sharedManager] setGpsCity:[placemark administrativeArea]];
//                 }
//             }
             
             NSLog(@"setGpsCity placemark %@",city);//上海市
             //NSLog(@"%@", MyAddress);//中国上海市徐汇区虹桥路128号
             
//             [[UserInfo sharedManager] setCityName:city];
//             [[UserInfo sharedManager] setSubLocality:[NSString stringWithFormat:@"%@",[placemark.addressDictionary objectForKey:@"Street"]]];
         }
         else {
//             [[UserInfo sharedManager] setCityName:@"上海市"];
//             [[UserInfo sharedManager] setSubLocality:@"上海市"];
         }
     }];
    
 //   [[UserInfo sharedManager]setCoordX:[lat  floatValue]];
//    [[UserInfo sharedManager]setCoordY:[lon  floatValue]];
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    
    [[UserInfo sharedManager]setCoordY:31.19893];
    [[UserInfo sharedManager]setCoordX:121.443376];
//    [[UserInfo sharedManager]setCoordX:-1];
    //    [[UserInfo sharedManager]setCoordY:-1];
//    [[UserInfo sharedManager] setCityName:@"上海市"];
//    [[UserInfo sharedManager] setSubLocality:@"上海市"];
    
    NSLog(@"定位错误%@",error);
}

@end
