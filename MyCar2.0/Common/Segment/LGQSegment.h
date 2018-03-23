//
//  LGQSegment.h
//  MyCar
//
//  Created by lanouhn on 16/3/4.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LGQSegementDelegate <NSObject>
@optional
- (void)scrollToPage:(int)page;

@end

@interface LGQSegment : UIView

@property (nonatomic, weak) id <LGQSegementDelegate> delegate;


@property(nonatomic, assign) CGFloat maxWidth;
@property(nonatomic,strong)NSMutableArray *titleList;
@property(nonatomic,strong)NSMutableArray *buttonList;
@property(nonatomic,weak)CALayer *LGLayer;
@property(nonatomic,assign)CGFloat bannerNowX;

+ (instancetype)initWithTitleList:(NSMutableArray *)titleList;
-(id)initWithTitleList:(NSMutableArray*)titleList;
-(void)moveToOffsetX:(CGFloat)X;


@end
