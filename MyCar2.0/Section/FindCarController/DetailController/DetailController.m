//
//  DetailController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/11.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "DetailController.h"
#import "Header.h"
@interface DetailController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *segement;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollV;
@end

@implementation DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSLog(@"%ld", self.serialId);
    self.scrollV.delegate = self;
    [self reloadData];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    
    CGFloat number = offset.x / kWidth;
    
    self.segement.selectedSegmentIndex = number;
    
}

- (void)reloadData {
        articleController *article = self.childViewControllers[0];
    [article RelodDataWithUrl2:[NSString stringWithFormat:kArctilUrl, self.serialId]];
    VideoRecommendController *videoVC = self.childViewControllers[1];
    [videoVC RelodDataWithUrl3:[NSString stringWithFormat:kDetailVideo, self.serialId]];
}

- (IBAction)segement:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self.scrollV setContentOffset:CGPointMake(0, 0) animated:YES];
            break;
        case 1:
            [self.scrollV setContentOffset:CGPointMake(kWidth, 0) animated:YES];
            break;
       
        default:
            break;
    }

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
