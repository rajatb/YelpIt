//
//  FilterModel.h
//  Yelp
//
//  Created by Bhargava, Rajat on 6/17/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterModel : NSObject

@property(strong, nonatomic) NSString *filterName;
@property(strong, nonatomic) NSString *displayName;
@property(assign, nonatomic) BOOL isSelected;

-(id)initWithFilterName:(NSString*)filterName displayName:(NSString*)displayName;
+(id)filterModelWithName:(NSString*)filterName displayName:(NSString*)displayName;


@end
