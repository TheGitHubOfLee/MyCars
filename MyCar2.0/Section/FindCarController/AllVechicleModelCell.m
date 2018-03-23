//
//  AllVechicleModelCell.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/10.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "AllVechicleModelCell.h"
#import "Header.h"
#import "FindCarModel1.h"
@interface AllVechicleModelCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imageV;

@property (strong, nonatomic) IBOutlet UILabel *titleLanel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;


@end

@implementation AllVechicleModelCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setValueWithModel:(FindCarModel1 *)Model {
    self.titleLanel.text = Model.serialName;
    self.priceLabel.text = Model.dealerPrice;
    if ([Model.Picture rangeOfString:@"{0}"].location != NSNotFound) {
        NSString *str1 = [Model.Picture substringToIndex:67];
//        NSLog(@"%@", str1);
        NSString *str2 = [Model.Picture substringFromIndex:70];
//        NSLog(@"%@", str2);
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@1%@", str1, str2]]];
    }else {
        
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
