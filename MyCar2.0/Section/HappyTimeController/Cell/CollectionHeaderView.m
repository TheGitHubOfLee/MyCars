//
//  CollectionHeaderView.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/20.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "CollectionHeaderView.h"

@implementation CollectionHeaderView

- (void)awakeFromNib {
    // Initialization code
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.block) {
        self.block();
    }
}
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//    }
//    return self;
//}

@end
