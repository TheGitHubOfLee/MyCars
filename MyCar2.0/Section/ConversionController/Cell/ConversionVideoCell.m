//
//  ConversionVideoCell.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/8.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "ConversionVideoCell.h"
#import "Header.h"
@interface ConversionVideoCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ConversionVideoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setValueWithModel:(ConversionModel *)Model {
    self.titleLabel.text = Model.video[@"title"];
    self.detailLabel.text = [NSString stringWithFormat:@"%@ %@ %@", Model.video[@"modi_car_name"], Model.video[@"modi_class_name"], Model.video[@"city_name"]];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:Model.video[@"cover"]]];
}
@end
