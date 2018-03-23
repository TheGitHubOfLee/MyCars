//
//  HappyModel.h
//  MyCar2.0
//
//  Created by lanouhn on 16/3/8.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HappyModel : NSObject
@property (copy, nonatomic) NSString *sid;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *imgsrc;
@property (copy, nonatomic) NSString *descriptionL;
@property (copy, nonatomic) NSString *mp4_url;
@property (copy, nonatomic) NSString *cover;
@property (assign, nonatomic) NSInteger playCount;
@property (assign, nonatomic) NSInteger length;
@end
