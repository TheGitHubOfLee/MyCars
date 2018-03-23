//
//  ConversionModel.h
//  MyCar2.0
//
//  Created by lanouhn on 16/3/8.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConversionModel : NSObject
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger vId;
@property (strong, nonatomic) NSMutableDictionary *modi_case;
@property (strong, nonatomic) NSMutableDictionary *video;
@property (strong, nonatomic) NSMutableDictionary *article;
@end
