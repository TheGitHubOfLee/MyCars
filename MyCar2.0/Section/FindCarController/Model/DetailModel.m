//
//  DetailModel.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/12.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
         self.AId = value;
    }
}

@end
