//
//  SectionFilter.m
//  Yelp
//
//  Created by Bhargava, Rajat on 6/17/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "SectionFilter.h"
#import "FilterModel.h"


@implementation SectionFilter


-(id)initWithFilterModelArray:(NSArray*)filterModel{
    self=[super init];
    if (self) {
        self.filterModels = filterModel;
    }
    return self;
}

+(instancetype) sectionFilterWithCategoryFilters {
    

    NSMutableArray *filterModels = [NSMutableArray array];
    
    [filterModels addObject:[FilterModel filterModelWithName:@"afghani" displayName:@"Afghan"]];
    [filterModels addObject:[FilterModel filterModelWithName:@"african" displayName:@"African"]];
    [filterModels addObject:[FilterModel filterModelWithName:@"newamerican" displayName:@"American (New)"]];
    [filterModels addObject:[FilterModel filterModelWithName:@"asianfusion" displayName:@"Asian Fusion"]];
    [filterModels addObject:[FilterModel filterModelWithName:@"buffets" displayName:@"Buffets"]];
    [filterModels addObject:[FilterModel filterModelWithName:@"french" displayName:@"French"]];
    [filterModels addObject:[FilterModel filterModelWithName:@"indopak" displayName:@"Indian"]];
    [filterModels addObject:[FilterModel filterModelWithName:@"japanese" displayName:@"Japanese"]];
    
    SectionFilter *sectionFilter = [[self alloc]initWithFilterModelArray:filterModels];
    sectionFilter.sectionFilterName = @"category_filter";
    sectionFilter.numOfRowsToShowWhenCollapsed = 3; 
    
    return sectionFilter; 
    
}

-(NSString*) getDisplayNameOfFiltersSelected {
    NSPredicate *selectedFiltersPredicated = [NSPredicate predicateWithFormat:@"isSelected == YES"];
    NSMutableArray *selectedFilterNameList = [NSMutableArray array];
    NSArray *selectedFilterModels = [self.filterModels filteredArrayUsingPredicate:selectedFiltersPredicated];
    for (FilterModel *filter in selectedFilterModels) {
        [selectedFilterNameList addObject:filter.displayName];
    }
    return [selectedFilterNameList componentsJoinedByString:@", "];
    
}

-(NSString*) getNameOfFiltersSelected {
    NSPredicate *selectedFiltersPredicated = [NSPredicate predicateWithFormat:@"isSelected == YES"];
    NSMutableArray *selectedFilterNameList = [NSMutableArray array];
    NSArray *selectedFilterModels = [self.filterModels filteredArrayUsingPredicate:selectedFiltersPredicated];
    for (FilterModel *filter in selectedFilterModels) {
        [selectedFilterNameList addObject:filter.filterName];
    }
    return [selectedFilterNameList componentsJoinedByString:@","];
    
}



@end
