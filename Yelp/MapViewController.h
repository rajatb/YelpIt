//
//  MapViewController.h
//  Yelp
//
//  Created by Bhargava, Rajat on 6/17/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "YelpModel.h"
#import "MapModel.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>
@property(strong, nonatomic)NSArray *yelpModels;
@property(strong, nonatomic)MapModel *mapModel;

@end
