//
//  YelpModel.h
//  Yelp
//
//  Created by Bhargava, Rajat on 6/14/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "LocationModel.h"

@interface YelpModel : MTLModel <MTLJSONSerializing>

@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *ratingImgUrl;
@property(strong,nonatomic)NSString *ratingImgUrlSmall;
@property(strong,nonatomic)NSString *ratingImgUrlLarge;
@property(strong,nonatomic)NSNumber *reviewCount;
@property(strong,nonatomic)NSString *imageUrl;
@property(strong,nonatomic)NSArray  *categories;
@property(strong,nonatomic)LocationModel  *location;
@property(strong,nonatomic)NSString *snippetText;
@property(strong,nonatomic)NSString *displayPhone;




+(NSArray*)yelpModelsWithArray:(NSArray*)array;
-(NSString *) getStringReviewCount;
-(NSString *) getCategoryList; 



@end
