//
//  CollectionCell.h
//  MyCar2.0
//
//  Created by lanouhn on 16/3/7.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListModel;
@interface CollectionCell : UICollectionViewCell
- (void)setValueWithModel:(ListModel *)model;
@end
