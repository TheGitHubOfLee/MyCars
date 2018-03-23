//
//  CollectionDetailController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "CollectionDetailController.h"

@interface CollectionDetailController ()
@property (strong, nonatomic) IBOutlet UIWebView *WebVC;

@end

@implementation CollectionDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self.WebVC loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.DetailUrl]]];
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
