//
//  FindCarController.h
//  MyCar2.0
//
//  Created by lanouhn on 16/3/10.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FindCarContrillerDelegate <NSObject>

- (void)loadDataWithBrand:(NSString *)brand andpic:(NSString *)picUrl;

@end

@interface FindCarController : UIViewController

@property (assign, nonatomic) id<FindCarContrillerDelegate>delegate;

@end
