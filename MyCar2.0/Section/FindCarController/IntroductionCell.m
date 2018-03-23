//
//  IntroductionCell.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/10.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "IntroductionCell.h"
#import "Header.h"
@interface IntroductionCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imageV;


@end

@implementation IntroductionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setValueWithPicUrl:(NSString *)url {
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:url]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
