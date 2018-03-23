//
//  HVideoCell1.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/9.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "HVideoCell1.h"
#import "Header.h"

@interface HVideoCell1 ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageV;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *piayCiShu;

@end

@implementation HVideoCell1

- (void)awakeFromNib {
    // Initialization code
}



- (void)setValueWithModel:(HappyModel *)Model {
    self.titleLabel.text = Model.title;
//    self.timeLabel.text = (NSString *)Model.length;
    self.piayCiShu.text = [NSString stringWithFormat:@"%ld", Model.playCount];
    self.detailLabel.text = Model.descriptionL;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:Model.cover]];
  
    if (Model.length < 60 ) {
        self.timeLabel.text = [NSString stringWithFormat:@"00:%ld", Model.length];
    }else {
        NSInteger time = Model.length / 60 ;
        self.timeLabel.text = [NSString stringWithFormat:@"%ld:%ld", time, Model.length - time*60];
    }
}
@end
