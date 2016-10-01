//
//  cViewController.h
//  EXxingbake
//
//  Created by admin on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate,MKAnnotation>
{
    CLLocationManager *locationManager;
    MKMapView *mapview;
    CLLocationCoordinate2D coordinate;
    MKCoordinateSpan span;
    MKCoordinateRegion region;
    
    NSMutableArray *arrpoi;
    NSNumber *num;
    
    int loopi;
}

@property(assign)float shopla;
@property(assign)float shoplo;

@end
