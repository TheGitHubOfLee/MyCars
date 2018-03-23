//
//  HappyListDetailController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/9.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "HappyListDetailController.h"
#import "Header.h"
@interface HappyListDetailController ()< UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionV;
@property (strong, nonatomic) NSMutableArray *dataArray1;
@property (assign, nonatomic) BOOL isDown;
@property (assign, nonatomic) NSInteger page1;
@property (assign, nonatomic) NSInteger page2;
@end

@implementation HappyListDetailController

- (NSMutableArray *)dataArray1 {
    if (!_dataArray1) {
        self.dataArray1 = [NSMutableArray  array];
    }
    return _dataArray1;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.isDown = YES;
    self.page1 = 0;
    self.page2 = 10;
    [self.collectionV registerNib:[UINib nibWithNibName:@"HVideoCell1" bundle:nil] forCellWithReuseIdentifier:@"VideoCell2"];
    self.navigationItem.title = self.titleN;
    [self addRefreshAndMore];
}

- (void)addRefreshAndMore {
    self.collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.isDown = YES;
        self.page1 = 0;
        self.page2 = 10;
        [self paseDataWithURL:[NSString stringWithFormat:kHappyVideoDetailUrl,self.sidStr, self.page1, self.page2]];
    }];
    
    self.collectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.isDown = NO;
        self.page1 += 10;
        self.page2 += 10;
        [self paseDataWithURL:[NSString stringWithFormat:kHappyVideoDetailUrl,self.sidStr, self.page1, self.page2]];
//        NSLog(@"%@", [NSString stringWithFormat:kHappyVideoDetailUrl,self.sidStr, self.page1, self.page2]);
    }];
    [self.collectionV.mj_header beginRefreshing];
    
    
}

- (void)paseDataWithURL:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    //    NSLog(@"%@", urlStr);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"%@", data);
        if (data) {
            
            if (_isDown) {
                //                NSLog(@"123");
                [self.dataArray1 removeAllObjects];
            }
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            
            NSArray *listArr = dic[self.sidStr];
            for (NSDictionary *dict in listArr) {
                HappyModel *model = [HappyModel new];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataArray1 addObject:model];
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self tableViewReloadData];
                
            });
        }
    }];
    
    [dataTask resume];
    
};


- (void)tableViewReloadData {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.page1 == 0) {
            [self.collectionV.mj_header endRefreshing];
            
        }else {
            [self.collectionV.mj_footer endRefreshing];
            
        }
        [self.collectionV reloadData];
    });
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath  {
    HVideoCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCell2" forIndexPath:indexPath];
    HappyModel *model = self.dataArray1[indexPath.item];
    [cell setValueWithModel:model];
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray1.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(kWidth, kHeight/2.3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
        HappyModel *model = self.dataArray1[indexPath.item];
        LGQAVPlayerViewController *detailVC = [[LGQAVPlayerViewController alloc]initWithUrl:model.mp4_url];
        //        NSLog(@"%@", model.mp4_url);
        [self presentViewController:detailVC animated:YES completion:nil];
    
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
