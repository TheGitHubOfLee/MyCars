//
//  LGQAVPlayerViewController.m
//  LLWTeamwork
//
//  Created by lanouhn on 16/1/21.
//  Copyright © 2016年 wangyulong. All rights reserved.
//

#import "LGQAVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Header.h"
@interface LGQAVPlayerViewController ()

@end

@implementation LGQAVPlayerViewController
{

    NSString *_urlString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.player = [AVPlayer playerWithURL:[NSURL URLWithString:_urlString]];
//    NSLog(@"%@", _urlString);
    [self.player play];
    
    
 
}





- (id)initWithUrl:(NSString *)url {
    if ([super init]) {
        _urlString = url;
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [[PlayerManager sharePlayer].player pause];
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
