//
//  CarListCell.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/10.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "CarListCell.h"
#import "Header.h"
@interface CarListCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imageV;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation CarListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setValueWithModel:(FindCarModel *)Model {
    self.titleLabel.text = Model.name;
    self.priceLabel.text = Model.DealerPrice;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:Model.Picture]];
}


@end
