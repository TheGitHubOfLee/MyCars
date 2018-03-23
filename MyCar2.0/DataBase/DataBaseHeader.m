//
//  DataBaseHeader.m
//  DeZiCars
//
//  Created by laouhn on 15/8/17.
//  Copyright (c) 2015年 陈义德. All rights reserved.
//

#import "DataBaseHeader.h"
#import "DataBase.h"
#import <sqlite3.h>


@implementation DataBaseHeader

+ (BOOL)insertDataWithTitle:(NSString *)title price:(NSString *)price sid:(int)sid picUrl:(NSString *)picUrl mp4Link:(NSString *)mp4Link
{
    
    sqlite3 * dataBase = [DataBase openDataBase];
    sqlite3_stmt * stmt = nil;
    NSString    * command = [NSString stringWithFormat:@"insert into CarS values(?, ?, ?, ?, ?)"];
    const   char * commandT = [command cStringUsingEncoding:NSASCIIStringEncoding];
    int result = sqlite3_prepare_v2(dataBase, commandT, -1, &stmt, nil);
    if (result == SQLITE_OK) {
        
//        NSLog(@"OKKK");
        sqlite3_bind_int(stmt, 1, sid);
        sqlite3_bind_text(stmt, 2, [title UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 3, [price UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 4, [picUrl UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 5, [mp4Link UTF8String], -1, nil);
        if (sqlite3_step(stmt) == SQLITE_DONE) {
            sqlite3_finalize(stmt);
            [DataBase closeDataBase];
            return  YES;
        }
        
    }
    
    sqlite3_finalize(stmt);
    [DataBase closeDataBase];
    return NO;
    
}



+ (NSMutableArray *)returnTableData
{
    sqlite3 * dataBase  = [DataBase openDataBase];
    sqlite3_stmt * stmt = nil;
    NSString    * command = @"select * from CarS";
    const   char * commandT = [command cStringUsingEncoding:NSASCIIStringEncoding];
    int     result = sqlite3_prepare_v2(dataBase, commandT, -1, &stmt, nil);
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:1];
    
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            int     sid = sqlite3_column_int(stmt, 0);
            const  unsigned char * title = sqlite3_column_text(stmt, 1);
            const  unsigned char * price = sqlite3_column_text(stmt, 2);
            const  unsigned char * picUrl = sqlite3_column_text(stmt, 3);
            const  unsigned char * mp4Link = sqlite3_column_text(stmt, 4);
            CollectionModel   * model = [[CollectionModel alloc]init];
            
            model.sid   = sid;
            model.title = [NSString stringWithUTF8String:(const char *)title];
            model.price = [NSString stringWithUTF8String:(const char *)price];
            model.picUrl = [NSString stringWithUTF8String:(const char *)picUrl];
            model.mp4Link = [NSString stringWithUTF8String:(const char *)mp4Link];
            [array addObject:model];
            
            
        }
//        NSLog(@"%@", array);
    }
    
    sqlite3_finalize(stmt);
    [DataBase closeDataBase];
    
    return  array;
}



+ (BOOL)deleteDataWithKey:(int)key
{
    sqlite3 * dataBase = [DataBase openDataBase];
    sqlite3_stmt * stmt = nil;
    NSString * command = [NSString stringWithFormat:@"delete from CarS where sid = ?"];
    const   char * commandT = [command cStringUsingEncoding:NSASCIIStringEncoding];
    int result = sqlite3_prepare_v2(dataBase, commandT, -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, key);
        if (sqlite3_step(stmt) == SQLITE_DONE) {
            
            sqlite3_finalize(stmt);
            [DataBase closeDataBase];
            return  YES;
        }
    }
    
    [DataBase closeDataBase];
    return  NO;
    
}




+ (BOOL)selectDataWithKey:(int)key
{
    
    sqlite3 * dataBase = [DataBase openDataBase];
    sqlite3_stmt * stmt = nil;
    NSString * command = [NSString stringWithFormat:@"select * from CarS where sid =?"];
    const   char * commandT = [command cStringUsingEncoding:NSASCIIStringEncoding];
    int result = sqlite3_prepare_v2(dataBase, commandT, -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        sqlite3_bind_int(stmt,1, key);
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            
            sqlite3_finalize(stmt);
            [DataBase closeDataBase];
            return  YES;
            
            
        }
    }
    
    [DataBase closeDataBase];
    return  NO;
    
}


@end
