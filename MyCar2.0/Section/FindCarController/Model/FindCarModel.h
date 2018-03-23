//
//  FindCarModel.h
//  MyCar2.0
//
//  Created by lanouhn on 16/3/10.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindCarModel : NSObject
@property (assign, nonatomic) NSInteger SerialID;
//@property (copy, nonatomic) NSString *Name;
@property (copy, nonatomic) NSString *Picture;
@property (copy, nonatomic) NSString *DealerPrice;

@property (assign, nonatomic) NSInteger masterId;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *logoUrl;
@property (copy, nonatomic) NSString *initial;
@property (assign, nonatomic) NSInteger uv;



@end
