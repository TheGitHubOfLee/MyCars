//
//  ListCell3.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/7.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "ListCell3.h"
#import "Header.h"

@interface ListCell3 ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *scrLabel;
@property (strong, nonatomic) IBOutlet UILabel *pubLabel;

@end
@implementation ListCell3

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setValueWithModel:(ListModel *)listModel {
    self.titleLabel.text = listModel.title;
    self.pubLabel.text = listModel.publishTime;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:listModel.picCover]];
    self.scrLabel.text = listModel.src;
    
}
@end
