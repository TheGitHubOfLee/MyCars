//
//  CollectionCell.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/7.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "CollectionCell.h"
#import "Header.h"
@interface CollectionCell ()
@property (strong, nonatomic) IBOutlet UIImageView *tiImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *atuLabel;

@end

@implementation CollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setValueWithModel:(ListModel *)listModel {
    if ([listModel.picCover rangeOfString:@"/wapimg-{0}-{1}/"].location != NSNotFound) {
        [self configureCellWithModel2:listModel];
    }else {
        
        [self configureCellWithModel:listModel];
    }
    
}

- (void)configureCellWithModel:(ListModel *)listModel {
    self.titleLabel.text = listModel.title;
    self.timeLabel.text = listModel.Duration;
    [self.tiImage sd_setImageWithURL:[NSURL URLWithString:listModel.ImageLink]];
    self.atuLabel.text = listModel.Author;
}

- (void)configureCellWithModel2:(ListModel *)listModel2
{
    self.titleLabel.text = listModel2.title;
    self.timeLabel.text = listModel2.Duration;
    self.atuLabel.text = listModel2.Author;
    NSString *str1 = [listModel2.ImageLink substringToIndex:27];
//        NSLog(@"%@", str1);
    NSString *str2 = [listModel2.ImageLink substringFromIndex:42];
    //    NSLog(@"%@", str2);
    [self.tiImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", str1, str2]]];
    //    NSLog(@"%@",[NSString stringWithFormat:@"%@%@", str1, str2]);
}

@end
