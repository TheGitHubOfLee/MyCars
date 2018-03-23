//
//  HVideoCell.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/9.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "HVideoCell.h"
#import "Header.h"
@interface HVideoCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imageV;




@end

@implementation HVideoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setValueWithModel:(HappyModel *)Model {
    self.nameLabel.text = Model.title;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:Model.imgsrc]];

}

@end
