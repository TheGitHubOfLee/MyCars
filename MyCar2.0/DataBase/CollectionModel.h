//
//  CollectionModel.h
//  DeZiCars
//
//  Created by laouhn on 15/8/17.
//  Copyright (c) 2015年 陈义德. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionModel : NSObject

@property (nonatomic, assign) int   sid;
@property (nonatomic, copy)NSString * title;
@property (nonatomic, copy)NSString * price;
@property (nonatomic, copy)NSString * picUrl;
@property (nonatomic, copy)NSString * mp4Link;

@end
