//
//  ArticalCell.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/12.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "ArticalCell.h"
#import "Header.h"
@interface ArticalCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *label;

@end

@implementation ArticalCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setValueWithModel:(DetailModel *)model {
    self.label.text = model.title;
    if ([model.picCover rangeOfString:@"/wapimg-{0}-{1}/"].location != NSNotFound) {
        NSString *str1 = [model.picCover substringToIndex:27];
        //    NSLog(@"%@", str1);
        NSString *str2 = [model.picCover substringFromIndex:42];
        //    NSLog(@"%@", str2);
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", str1, str2]]];
    }else {
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.picCover]];
       
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
