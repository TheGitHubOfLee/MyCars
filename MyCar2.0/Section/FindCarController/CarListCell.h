//
//  CarListCell.h
//  MyCar2.0
//
//  Created by lanouhn on 16/3/10.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FindCarModel;
@interface CarListCell : UICollectionViewCell

- (void)setValueWithModel:(FindCarModel *)Model;

@end
