//
//  ShowTableView.h
//  MyCar2.0
//
//  Created by lanouhn on 16/3/11.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindCarController.h"
@interface ShowTableView : UIViewController<FindCarContrillerDelegate>
@property (nonatomic, copy) NSString * brand;
@property (copy, nonatomic) NSString *picUrl;

@end
