//
//  AboutController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()
@property (strong, nonatomic) IBOutlet UITextView *text;

@end

@implementation AboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.text.text = @"     本App是由LGQ一人独自开发,尚有许多不足,如有建议或疑问,欢迎发邮件至434404148@qq.com, 谢谢支持!";
    
}
- (IBAction)tongYi:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
