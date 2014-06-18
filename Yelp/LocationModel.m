//
//  LocationModel.m
//  Yelp
//
//  Created by Bhargava, Rajat on 6/15/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "LocationModel.h"

@implementation LocationModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    //Model Variable : JSON Variable  
    return @{
             @"displayAddress":     @"display_address",
             @"crossStreets":     @"cross_streets",
//             @"ratingImgUrlLarge":         @"rating_img_url_large",
//             @"imageUrl":         @"image_url",
//             @"reviewCount":         @"review_count",
             // @"locationCoordinate": @"location",
             };
    
}


-(NSString *) getDisplayAddressList{
    NSMutableArray *addressListTemp = [NSMutableArray array];
    for (int count=0; count<2; count++) {
        [addressListTemp addObject:self.displayAddress[count]];
    }
    return [addressListTemp componentsJoinedByString:@", "];
    
}

@end
