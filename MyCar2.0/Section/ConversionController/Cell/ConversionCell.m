//
//  ConversionCell.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/7.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "ConversionCell.h"
#import "Header.h"
@interface ConversionCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imageV;

@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation ConversionCell

- (void)setValueWithModel:(ConversionModel *)Model {
    if (Model.modi_case) {
        self.titleLabel.text = Model.modi_case[@"title"];
        self.detailLabel.text = [NSString stringWithFormat:@"%@%@%@", Model.modi_case[@"modi_car_name"], Model.modi_case[@"modi_class_name"], Model.modi_case[@"city_name"]];
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:Model.modi_case[@"cover"]]];
    }else  {
        self.titleLabel.text = Model.article[@"title"];
        self.detailLabel.text = [NSString stringWithFormat:@"%@ %@ %@", Model.article[@"modi_car_name"], Model.article[@"modi_class_name"], Model.article[@"city_name"]];
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:Model.article[@"cover"]]];
    }
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
