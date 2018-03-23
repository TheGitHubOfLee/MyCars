//
//  RedioCell.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/9.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "RedioCell.h"
#import "Header.h"
@interface RedioCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imageV;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;


@end

@implementation RedioCell

- (void)setValueWithModel:(RedioModel *)Model {
    self.titleLabel.text = Model.tname;
    self.detailLabel.text = Model.title;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:Model.imgsrc]];
}

- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
