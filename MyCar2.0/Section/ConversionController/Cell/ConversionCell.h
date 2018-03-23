//
//  ConversionCell.h
//  MyCar2.0
//
//  Created by lanouhn on 16/3/7.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConversionModel;
@interface ConversionCell : UITableViewCell
- (void)setValueWithModel:(ConversionModel *)Model;
@end
