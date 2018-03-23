//
//  MineController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/12.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "MineController.h"
#import "Header.h"
#import "ShengMingController.h"
#include "AboutController.h"
#import "CollectionController.h"
@interface MineController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *baseTable;
@property (nonatomic, strong) UIImageView * picImageView;
@property (strong, nonatomic) UIButton *dayButton;
@property (assign, nonatomic) BOOL dayAndNight;
@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dayAndNight = YES;
    self.dayButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.dayButton.frame = CGRectMake(0, 0, kWidth, 50);
    [self.dayButton setTitle:@"夜间模式" forState:(UIControlStateNormal)];
    [self.dayButton addTarget:self action:@selector(dayAndNightButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.dayButton];
    self.baseTable.tableFooterView = self.dayButton;
    self.baseTable.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -(200), [UIScreen mainScreen].bounds.size.width, (200))];
    self.picImageView.image = [UIImage imageNamed:@"E2.jpg"];
    [self.baseTable addSubview:self.picImageView];
    [self.baseTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - 下拉放大图片

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset = scrollView.contentOffset.y;
    
    if (yOffset < -(200) ) {
        
        CGFloat scale = (-yOffset ) / (200);
        CGRect frame = self.picImageView.frame;
        frame.origin.y = yOffset ;
        frame.size.height = -yOffset ;
        frame.size.width = self.view.bounds.size.width * scale;
        frame.origin.x = -(frame.size.width - self.view.bounds.size.width) / 2;
        self.picImageView.frame = frame;
    }
    
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.imageView.layer.bounds = CGRectMake(0, 0, 45, 45);
        cell.textLabel.text = @"清除缓存";
        //        cell.imageView.image = [UIImage imageNamed:@"clean.png"];
        
    }else if(indexPath.section == 0 && indexPath.row == 1)
    {
        cell.textLabel.text = @"我的收藏";
        //        cell.imageView.image = [UIImage imageNamed:@"collect.png"];
        
    }else if(indexPath.section == 1 && indexPath.row == 0)
    {
        cell.textLabel.text = @"免责声明";
        //        cell.imageView.image = [UIImage imageNamed:@"information.png"];
        
    }else   if(indexPath.section == 1 && indexPath.row == 1)
    {
        cell.textLabel.text = @"关于";
        //        cell.imageView.image = [UIImage imageNamed:@"information.png"];
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell ;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (void)dayAndNightButton {
    if (self.dayAndNight == YES) {
        self.view.window.alpha = 0.5;
        self.dayAndNight = NO;
        [self.dayButton setTitle:@"日间模式" forState:(UIControlStateNormal)];;
    }else {
        self.view.window.alpha = 1;
        self.dayAndNight = YES;
        [self.dayButton setTitle:@"夜间模式" forState:(UIControlStateNormal)];;

    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self folderSizeAtPath:[self getPath]];
    }else if(indexPath.section == 0 && indexPath.row == 1)
    {
        
        CollectionController * collectionVC = [[CollectionController alloc]init];
        UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        collectionVC = [story instantiateViewControllerWithIdentifier:@"CollectionVC"];
        collectionVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:collectionVC animated:YES];
        
        
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        ShengMingController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ShengMingController"];;
        
        [self presentViewController:detailVC animated:YES completion:nil];
//        NSString    * message = @"去买车是一款展示一些汽车品牌、资讯等信息的一个平台软件，未经允许不得用于其他的商业宣传等使用，该软件不做任何商业用途，仅供学习交流和使用。";
//        NextViewController * nextVC = [NextViewController new];
//        nextVC.contentString = message;
//        nextVC.title = @"免责声明";
//        [self.navigationController pushViewController:nextVC animated:YES];
//        
    } else {
        AboutController *detailVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AboutController"];
        [self presentViewController:detailVc animated:YES
                         completion:nil];
//        NSString    * message = @"本软件是由德子个人开发，可能存在一些不足之处，请大家见谅。在使用的过程中如有问题可以发送邮件至邮箱：460069238@qq.com";
//        NextViewController * nextVC = [NextViewController new];
//        nextVC.contentString = message;
//        nextVC.title = @"关于";
//        [self.navigationController pushViewController:nextVC animated:YES];
//    }
}
}

#pragma mark - 清除缓存的操作
- (CGFloat)filePathSize:(NSString *)path
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return  size / 1024.0/1024.0;
        
    }return 0;
}

- (void)showCacheFileSizeToDelete:(CGFloat)fileSize
{
    if (fileSize < 0.0001) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已经很干净了..." delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alertView show ];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        });
    }else
    {
        NSString * string = [NSString stringWithFormat:@"缓存大小为:%.2fM,是否删除",fileSize];
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"删除" otherButtonTitles:@"取消", nil];
        [alertView show ];
        
    }
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self clearCache:[self getPath]];
    }
}



- (void)clearCache:(NSString *)path
{
//    NSLog(@"delete");
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        
        //  [fileManager removeItemAtPath:path error:nil];
        
        for (NSString * fileName in childerFiles) {
            //如有需要,加入条件,过滤不想删除的文件
            if ([fileName hasSuffix:@".mp4"] || [fileName hasSuffix:@".sqlite"]) {
//                NSLog(@"不删除");
            }else{
                NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
                
                
                [fileManager removeItemAtPath:absolutePath error:nil];
            }
        }
        
    }
}



- (CGFloat)folderSizeAtPath:(NSString *)path
{
    //初始化一个文件管理类对象
    NSFileManager * fileManager = [NSFileManager defaultManager];
    CGFloat folderSize;
    
    //如果文件夹存在
    if ([fileManager fileExistsAtPath:path]) {
        NSArray * childerFiles = [fileManager subpathsAtPath:path];
        for (NSString * fileName in childerFiles) {
            if ([fileName hasSuffix:@".mp4"] || [fileName hasSuffix:@".sqlite"]) {
//                NSLog(@"不计算");
            }else
            {
                NSString * absolutePath = [path stringByAppendingPathComponent:fileName];
                folderSize += [self filePathSize:absolutePath];
            }
        }
        [self showCacheFileSizeToDelete:folderSize];
        return folderSize;
    }return 0;
    
}

- (NSString *)getPath
{
    //获取沙河文件夹下的library下caches文件夹路径   caches文件夹主要存放缓存文件
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
//    NSLog(@"%@", path);
    return path;
    
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
