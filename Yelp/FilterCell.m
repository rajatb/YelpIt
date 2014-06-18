//
//  FilterCell.m
//  Yelp
//
//  Created by Bhargava, Rajat on 6/17/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FilterCell.h"

@interface FilterCell()
@property (weak, nonatomic) IBOutlet UILabel *filterLabel;
@end

@implementation FilterCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setFilterModel:(FilterModel *)filterModel {
  
    _filterModel = filterModel;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.filterLabel.text = self.filterModel.displayName;
    self.accessoryType = (filterModel.isSelected) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

@end
