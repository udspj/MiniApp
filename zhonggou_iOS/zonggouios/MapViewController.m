//
//  cViewController.m
//  EXxingbake
//
//  Created by admin on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "poimark.h"
#import "selfmark.h"

@implementation MapViewController

@synthesize shopla,shoplo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//-(void)getlocation{
//    locationManager = [[CLLocationManager alloc] init];//创建位置管理器
//    locationManager.delegate=self;
//    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
//    locationManager.distanceFilter=1000.0f;
//    
//    [locationManager startUpdatingLocation];//启动位置更新
//}
-(void)buildmap{
    mapview = [[MKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:mapview];
    span.latitudeDelta=0.1;
    span.longitudeDelta=0.1;
    coordinate.latitude = self.shopla;
    coordinate.longitude = self.shoplo;
    region.span = span;
    region.center = coordinate;
    //region.center = [[locationManager location] coordinate];
    [mapview setRegion:region];
    //locationManager.location.coordinate.latitude
    mapview.delegate = self;
    
    arrpoi = [[NSMutableArray alloc]init];
    
    CLLocationCoordinate2D shopcoord;
    shopcoord.latitude = self.shopla;
    shopcoord.longitude = self.shoplo;
    poimark *poishop = [[poimark alloc] initWithCoords:shopcoord];
    [arrpoi addObject:poishop];
    
    CLLocationCoordinate2D selfcoord;
    shopcoord.latitude = [[UserInfo sharedManager] coordY];
    shopcoord.longitude = [[UserInfo sharedManager] coordX];
    selfmark *poiself = [[selfmark alloc] initWithCoords:selfcoord];
    [arrpoi addObject:poiself];
    
    [mapview addAnnotations:arrpoi];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    if ([annotation isKindOfClass:[poimark class]])
    {
        MKAnnotationView *newAnnotation=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"anno"];
        newAnnotation.image = [UIImage imageNamed:@"shop.png"];
//        poimark *travellerAnnotation = (poimark *)annotation;
//        UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:travellerAnnotation.headimage]];
//        [imageview setFrame:CGRectMake(0, 0, 20, 20)];
//        newAnnotation.leftCalloutAccessoryView = imageview;
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        [btn addTarget:self action:@selector(gotodetailmap:) forControlEvents:UIControlEventTouchUpInside];
//        btn.tag = travellerAnnotation.tag;//在按钮事件里可获取某个tag标示，以拿到点击来源的btn
//        newAnnotation.rightCalloutAccessoryView = btn;
//        newAnnotation.canShowCallout=YES;
        newAnnotation.annotation = annotation;
        return newAnnotation;
    }
    if ([annotation isKindOfClass:[selfmark class]]) {
        MKAnnotationView *newAnnotation = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"sdf"];
        newAnnotation.canShowCallout=YES;
        newAnnotation.image = [UIImage imageNamed:@"self.png"];
        newAnnotation.annotation=annotation;
        return newAnnotation;
    }
    return Nil;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self getlocation];
    [self buildmap];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
