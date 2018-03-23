//
//  ConversionModel.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/8.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "ConversionModel.h"

@implementation ConversionModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.vId = [value intValue];
    }
}

@end
