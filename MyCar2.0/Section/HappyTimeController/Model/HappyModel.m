//
//  HappyModel.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/8.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "HappyModel.h"

@implementation HappyModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
        if ([key isEqualToString: @"description"]) {
            self.descriptionL = value;
        
    }
}

@end
