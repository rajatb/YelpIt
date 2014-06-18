//
//  YelpModel.m
//  Yelp
//
//  Created by Bhargava, Rajat on 6/14/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YelpModel.h"
#import "LocationModel.h"

@implementation YelpModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    //Model Variable : JSON Variable 
    return @{
             @"ratingImgUrl":     @"rating_img_url",
             @"ratingImgUrlSmall":     @"rating_img_url_small",
             @"ratingImgUrlLarge":         @"rating_img_url_large",
             @"imageUrl":         @"image_url",
             @"reviewCount":         @"review_count",
             @"snippetText":     @"snippet_text",
             @"displayPhone":    @"display_phone",
             };
    
}

+ (NSValueTransformer *)locationJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:LocationModel.class];
}

//+ (NSValueTransformer *)ratingImgUrlURLJSONTransformer {
//    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
//}


+(NSArray*)yelpModelsWithArray:(NSArray*)array
{
    NSMutableArray *yelpModels = [[NSMutableArray alloc]init];
    
    for(NSDictionary* yelpDict in array){
        YelpModel *yelpModel = [MTLJSONAdapter modelOfClass:self.class fromJSONDictionary:yelpDict error:NULL];
        [yelpModels addObject:yelpModel];
        
    }
    return yelpModels;
}



-(NSString *) getStringReviewCount {
    return [NSString stringWithFormat:@"%@ Reviews",self.reviewCount];
}

-(NSString *) getCategoryList{
    NSMutableArray *categoriesArray = [NSMutableArray array];
    for (NSArray *subCategories in self.categories) {
        [categoriesArray addObject:subCategories[0]];
//        for (NSArray *subSubCategories in subCategories) {
//            NSLog(@"SubSub Categories:%@",subSubCategories);
//            [categoriesArray addObject:subSubCategories[0]];
//        }
    }
    NSLog(@"Categories:%@",categoriesArray);
    return [categoriesArray componentsJoinedByString:@", "];
}

@end
