//
//  ListCell1.m
//  MyCar
//
//  Created by lanouhn on 16/3/4.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "ListCell1.h"
#import "Header.h"

@interface ListCell1 ()
@property (strong, nonatomic) IBOutlet UIImageView *imageV;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *scrLabel;

@end

@implementation ListCell1

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCollectionValueWithModel:(CollectionModel *)model {
    if ([model.picUrl rangeOfString:@"/wapimg-{0}-{1}/"].location != NSNotFound) {
        [self configureCellWithModel4:model];
    }else {
        
        [self configureCellWithModel3:model];
    }


}

- (void)configureCellWithModel3:(CollectionModel *)model {
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.price;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
//    self.scrLabel.text = model.src;
}

- (void)configureCellWithModel4:(CollectionModel *)model
{
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.price;
//    self.scrLabel.text = model.src;
    NSString *str1 = [model.picUrl substringToIndex:27];
    //    NSLog(@"%@", str1);
    NSString *str2 = [model.picUrl substringFromIndex:42];
    //    NSLog(@"%@", str2);
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", str1, str2]]];
    //    NSLog(@"%@",[NSString stringWithFormat:@"%@%@", str1, str2]);
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
    self.timeLabel.text = listModel.publishTime;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:listModel.picCover]];
    self.scrLabel.text = listModel.src;
}

- (void)configureCellWithModel2:(ListModel *)listModel2
{
    self.titleLabel.text = listModel2.title;
    self.timeLabel.text = listModel2.publishTime;
   self.scrLabel.text = listModel2.src;
    NSString *str1 = [listModel2.picCover substringToIndex:27];
//    NSLog(@"%@", str1);
    NSString *str2 = [listModel2.picCover substringFromIndex:42];
//    NSLog(@"%@", str2);
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", str1, str2]]];
//    NSLog(@"%@",[NSString stringWithFormat:@"%@%@", str1, str2]);
}


- (void)configureCellectionCellWithModel:(CollectionModel *)model {
//    NSLog(@"%@", model.picUrl);
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.price;
    //    self.srcLabel.text = model.src;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[self returnLeftImageString1:model.picUrl]] placeholderImage:[UIImage imageNamed:@"carhome123"]];
    
    
}

// 返回左边图片网址链接
- (NSString *)returnLeftImageString1:(NSString *)string
{
    NSArray *array = [string componentsSeparatedByString:@";"];
    return array[0];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
