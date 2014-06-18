//
//  FilterModel.m
//  Yelp
//
//  Created by Bhargava, Rajat on 6/17/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FilterModel.h"

@implementation FilterModel

-(id)initWithFilterName:(NSString*)filterName displayName:(NSString*)displayName{
    self = [super init];
    
    if (self) {
        self.filterName = filterName;
        self.displayName = displayName;
        self.isSelected = NO;
    }
    return self; 
}

+(id)filterModelWithName:(NSString*)filterName displayName:(NSString*)displayName{
   return [[self alloc] initWithFilterName:filterName displayName:displayName];
}

@end
