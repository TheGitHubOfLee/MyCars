//
//  PlayerManager.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/21.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "PlayerManager.h"

@implementation PlayerManager

//+(PlayerManager *)sharePlayer {
//
//    static PlayerManager *manager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        manager = [[PlayerManager alloc]init];
//    });
//    return manager;
//    
//}

+ (PlayerManager *)sharePlayer {
    static PlayerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PlayerManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.player = [[AVPlayer alloc] init];
    }
    return self;
}

@end
