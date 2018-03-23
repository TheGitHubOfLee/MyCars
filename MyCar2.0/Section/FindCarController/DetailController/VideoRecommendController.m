//
//  VideoRecommendController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/11.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "VideoRecommendController.h"
#import "Header.h"
@interface VideoRecommendController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *collecV;
@property (nonatomic, retain)NSMutableArray *dataSource;
@property (assign, nonatomic) BOOL isDown;
@property (assign, nonatomic) NSInteger page;

@end

@implementation VideoRecommendController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self configureCollectionView];
}

- (void)configureCollectionView {
    
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.itemSize = CGSizeMake((kWidth - 40) / 2, 140);
    layOut.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collecV.collectionViewLayout = layOut;
    // 配置属性
    
    [self.view addSubview:_collecV];
    [_collecV registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:kCellID];
    }


- (void)RelodDataWithUrl3:(NSString *)url3 {
    [self addRefreshAndMoreWithUrl:url3];

}


- (void)addRefreshAndMoreWithUrl:(NSString *)url {
    self.collecV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.isDown = YES;
        self.page = 1;
        NSString *str = [NSString stringWithFormat:kDetailVideo1, self.page];
        [self paseDataWithURL:[NSString stringWithFormat:@"%@%@", url, str]];
    }];
    
    self.collecV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.isDown = NO;
        self.page++;
        [self paseDataWithURL:[NSString stringWithFormat:kDetailVideo1, self.page]];
    }];
    [self.collecV.mj_header beginRefreshing];
    
}

- (void)paseDataWithURL:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
//        NSLog(@"%@", urlStr);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            if (_isDown) {
                //                NSLog(@"123");
                [self.dataSource removeAllObjects];
            }
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            NSDictionary *dic1 = dic[@"data"];
//            NSLog(@"%@", dic);
            NSArray *listArr = dic1[@"list"];
            for (NSDictionary *dict in listArr) {
                ListModel *model = [ListModel new];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataSource addObject:model];
            }
            
            [self tableViewReloadData];
        }
    }];
    
    [dataTask resume];
    
};


- (void)tableViewReloadData {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.page == 1) {
            [self.collecV.mj_header endRefreshing];
        }else {
            [self.collecV.mj_footer endRefreshing];
        }
        [self.collecV reloadData];
    });
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //    NSLog(@"%ld", self.dataSource.count);
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    ListModel *model = self.dataSource[indexPath.row];
    [cell setValueWithModel:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ListModel *model = self.dataSource[indexPath.row];
    
    LGQAVPlayerViewController *detailVC = [[LGQAVPlayerViewController alloc]initWithUrl:model.Mp4Link];
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
