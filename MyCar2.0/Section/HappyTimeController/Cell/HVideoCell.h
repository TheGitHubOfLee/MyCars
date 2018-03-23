//
//  HVideoCell.h
//  MyCar2.0
//
//  Created by lanouhn on 16/3/9.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HappyModel;
@interface HVideoCell : UICollectionViewCell
- (void)setValueWithModel:(HappyModel *)Model;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@end
