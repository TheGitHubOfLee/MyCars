//
//  ListCell2.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/5.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "ListCell2.h"
#import "Header.h"
@interface ListCell2 ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
@property (strong, nonatomic) IBOutlet UIImageView *midImage;

@property (strong, nonatomic) IBOutlet UIImageView *rightImage;
@property (strong, nonatomic) IBOutlet UILabel *srcLabel;
@property (strong, nonatomic) IBOutlet UILabel *publishTimeLabel;
@end

@implementation ListCell2

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureCellWithModel:(ListModel *)listModel
{
    self.titleLabel.text = listModel.title;
    self.publishTimeLabel.text = listModel.publishTime;
    self.srcLabel.text = listModel.src;
    
    
    
    [self.leftImage sd_setImageWithURL:[NSURL URLWithString:[self returnLeftImageString:listModel.picCover]] placeholderImage:[UIImage imageNamed:@"carhome123"]];
    [self.midImage sd_setImageWithURL:[NSURL URLWithString:[self returnMiddleImageString:listModel.picCover]] placeholderImage:[UIImage imageNamed:@"carhome123"]];
    [self.rightImage sd_setImageWithURL:[NSURL URLWithString:[self returnRightImageString:listModel.picCover]] placeholderImage:[UIImage imageNamed:@"carhome123"]];
}


// 返回左边图片网址链接
- (NSString *)returnLeftImageString:(NSString *)string
{
    NSArray *array = [string componentsSeparatedByString:@";"];
    return array[0];
}

// 返回中间图片链接
- (NSString *)returnMiddleImageString:(NSString *)string
{
    NSArray *array = [string componentsSeparatedByString:@";"];
    return array[1];
}

// 返回右边图片链接
- (NSString *)returnRightImageString:(NSString *)string
{
    NSArray *array = [string componentsSeparatedByString:@";"];
    return array[2];
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
