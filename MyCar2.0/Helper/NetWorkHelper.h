//
//  NetWorkHelper.h
//  MyCar
//
//  Created by lanouhn on 16/3/3.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetWorkHelperDelegate <NSObject>

- (void)tableViewReloadData;

@end


@interface NetWorkHelper : NSObject
@property (nonatomic, weak) id<NetWorkHelperDelegate>delegate;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *picUrl;
@property (strong, nonatomic) NSMutableArray *dcPic;
@property (strong, nonatomic) NSMutableArray *titleArr;
+ (NetWorkHelper *)shareHelper;
- (void)paseDataWithURL:(NSString *)urlStr;

@end
