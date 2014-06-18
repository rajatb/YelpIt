//
//  YelpCell.h
//  Yelp
//
//  Created by Bhargava, Rajat on 6/14/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpModel.h"

@interface YelpCell : UITableViewCell

@property (strong,nonatomic) YelpModel *yelpModel;
@property (strong, nonatomic) NSNumber *count;

@end
