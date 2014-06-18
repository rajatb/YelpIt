//
//  MapModel.h
//  Yelp
//
//  Created by Bhargava, Rajat on 6/17/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MapModel : MTLModel <MTLJSONSerializing>

@property(strong, nonatomic) NSNumber *centerLatitude;
@property(strong, nonatomic) NSNumber *centerLongitude;
@property(strong, nonatomic) NSNumber *spanLatitudeDelta;
@property(strong, nonatomic) NSNumber *spanLongitudeDelta;

+(id)mapModelWithDictionary:(NSDictionary*)regions; 


@end
