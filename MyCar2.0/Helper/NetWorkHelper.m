//
//  NetWorkHelper.m
//  MyCar
//
//  Created by lanouhn on 16/3/3.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "NetWorkHelper.h"
#import "Header.h"
extern BOOL isDown;
@implementation NetWorkHelper


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)picUrl {
    if (!_picUrl) {
        self.picUrl = [NSMutableArray   array];
    }
    return _picUrl;
}

- (NSMutableArray *)dcPic {
    if (!_dcPic) {
        self.dcPic = [NSMutableArray array];
    }
    return _dcPic;
}

- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        self.titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

// 单例
+ (NetWorkHelper *)shareHelper {
    static NetWorkHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[NetWorkHelper alloc]init];
    });
    return helper;
}

/**
 * 解析数据
 */
- (void)paseDataWithURL:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    //    NSLog(@"%@", urlStr);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            if (isDown) {
                //                NSLog(@"123");
                [self.titleArr removeAllObjects];
                [self.picUrl removeAllObjects];
                [self.dataArray removeAllObjects];
            }
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            NSDictionary *dic1 = dic[@"data"];
            NSArray *listArr = dic1[@"list"];
            NSInteger i = 0;
            for (NSDictionary *dict in listArr) {
                ListModel *model = [ListModel new];
                [model setValuesForKeysWithDictionary:dict];
                i++;
                if (i < 6) {
                    [self.picUrl addObject:model.picCover];
                    [self.titleArr addObject:model.title];
                    [self.dcPic addObject:model];
                }else {
                [self.dataArray addObject:model];
                }
            }

            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tableViewReloadData)] ) {
                [self.delegate tableViewReloadData];
            }
            
        }
    }];
    
    [dataTask resume];
    
};


@end
