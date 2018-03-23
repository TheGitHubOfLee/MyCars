//
//  PriceListController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/10.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "PriceListController.h"
#import "Header.h"
@interface PriceListController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollV;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segement;

@end

@implementation PriceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollV.delegate = self;
    // Do any additional setup after loading the view.
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
- (IBAction)segement:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self.scrollV setContentOffset:CGPointMake(0, 0) animated:YES];
            break;
        case 1:
            [self.scrollV setContentOffset:CGPointMake(kWidth, 0) animated:YES];
            break;
        case 2:
            [self.scrollV setContentOffset:CGPointMake(kWidth * 2, 0) animated:YES];
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


@end
