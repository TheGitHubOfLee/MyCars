//
//  SearchCarCell.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/10.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "SearchCarCell.h"
#import "Header.h"

@interface SearchCarCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation SearchCarCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setValueWithModel:(FindCarModel *)Model{
    self.nameLabel.text = Model.name;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:Model.logoUrl]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
