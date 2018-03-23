//
//  VideoController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/7.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "VideoController.h"
#import "Header.h"
@interface VideoController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollV;

@end

@implementation VideoController

- (void)viewDidLoad {
    [super viewDidLoad];
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
@end
