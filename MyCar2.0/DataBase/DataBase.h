//
//  DataBase.h
//  DeZiCars
//
//  Created by laouhn on 15/8/17.
//  Copyright (c) 2015年 陈义德. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DataBase : NSObject

//打开数据库
+(sqlite3 *)openDataBase;
//关闭数据库
+(void)closeDataBase;

@end
