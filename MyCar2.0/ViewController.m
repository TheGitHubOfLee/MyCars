//
//  ViewController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/5.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"
LGQSegment *segment;
@interface ViewController ()<UIScrollViewDelegate, LGQSegementDelegate>
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property(nonatomic,strong)NSMutableArray *buttonList;
@property (strong, nonatomic) VideoController *vidVC;
@property(nonatomic,weak)CALayer *LGLayer;
@end

@implementation ViewController
- (NSMutableArray *)buttonList
{
    if (!_buttonList)
    {
        _buttonList = [NSMutableArray array];
    }
    return _buttonList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //加载Segment
    [self setSegment];
    //加载ViewController
    [self addChildViewController];
    //加载ScrollView
    [self setContentScrollView];
}

-(void)setSegment {
    
    [self buttonList];
    //初始化
    LGQSegment *segment1 = [[LGQSegment alloc]initWithFrame:CGRectMake(0, 0, kWidth, kLGQSegH)];
    segment1.delegate = self;
    segment = segment1;
    [self.navigationController.navigationBar addSubview:segment];
    
    [self.buttonList addObject:segment.buttonList];
    self.LGLayer = segment.LGLayer;
    
}
//加载ScrollView
-(void)setContentScrollView {
    
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kHeight)];
    [self.view addSubview:sv];
    sv.bounces = NO;
    sv.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    sv.contentOffset = CGPointMake(0, 0);
    sv.pagingEnabled = YES;
    sv.showsHorizontalScrollIndicator = NO;
    sv.scrollEnabled = YES;
    sv.userInteractionEnabled = YES;
    sv.delegate = self;
    
    for (int i=0; i<self.childViewControllers.count; i++) {
        UIViewController * vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(i * kWidth, 0, kWidth, kHeight - 104);
        [sv addSubview:vc.view];
        
    }
    
    sv.contentSize = CGSizeMake(self.childViewControllers.count * kWidth, 0);
    self.contentScrollView = sv;
}
//加载7个ViewController
-(void)addChildViewController{
    InformationViewController *infVC = [[InformationViewController alloc]init];
    [self addChildViewController:infVC];
    
    PicAndWordController *picVC = [[PicAndWordController alloc]init];
    [self addChildViewController:picVC];
    self.vidVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"VideoVC"];
//    vidVC.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:self.vidVC];
    TalkCarController *talVC = [[TalkCarController alloc]init];
    [self addChildViewController:talVC];
    TestController *testVC = [[TestController alloc]init];
    [self addChildViewController:testVC];
    
    NewCarController *newVC = [[NewCarController alloc]init];
    [self addChildViewController:newVC];
    BuyCarController *buy = [[BuyCarController alloc]init];
    [self addChildViewController:buy];
    
}

#pragma mark - UIScrollViewDelegate
//实现LGSegment代理方法
-(void)scrollToPage:(int)Page {
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = self.view.frame.size.width * Page;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentScrollView.contentOffset = offset;
    }];
}
// 只要滚动UIScrollView就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    [segment moveToOffsetX:offsetX];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
