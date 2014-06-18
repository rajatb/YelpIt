//
//  SectionFilter.h
//  Yelp
//
//  Created by Bhargava, Rajat on 6/17/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionFilter : NSObject

@property(strong, nonatomic) NSArray *filterModels;
@property(assign, nonatomic) NSUInteger numOfRowsToShowWhenCollapsed;
@property(strong, nonatomic) NSString *sectionFilterName;

-(NSArray*) getDisplayNameOfFiltersSelected;
-(NSString*) getNameOfFiltersSelected;
-(id)initWithFilterModelArray:(NSArray*)filterModel;

+(instancetype) sectionFilterWithCategoryFilters;

@end
