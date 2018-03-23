//
//  FindCarCell.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/10.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "FindCarCell.h"
NSString *str;
@implementation FindCarCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)five:(id)sender {
    str = @"p=0-5";
}
- (IBAction)fiveToEight:(id)sender {
    str = @"p=5-8";
}
- (IBAction)eightToTwelve:(id)sender {
    str = @"p=8-12";
}
- (IBAction)twelveToEighty:(id)sender {
    str = @"p=12-18";
}
- (IBAction)smileCar:(id)sender {
    str = @"l=2";
}
- (IBAction)compactCar:(id)sender {
    str = @"l=3";
}
- (IBAction)midCar:(id)sender {
    str = @"l=5";
}
- (IBAction)SUVCar:(id)sender {
    str = @"l=8";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
