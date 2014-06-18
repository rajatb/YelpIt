//
//  MapModel.m
//  Yelp
//
//  Created by Bhargava, Rajat on 6/17/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MapModel.h"

@implementation MapModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    //Model Variable : JSON Variable
    return @{
             @"centerLatitude":     @"center.latitude",
           @"centerLongitude":     @"center.longitude",
             @"spanLatitudeDelta":         @"span.latitude_delta",
             @"spanLongitudeDelta":         @"span.longitude_delta",
//             @"reviewCount":         @"review_count",
//             // @"locationCoordinate": @"location",
             };
    
}

+(id)mapModelWithDictionary:(NSDictionary*)regions
{
    MapModel *mapModel = [MTLJSONAdapter modelOfClass:self.class fromJSONDictionary:regions error:NULL];
    return mapModel;
}


@end
