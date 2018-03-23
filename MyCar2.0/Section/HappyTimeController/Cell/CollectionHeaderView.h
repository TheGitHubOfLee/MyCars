//
//  CollectionHeaderView.h
//  MyCar2.0
//
//  Created by lanouhn on 16/3/20.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Block)();
@interface CollectionHeaderView : UICollectionReusableView
@property (nonatomic, copy)Block block;
@property (strong, nonatomic) IBOutlet UILabel *labelV;

@end
