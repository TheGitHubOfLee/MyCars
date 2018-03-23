//
//  ConDetailController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/8.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "ConDetailController.h"
#import "Header.h"
#import "UMSocial.h"
#import "UMSocialControllerServiceComment.h"
@interface ConDetailController ()<UMSocialUIDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *detailWbVC;
@property (strong, nonatomic) NSString *detailUrl;
@property (strong, nonatomic) XXXRoundMenuButton *roundMenu;
@end

@implementation ConDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self paseDataWithURL:self.detailStr];
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
        }
        
    }];
}


- (void)paseDataWithURL:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    //    NSLog(@"%@", urlStr);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    //    __weak typeof(self)weakSelf = self;
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            NSDictionary *dic1 = dic[@"data"];
            NSDictionary *dic2 = dic1[@"share"];
            self.detailUrl = dic2[@"link"];
            }
            
            [self.detailWbVC loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailUrl]]];
    }];
    
    [dataTask resume];
    
};

- (void)viewWillDisappear:(BOOL)animated {
    self.roundMenu.hidden = YES;
}

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
