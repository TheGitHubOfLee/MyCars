//
//  VDetailController3.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/7.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "VDetailController3.h"
#import "Header.h"
@interface VDetailController3 ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *collection3;
@property (nonatomic, retain)NSMutableArray *dataSource;
@property (assign, nonatomic) BOOL isDown;
@property (assign, nonatomic) NSInteger page;
@end

@implementation VDetailController3
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
    self.collection3.collectionViewLayout = layOut;
    // 配置属性
    _collection3.dataSource = self;
    _collection3.delegate = self;
    [self.view addSubview:_collection3];
    [self.collection3 registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:kCellID];
    [self addRefreshAndMore];
}

- (void)addRefreshAndMore {
    self.collection3.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.isDown = YES;
        self.page = 1;
        [self paseDataWithURL:[NSString stringWithFormat:kVideoUrl3, self.page]];
    }];
    
    self.collection3.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.isDown = NO;
        self.page++;
        [self paseDataWithURL:[NSString stringWithFormat:kVideoUrl3, self.page]];
    }];
    [self.collection3.mj_header beginRefreshing];
    
}

- (void)paseDataWithURL:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    //    NSLog(@"%@", urlStr);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            if (_isDown) {
                //                NSLog(@"123");
                [self.dataSource removeAllObjects];
            }
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            NSDictionary *dic1 = dic[@"data"];
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
            [self.collection3.mj_header endRefreshing];
        }else {
            [self.collection3.mj_footer endRefreshing];
        }
        [self.collection3 reloadData];
    });
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
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
