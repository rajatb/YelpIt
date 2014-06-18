//
//  SwitchCell.h
//  Yelp
//
//  Created by Bhargava, Rajat on 6/15/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *switchValue;
@property (weak, nonatomic) IBOutlet UILabel *toggleFilterLabel;

@end
