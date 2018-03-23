//
//  DataBaseHeader.h
//  DeZiCars
//
//  Created by laouhn on 15/8/17.
//  Copyright (c) 2015年 陈义德. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionModel.h"

@interface DataBaseHeader : NSObject

+ (BOOL)insertDataWithTitle:(NSString *)title price:(NSString *)price sid:(int)sid picUrl:(NSString *)picUrl mp4Link:(NSString *)mp4Link;

+ (NSMutableArray *)returnTableData;
+ (BOOL)deleteDataWithKey:(int)key;
+ (BOOL)selectDataWithKey:(int)key;

@end
