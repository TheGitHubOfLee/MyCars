//
//  Header.h
//  MyCar
//
//  Created by lanouhn on 16/3/3.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#ifndef Header_h
#define Header_h
#import "IntroductionController.h"
#import "IntroductionModel.h"
#import "AllVechicleModelCell.h"
#import "ShowTableView.h"
#import "ConDetailController.h"
#import "NetWorkHelper.h"
#import "InformationViewController.h"
#import "ListCell1.h"
#import "LGQSegment.h"
#import "TalkCarController.h"
#import "PicAndWordController.h"
#import "TestController.h"
#import "BuyCarController.h"
#import "VideoController.h"
#import "NewCarController.h"
#import "ListModel.h"
#import "ListCell2.h"
#import "DetailWebController.h"
#import "ListCell3.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "VDetailController1.h"
#import "VDetailController2.h"
#import "VDetailController3.h"
#import "CollectionCell.h"
#import "LGQAVPlayerViewController.h"
#import "ConversionCell.h"
#import "ConversionController.h"
#import "ConversionVideoCell.h"
#import "ConversionModel.h"
#import "AFManegerHelp.h"
#import "AFNetworking.h"
#import "JSONModel.h"
#import "HVideoCell.h"
#import "HVideoCell1.h"
#import "HappyController.h"
#import "HappyModel.h"
#import "HappyDetailController1.h"
#import "RedioController.h"
#import "RedioCell.h"
#import "RedioModel.h"
#import "FindCarModel.h"
#import "FindCarCell.h"
#import "FindCarController.h"
#import "CarListCell.h"
#import "SearchCarCell.h"
#import "IntroductionCell.h"
#import "DetailController.h"
#import "ArticalCell.h"
#import "articleController.h"
#import "VideoRecommendController.h"
#import "DetailModel.h"
#import "SDCycleScrollView.h"
#import "XXXRoundMenuButton.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "CollectionModel.h"
#import "CollectionController.h"
#import "RedioDetailController.h"
#import "PlayerManager.h"


#define kCellID @"CollectionCell"

#define kLGQSegH 40
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
// 资讯
#define kInfUrl @"http://api.ycapp.yiche.com/appnews/toutiaov64/?page=%ld&length=20&platform=2"
// 详情
#define kDetailUrl1 @"http://api.ycapp.yiche.com/struct/GetStructNews?newsId=%ld&ts=20160302143219&plat=2"
#define kDetailUrl2 @"http://api.ycapp.yiche.com/struct/GetStructYCNews?newsId=%ld&ts=20160302161941&plat=2"
#define kDetailUrl3 @"http://api.ycapp.yiche.com/struct/GetStructMedia?newsId=%ld&ts=20160302180821&plat=2"
// 搜索
#define kSearchUrl @"http://59.151.102.96/yicheappsug.php?k=%@"

// 视频列表
#define kVideoUrl1 @"http://api.ycapp.yiche.com/video/getvideolist?categoryid=13&pageindex=%ld&pagesize=20"
#define kVideoUrl2 @"http://api.ycapp.yiche.com/video/getvideolist?categoryid=12&pageindex=%ld&pagesize=20"
#define kVideoUrl3 @"http://api.ycapp.yiche.com/video/getvideolist?categoryid=15&pageindex=%ld&pagesize=20"
// 新车
#define kNewCarUrl @"http://api.ycapp.yiche.com/news/GetNewsList?categoryid=3&serialid=&pageindex=%ld&pagesize=20&appver=6.8"

// 测评
#define kTest @"http://api.ycapp.yiche.com/news/GetNewsList?categoryid=1&serialid=&pageindex=%ld&pagesize=20&appver=6.8"

// 图文
#define kPictureUrl @"http://api.ycapp.yiche.com/AppNews/GetAppNewsAlbumList?page=%ld&length=20&platform=2"
// 图文详情
#define kPictDetailUrl @"http://api.ycapp.yiche.com/appnews/GetNewsAlbum?newsid=%ld"
// 聊聊车
#define kTalkCarUrl @"http://api.ycapp.yiche.com/media/getnewslist?pageindex=%ld&pagesize=20"

// 教你买
#define kBuyCarUrl @"http://api.ycapp.yiche.com/news/GetNewsList?categoryid=2&serialid=&pageindex=%ld&pagesize=20&appver=6.8"

// 找车
#define kFindCarListUrl @"http://cheyouapi.ycapp.yiche.com/car/getmasterbrandlist?allmasterbrand=false"
// 品牌车型
#define kCarListUrl @"http://api.ycapp.yiche.com/car/getseriallist?masterid=%@&allserial=false"
// 热门车型
#define kHotCarUrl @"http://api.ycapp.yiche.com/yicheapp/GetSelectCarPageAd?platform=2"

#define kIntrouctionUrl @"http://api.ycapp.yiche.com/car/getmasterbrandstory?masterid=%@"

// 5W以下
// 最畅销
#define kMostsell1 @"http://extapi.ycapp.yiche.com/car/pickcar?shijian=478612602.694178&%@&s=%ld&page=%ld"


// 详情
#define kDetailUrl @"http://api.ycapp.yiche.com/car/GetCarListV61?csid=%ld&cityId=1001"
// 综述
#define kGeneralUrl @"http://api.ycapp.yiche.com/car/GetSerialInfo?csid=%ld&tracker=172_ycapp"

// 文章
#define kArctilUrl @"http://api.ycapp.yiche.com/news/GetNewsList?categoryid=8&serialid=%ld"
#define kArctilurl2 @"&pageindex=%ld&pagesize=20&appver=6.8"

#define kArctilDetailUrl @"http://api.ycapp.yiche.com/struct/GetStructYCNews?newsId=%ld&ts=20160114191558&plat=2"

// 视频
#define kDetailVideo @"http://api.ycapp.yiche.com/video/getvideolistbyserialid/?serialid=%ld"
#define kDetailVideo1 @"&length=20&page=%ld"
// 改装集锦
#define kChangeUrl @"http://app.api.niuche.com/modi/mix_list?page=%ld&count=20"
#define kChangeDetailUrl1 @"http://app.api.niuche.com/modi/case/detail?case_id="
#define kChangeDetailUrl2 @"http://app.api.niuche.com/modi/video/detail?video_id="
#define kChangeDetailUrl4 @"&video_type="
#define kChangeDetailUrl3 @"http://app.api.niuche.com/modi/article/detail?article_id="

// 轻松一刻
#define kHappyVideoUrl @"http://c.m.163.com/nc/video/home/%ld-%ld.html"

// 列表详情
#define kHappyVideoDetailUrl @"http://c.m.163.com/nc/video/list/%@/y/%ld-%ld.html"
// 电台
#define kRedioUrl @"http://c.m.163.com/nc/topicset/ios/radio/%@/0-20.html"
// 分区选项
#define kRediolistUrl @"http://c.m.163.com/nc/topicset/ios/radio/index.html"
// 播放单曲
#define kPlayUrl @"http://c.m.163.com/nc/article/%@/full.html"
// 播放界面
#define kDetailPlayUrl @"http://c.m.163.com/nc/article/list/%@/%@.html"


#endif /* Header_h */
