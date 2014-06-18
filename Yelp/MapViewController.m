//
//  MapViewController.m
//  Yelp
//
//  Created by Bhargava, Rajat on 6/17/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

#define METERS_PER_MILE 1609.344

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(onDoneButton)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    _mapView.delegate =self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CLLocationCoordinate2D centerLocation;
    
    centerLocation.latitude = [self.mapModel.centerLatitude doubleValue];
    centerLocation.longitude= [self.mapModel.centerLongitude doubleValue];
    //zoomLocation = _mapView.userLocation.coordinate;
    
    NSLog(@"latitude:%f",centerLocation.latitude);
    NSLog(@"longitude:%f",centerLocation.longitude);
    
    MKCoordinateSpan span;
    span.latitudeDelta=[self.mapModel.spanLatitudeDelta doubleValue];
    span.longitudeDelta=[self.mapModel.spanLongitudeDelta doubleValue];
    
    
    
    // 2
    MKCoordinateRegion viewRegion = viewRegion = MKCoordinateRegionMake(centerLocation,span);
    
    // 3
    [self.mapView setRegion:viewRegion animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Action Methods

-(void) onDoneButton {
     [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)plotYelpResults:(NSMutableArray *)yelpModel {
//    //    for (id<MKAnnotation> annotation in _mapView.annotations) {
//    //        [_mapView removeAnnotation:annotation];
//    //    }
//    
//    
//    for ( YelpModel *yelpModel in YelpModel) {
////        NSNumber * latitude = busStopInfo.lat;
////        NSNumber * longitude = busStopInfo.lon;
////        NSString * busStopName = yelpModel.name;
////       // NSString * busShortName = [self getShortBusNameInBusStopInfo:busStopInfo];
////        
////        CLLocationCoordinate2D coordinate;
////        coordinate.latitude = latitude.doubleValue;
////        coordinate.longitude = longitude.doubleValue;
////        MyLocation *annotation = [[MyLocation alloc] initWithBusName:busStopName stopsAway:busShortName coordinate:coordinate];
////        annotation.busStopNumber=busStopInfo.id;
////        [_mapView addAnnotation:annotation];
//	}
//}

@end
