//
//  FilterViewController.h
//  Yelp
//
//  Created by Bhargava, Rajat on 6/14/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterDelegate <NSObject>
-(void) searchWithFilters:(NSDictionary*) filters;

@end

@interface FilterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) id <FilterDelegate> delegate;
@property (strong, nonatomic) NSMutableDictionary *filters;

@end
