//
//  IntroductionController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/11.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "IntroductionController.h"
#import "Header.h"
@interface IntroductionController ()
@property (strong, nonatomic) IBOutlet UITextView *text;
@property (strong, nonatomic) NSMutableDictionary *dic;
@end

@implementation IntroductionController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];

    self.text.text = [NSString stringWithFormat:@"%@                   %@", self.introduction, self.logoMeaning];
    
    
    self.title = self.masterName;
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
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
