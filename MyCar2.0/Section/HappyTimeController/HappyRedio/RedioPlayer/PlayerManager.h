//
//  PlayerManager.h
//  MyCar2.0
//
//  Created by lanouhn on 16/3/21.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayerManager : NSObject

@property (strong, nonatomic) AVPlayer *player;
+(PlayerManager *)sharePlayer;

@end
