//
//  DataBase.m
//  DeZiCars
//
//  Created by laouhn on 15/8/17.
//  Copyright (c) 2015年 陈义德. All rights reserved.
//

#import "DataBase.h"

static  sqlite3 * dataBase;

@implementation DataBase

+ (sqlite3*)openDataBase
{
    NSString    * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString    * dataBasePath = [documentPath stringByAppendingPathComponent:@"Car.sqlite"];
    
//    NSLog(@"%@", dataBasePath);
    NSFileManager   * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:dataBasePath]) {
        // 打开数据库
        sqlite3_open([dataBasePath UTF8String], &dataBase);
//        NSLog(@"打开数据库");
        
    }else
    {
        int result = sqlite3_open([dataBasePath UTF8String], &dataBase);
        if (result == SQLITE_OK) {
//            NSLog(@"数据库创建成功");
            [self createTable];
            
        }
    }
    return dataBase;
}



+ (BOOL)createTable
{
    NSString * command = [NSString stringWithFormat:@"create table CarS (sid integer primary key , title text, price text, picUrl text, mp4Link text)"];
    const char * commandT = [command cStringUsingEncoding:NSASCIIStringEncoding];
    if (sqlite3_exec(dataBase, commandT, nil, nil, nil) == SQLITE_OK) {
        
//        NSLog(@"表创建成功");
        return  YES;
    }else
    {
        [self closeDataBase];
        return NO;
    }
    
}




+(void)closeDataBase
{
    sqlite3_close(dataBase);
    dataBase = nil;
}

@end
