//
//  ListModel.h
//  MyCar
//
//  Created by lanouhn on 16/3/4.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject
@property (assign, nonatomic) NSInteger newsId;
@property (strong, nonatomic) NSString *picCover;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *src;
@property (strong, nonatomic) NSString *publishTime;


@property (strong, nonatomic) NSString *lastModify;
@property (assign, nonatomic) NSInteger SerialID;
@property (strong, nonatomic) NSString *Name;
@property (strong, nonatomic) NSString *Picture;
@property (strong, nonatomic) NSString *DealerPrice;

@property (assign, nonatomic) NSInteger VideoId;
@property (strong, nonatomic) NSString *Title;
@property (strong, nonatomic) NSString *Mp4Link;
@property (strong, nonatomic) NSString *Author;
@property (strong, nonatomic) NSString *CreatedOn;
@property (assign, nonatomic) NSInteger TotalVisit;
@property (strong, nonatomic) NSString *Duration;
@property (strong, nonatomic) NSString *CategoryName;
@property (strong, nonatomic) NSString *CategoryId;
@property (strong, nonatomic) NSString *ImageLink;
@property (strong, nonatomic) NSString *newsLink;

@end
