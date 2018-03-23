//
//  RedioDetailController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "RedioDetailController.h"
#include "Header.h"
#import <AVFoundation/AVFoundation.h>




@interface RedioDetailController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) PlayerManager *playManager;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@property (strong, nonatomic) IBOutlet UIImageView *musicPic;
@property (strong, nonatomic) IBOutlet UISlider *progessSlider;
@property (strong, nonatomic) IBOutlet UILabel *leftLabel;

@property (strong, nonatomic) IBOutlet UIButton *playerButton;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableV;
//@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *dataArray2;


@property (assign, nonatomic) BOOL isDown;
@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) NSInteger page1;
@property (strong, nonatomic) NSMutableDictionary *dict;
@property (assign, nonatomic) NSInteger  (^block)();


@property (nonatomic, assign) NSInteger currentPlayNumber;
@property (nonatomic, strong) NSMutableArray *musicArray;
@property (assign, nonatomic) CGFloat angle;
@property (strong, nonatomic) CALayer *player;
@end

@implementation RedioDetailController


- (NSMutableArray *)musicArray {
    if (!_musicArray) {
        self.musicArray = [NSMutableArray array];
    }
    return _musicArray;
}

- (NSMutableDictionary *)dict {
    if (!_dict) {
        self.dict = [NSMutableDictionary   dictionary];
    }
    return _dict;
}

- (NSMutableArray *)dataArray2 {
    if (!_dataArray2) {
        self.dataArray2 = [NSMutableArray array];
    }
    return _dataArray2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isDown = YES;
    self.page = 0;
    self.page1 = 20;
    self.currentPlayNumber = 0;
    
//    self.player = self.musicPic.layer;
//    [self.view addSubview: self.player];
    
    [self loadDataWithUrl:[NSString stringWithFormat:kPlayUrl, self.postId]];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
   
    
}

- (void)playEnd {
    [self.playerButton setTitle:@"播放" forState:(UIControlStateNormal)];
    [[PlayerManager sharePlayer].player pause];
    [self pauseLayer:self.musicPic.layer];


}

- (void)addRefreshAndMore {
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.isDown = YES;
        self.page = 0;
        self.page1 = 20;
        NSString *str = [NSString stringWithFormat:@"%ld-%ld", self.page, self.page1];
        [self loadListDataWithUrl:[NSString stringWithFormat:kDetailPlayUrl, self.dict[@"A"], str]];
    }];
    
    self.tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.isDown = NO;
        self.page += 20;
        self.page1 += 20;
        NSString *str = [NSString stringWithFormat:@"%ld-%ld", self.page, self.page1];
        [self loadListDataWithUrl:[NSString stringWithFormat:kDetailPlayUrl, self.dict[@"A"], str]];
    }];
    [self.tableV.mj_header beginRefreshing];
    
}



- (void)loadDataWithUrl:(NSString *)url {

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession]dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data) {
            [self.musicArray removeAllObjects];
        }
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        NSDictionary *dic1 = dic[self.postId];
        NSArray *arr = dic1[@"video"];
        [self.dict setObject:dic1[@"tid"] forKey:@"A"];
        for (NSDictionary *dic2 in arr) {
            RedioModel *model = [RedioModel new];
            [model setValuesForKeysWithDictionary:dic2];
            [self.musicArray addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setAllControl];
            [self playerBegin];
            [self addRefreshAndMore];

        });
        }];
    [dataTask resume];
    
}

- (void)loadDataWithUrl1:(NSString *)url1 postid:(NSString *)postid {
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url1]];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession]dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            [self.musicArray removeAllObjects];
        }
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        NSDictionary *dic1 = dic[postid];
        NSArray *arr = dic1[@"video"];

        for (NSDictionary *dic2 in arr) {
            RedioModel *model = [RedioModel new];
            [model setValuesForKeysWithDictionary:dic2];
            [self.musicArray addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setAllControl];
            [self playerBegin];

            
        });
    }];
    [dataTask resume];
    
}

- (void)loadListDataWithUrl:(NSString *)url {

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            if (_isDown) {
                
                [self.dataArray2 removeAllObjects];
            }

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            
            NSString *str = self.dict[@"A"];

        NSArray *arr = dic[str];

        for (NSDictionary *dic1 in arr) {
            RedioModel *model = [RedioModel new];
            [model setValuesForKeysWithDictionary:dic1];
            [self.dataArray2 addObject:model];
        }
        [self tableViewReloadData];
    }
    }];
    
    [dataTask resume];
}

- (void)tableViewReloadData {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (self.page == 0) {
            [self.tableV.mj_header endRefreshing];
        }else {
            [self.tableV.mj_footer endRefreshing];
        }
        [self.tableV reloadData];
    });
    
}



- (void)setAllControl{

    RedioModel *model = self.musicArray[0];
    self.titleLabel.text = model.alt;
    [self.musicPic sd_setImageWithURL:[NSURL URLWithString:model.cover]];
}




- (IBAction)playButton:(UIButton *)sender {
    
    if ([sender.currentTitle isEqualToString:@"播放"]) {
        [sender setTitle:@"暂停" forState:(UIControlStateNormal)];
        [[PlayerManager sharePlayer].player play];
        [self resumeLayer:self.musicPic.layer];
    }else {
        [sender setTitle:@"播放" forState:(UIControlStateNormal)];
        [[PlayerManager sharePlayer].player pause];
        [self pauseLayer:self.musicPic.layer];
    }
    
}

- (void)playerBegin {

    RedioModel *model = self.musicArray[0];
    self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:model.url_mp4]];
    [self setPlayerItem];
    self.playerItem = _playerItem;
    [self.progessSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [[PlayerManager sharePlayer].player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        CGFloat currentTime = CMTimeGetSeconds(time);
        CGFloat totalTime = CMTimeGetSeconds(_playerItem.duration);
        self.leftLabel.text = [self updateTimeString];
        [self.progessSlider setValue:currentTime / totalTime];
    }];
    [self startAnimation];
    
}

#pragma mark - 讲当前时间转成时间戳给label显示
- (NSString*)updateTimeString
{
    NSTimeInterval currentTime = CMTimeGetSeconds([PlayerManager sharePlayer].player.currentItem.currentTime);
    NSTimeInterval duration = CMTimeGetSeconds([PlayerManager sharePlayer].player.currentItem.duration);
    return [self stringWithCurrentTime:currentTime duration:duration];
}
- (NSString *)stringWithCurrentTime:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration
{
    NSInteger dMin = duration / 60;
    NSInteger dSec = (NSInteger)duration % 60;
    NSInteger cMin = currentTime / 60;
    NSInteger cSec = (NSInteger)currentTime % 60;
    NSString *durationString = [NSString stringWithFormat:@"%02ld:%02ld", dMin, dSec];
    NSString *currentString = [NSString stringWithFormat:@"%02ld:%02ld", cMin, cSec];
    return [NSString stringWithFormat:@"%@/%@", currentString, durationString];
}

/**
 * 滑块拖动
 */
- (void)sliderValueChanged:(UISlider *)sender
{
    [[PlayerManager sharePlayer].player pause];
    [self.playerButton setTitle:@"播放" forState:UIControlStateNormal];
    CGFloat t = sender.value * CMTimeGetSeconds(self.playerItem.duration);
    switch ([self.playerItem status]) {
        case AVPlayerItemStatusReadyToPlay:{
            [[PlayerManager sharePlayer].player seekToTime:CMTimeMake(t, 1) completionHandler:^(BOOL finished) {
                [[PlayerManager sharePlayer].player play];
                [self.playerButton setTitle:@"暂停" forState:UIControlStateNormal];            }];
        }
            break;
            
        default:
            break;
    }
    
}

-(void) startAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    self.musicPic.transform = CGAffineTransformMakeRotation(_angle * (M_PI / 180.0f));
    [UIView commitAnimations];
}

-(void)endAnimation
{
    
    __weak typeof(self) weakSelf = self;
    _angle += 1;
    [weakSelf startAnimation];
}

-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] -    pausedTime;
    layer.beginTime = timeSincePause;
}

- (void)setPlayerItem{
    [[PlayerManager sharePlayer].player replaceCurrentItemWithPlayerItem:self.playerItem];
    [[PlayerManager sharePlayer].player play];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray2.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableV dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    
//    self.block = ^(){
//        return indexPath.row;
//    };
    
    RedioModel *model = self.dataArray2[indexPath.row];
    cell.textLabel.text = model.title;

    cell.detailTextLabel.text = model.ptime;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.currentPlayNumber = indexPath.row;
    RedioModel *model = self.dataArray2[indexPath.row];
    
   [self loadDataWithUrl1:[NSString stringWithFormat:kPlayUrl, model.postid] postid:model.postid];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {

    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
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
