//
//  ListCell1.h
//  MyCar
//
//  Created by lanouhn on 16/3/4.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListModel;
@class CollectionModel;
@interface ListCell1 : UITableViewCell

- (void)setValueWithModel:(ListModel *)listModel;

- (void)setCollectionValueWithModel:(CollectionModel *)model;
- (void)configureCellectionCellWithModel:(CollectionModel *)model;
@end
