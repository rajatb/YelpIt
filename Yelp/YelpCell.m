//
//  YelpCell.m
//  Yelp
//
//  Created by Bhargava, Rajat on 6/14/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YelpCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"

@interface YelpCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *yeplpImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabelList;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;

@end

@implementation YelpCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setYelpModel:(YelpModel *)yelpModel {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    _yelpModel = yelpModel; 
    if(self.count){
        self.nameLabel.text= [NSString stringWithFormat:@"%@. %@",self.count,yelpModel.name];
    }else {
         self.nameLabel.text= yelpModel.name;
    }
    [self.nameLabel setNumberOfLines:0];
    //[self.nameLabel sizeToFit];
    
    [self.ratingImageView setImageWithURL:[NSURL URLWithString:yelpModel.ratingImgUrlLarge]];
    
    [self.yeplpImageView setImageWithURL:[NSURL URLWithString:yelpModel.imageUrl]];
    self.yeplpImageView.layer.cornerRadius=5;
    self.yeplpImageView.clipsToBounds=YES;
    //self.yeplpImageView.layer.shadowColor = (__bridge CGColorRef)([UIColor blackColor]);
    
    self.reviewLabel.text = [yelpModel getStringReviewCount];
    self.categoriesLabel.text = [yelpModel getCategoryList];
    self.addressLabelList.text = [yelpModel.location getDisplayAddressList];
   // NSLog(@"Categorie:%@",categories[0]);
    
}

@end
