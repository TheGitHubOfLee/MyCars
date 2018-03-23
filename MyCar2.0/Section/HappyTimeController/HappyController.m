//
//  HappyController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/8.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "HappyController.h"
#import "Header.h"

@interface HappyController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segement;

@end

@implementation HappyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scroll.delegate = self;
    
//    UIImageView *image = [UIImageView new];
   
    
}
- (IBAction)segement:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self.scroll setContentOffset:CGPointMake(0, 0) animated:YES];
            break;
        case 1:
            [self.scroll setContentOffset:CGPointMake(kWidth, 0) animated:YES];
            break;
        
        default:
            break;
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    
    CGFloat number = offset.x / kWidth;
    
    self.segement.selectedSegmentIndex = number;
    
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
