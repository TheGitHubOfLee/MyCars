//
//  RedioCollectionCell.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/19.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "RedioCollectionCell.h"
#import "RedioModel.h"
#import "Header.h"
@interface RedioCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation RedioCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setValueWithModel:(RedioModel *)model {
    
    self.titleLabel.text = model.title;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];

}

@end
