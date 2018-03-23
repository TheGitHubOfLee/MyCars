//
//  DetailWebController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/6.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "DetailWebController.h"
#import "Header.h"
#import "UMSocial.h"
#import "UMSocialControllerServiceComment.h"
#import "DataBase.h"
#import "DataBaseHeader.h"
extern LGQSegment *segment;
@interface DetailWebController ()<UMSocialUIDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *DetailWebView;
@property (strong, nonatomic) NSString *detailUrl;
@property (strong, nonatomic) XXXRoundMenuButton *roundMenu;
@property (strong, nonatomic) NSMutableDictionary *dict;
@end

@implementation DetailWebController

- (NSMutableDictionary *)dict {
    if (!_dict) {
        self.dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
    segment.hidden = YES;
 
    [self paseDataWithURL:self.detailStr];
//    NSLog(@"%@", self.detailStr);
    [self setRoundMenu];
    [self.tabBarController.view addSubview:self.roundMenu];
}

- (void)setRoundMenu {
    self.roundMenu = [[XXXRoundMenuButton alloc]initWithFrame:CGRectMake(kWidth - 120, - 55, 200, 200)];
    self.roundMenu.centerButtonSize = CGSizeMake(35, 35);
    self.roundMenu.centerIconType = XXXIconTypeUserDraw;
    self.roundMenu.tintColor = [UIColor whiteColor];
    self.roundMenu.jumpOutButtonOnebyOne = YES;
    self.roundMenu.backgroundColor = [UIColor clearColor];
    
    [self.roundMenu setDrawCenterButtonIconBlock:^(CGRect rect, UIControlState state) {
        
        if (state == UIControlStateNormal)
        {
            UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake((rect.size.width - 15)/2, rect.size.height/2 - 5, 15, 1)];
            [UIColor.whiteColor setFill];
            [rectanglePath fill];
            
            
            UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake((rect.size.width - 15)/2, rect.size.height/2, 15, 1)];
            [UIColor.whiteColor setFill];
            [rectangle2Path fill];
            
            UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRect: CGRectMake((rect.size.width - 15)/2, rect.size.height/2 + 5, 15, 1)];
            [UIColor.whiteColor setFill];
            [rectangle3Path fill];
        }
    }];
    
    [self.roundMenu loadButtonWithIcons:@[
                                          [UIImage imageNamed:@"no_collection_1102px_1143810_easyicon.net"],
                                          [UIImage imageNamed:@"share_934px_1190684_easyicon.net"],
                                          
                                          ] startDegree:M_PI*1.5 layoutDegree:M_PI/3];
   /**
    *关于M_PI
#define M_PI     3.14159265358979323846264338327950288
    其实它就是圆周率的值，在这里代表弧度，相当于角度制 0-360 度，M_PI=180度
    旋转方向为：顺时针旋转
    */
    __weak typeof(self)weakSelf = self;
    [self.roundMenu setButtonClickBlock:^(NSInteger idx) {
        
        if (idx == 1) {
            [UMSocialSnsService presentSnsIconSheetView:weakSelf
                                                 appKey:@"56a7577de0f55a074f0017fa"
                                              shareText:@"你要分享的文字"
                                             shareImage:[UIImage imageNamed:@"123.png"]
                                        shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent, UMShareToRenren,nil]
                                               delegate:weakSelf];
        }else {
            
            
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏功能请期待2.0版本.." preferredStyle:(UIAlertControllerStyleAlert)];
            
            
            
            // 首先判断是否可以在数据库中筛选到，以数据库添加数据时的主键Key进行查询
            BOOL  result = [DataBaseHeader selectDataWithKey:[weakSelf.dict[@'a'] intValue]];
            
            if (!result && weakSelf.dict[@'A'] != nil && weakSelf.dict[@'B'] != nil && weakSelf.dict[@'D'] != nil && weakSelf.dict[@'E'] != nil && weakSelf.dict[@'a'] != nil) {
                [DataBaseHeader insertDataWithTitle:weakSelf.dict[@'A']  price:weakSelf.dict[@'B'] sid:[weakSelf.dict[@'a'] intValue] picUrl:weakSelf.dict[@'D'] mp4Link:weakSelf.dict[@'E']];
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"收藏成功!" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
                [alertVC addAction:action];
                [weakSelf presentViewController:alertVC animated:YES completion:nil];
            }else {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"您已经收藏过了..." preferredStyle:(UIAlertControllerStyleAlert)];
                
                [weakSelf presentViewController:alertVC animated:YES completion:nil];
                [alertVC dismissViewControllerAnimated:YES completion:nil];
//                NSLog(@"youle");
            }
            

//                // 如果是非选中状态 就删除
////                [DataBaseHeader deleteDataWithKey:[cell.allTypesModel.sid intValue]];
          
        }
       
    }];
}



- (void)viewDidDisappear:(BOOL)animated {
    segment.hidden = NO;
    self.roundMenu.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
[self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
    segment.hidden = YES;
    self.roundMenu.hidden = NO;
}

- (void)paseDataWithURL:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
//    NSLog(@"%@", urlStr);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//    __weak typeof(self)weakSelf = self;
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            [self.dict removeAllObjects];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            NSDictionary *dic1 = dic[@"data"];
            
            [self.dict setObject:dic1[@"newsId"] forKey:@'a'];
            
            [self.dict setObject:dic1[@"title"] forKey:@'A'];
            
            if (dic1[@"src"] != nil) {
                [self.dict setObject:dic1[@"src"] forKey:@'B'];
            } else {
                [self.dict setObject:dic1[@"sourceName"] forKey:@'B'];
            }
            [self.dict setObject:dic1[@"publishTime"] forKey:@'C'];
            
            NSDictionary *dic2 = dic1[@"shareData"];
            
            if (dic2 != nil) {
                self.detailUrl = dic2[@"newsLink"];
                [self.dict setObject:dic2[@"newsImg"] forKey:@'D'];
                [self.dict setObject:dic2[@"newsLink"] forKey:@'E'];
            }else {
                NSDictionary *dic3 = dic1[@"shareToCheYou"];

                self.detailUrl = dic3[@"newslink"];
                
                [self.dict setObject:dic3[@"picsImgsList"] forKey:@'D'];
                [self.dict setObject:dic3[@"newslink"] forKey:@'E'];

//                NSLog(@"%@", dic1[@"newslink"]);
            }
            
            [self.DetailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailUrl]]];
           
        }
        
    }];
    
    [dataTask resume];
    
};


- (void)tableViewReloadData {
    
    dispatch_async(dispatch_get_main_queue(), ^{
//    [self.view reloadData];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
