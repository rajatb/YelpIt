//
//  LocationModel.h
//  Yelp
//
//  Created by Bhargava, Rajat on 6/15/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface LocationModel : MTLModel <MTLJSONSerializing>

@property(strong, nonatomic)NSArray *displayAddress;
@property(strong, nonatomic)NSString *crossStreets;

-(NSString *) getDisplayAddressList;


@end
