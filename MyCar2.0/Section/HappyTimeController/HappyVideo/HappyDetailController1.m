//
//  HappyDetailController1.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/8.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "HappyDetailController1.h"
#import "Header.h"
#import "HappyListDetailController.h"
@interface HappyDetailController1 ()< UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionV;

@property (strong, nonatomic) NSMutableArray *dataArray1;
@property (strong, nonatomic) NSMutableArray *dataArray2;
@property (assign, nonatomic) BOOL isDown;
@property (assign, nonatomic) NSInteger page1;
@property (assign, nonatomic) NSInteger page2;
@end

@implementation HappyDetailController1

- (NSMutableArray *)dataArray1 {
    if (!_dataArray1) {
        self.dataArray1 = [NSMutableArray  array];
    }
    return _dataArray1;
}

- (NSMutableArray *)dataArray2 {
    if (!_dataArray2) {
        self.dataArray2 = [NSMutableArray   array];
    }
    return _dataArray2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isDown = YES;
    self.page1 = 0;
    self.page2 = 10;
    [self.collectionV registerNib:[UINib nibWithNibName:@"HVideoCell1" bundle:nil] forCellWithReuseIdentifier:@"VideoCell2"];
    [self.collectionV registerNib:[UINib nibWithNibName:@"HVideoCell" bundle:nil] forCellWithReuseIdentifier:@"VideoCell"];
[self addRefreshAndMore];
}

//- (void)configureCollectionVC {
//    if ((self.dataArray1.count + self.dataArray2.count) <5) {
//        UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
//        layOut.itemSize = CGSizeMake(kWidth/4, kWidth/4);
//        layOut.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        self.collectionV.collectionViewLayout = layOut;
//
//    }else {
//    
//    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
//    
//    layOut.itemSize = CGSizeMake(kWidth, kWidth/4);
////    layOut.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    self.collectionV.collectionViewLayout = layOut;
//    }
//}

- (void)addRefreshAndMore {
    self.collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.isDown = YES;
        self.page1 = 0;
        self.page2 = 10;
        [self paseDataWithURL:[NSString stringWithFormat:kHappyVideoUrl, self.page1, self.page2]];
    }];
    
    self.collectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.dataArray2 removeAllObjects];
        self.isDown = NO;
        self.page1 += 10;
        self.page2 += 10;
        [self paseDataWithURL:[NSString stringWithFormat:kHappyVideoUrl, self.page1, self.page2]];
    }];
    [self.collectionV.mj_header beginRefreshing];
    
    
}

- (void)paseDataWithURL:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    //    NSLog(@"%@", urlStr);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            if (_isDown) {
                //                NSLog(@"123");
                [self.dataArray1 removeAllObjects];
                [self.dataArray2 removeAllObjects];
            }
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            
            NSArray *listArr = dic[@"videoList"];
            NSArray *listArr1 = dic[@"videoSidList"];
            for (NSDictionary *dict in listArr) {
                HappyModel *model = [HappyModel new];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataArray1 addObject:model];
//                NSLog(@"%ld", self.dataArray1.count);
//                [self configureCollectionVC];
            }
            
            for (NSDictionary *dict1 in listArr1) {
                HappyModel *model1 = [HappyModel new];
                [model1 setValuesForKeysWithDictionary:dict1];
                [self.dataArray2 addObject:model1];
//                NSLog(@"%ld", self.dataArray2.count);
//                [self configureCollectionVC];
            }
        [self tableViewReloadData];
            
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
    if (indexPath.section == 0) {
        
        HVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCell" forIndexPath:indexPath];
        HappyModel *model = self.dataArray2[indexPath.item];
        [cell setValueWithModel:model];
        if (indexPath.row == 2) {
            cell.nameLabel.text = @"尤物";
        }
        
        return cell;
    }else {
        
        HVideoCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCell2" forIndexPath:indexPath];
        HappyModel *model = self.dataArray1[indexPath.item];
        [cell setValueWithModel:model];
        return cell;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataArray2.count;
        
    }else {
        return self.dataArray1.count;
    }
    

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
         return CGSizeMake(kWidth/4, kWidth/4);
    }else {
        return CGSizeMake(kWidth, kHeight/2.3);
    }
   
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
        return UIEdgeInsetsMake(0, 0, 0, 0);

    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HappyModel *model = self.dataArray2[indexPath.item];
        HappyListDetailController *detailVC = [HappyListDetailController new];
        detailVC.sidStr = model.sid;
        detailVC.titleN = model.title;
        if (indexPath.row == 2) {
            detailVC.titleN = @"尤物";
        }
        
        [self.navigationController pushViewController:detailVC animated:YES];
    }else {
     HappyModel *model = self.dataArray1[indexPath.item];
        LGQAVPlayerViewController *detailVC = [[LGQAVPlayerViewController alloc]initWithUrl:model.mp4_url];
//        NSLog(@"%@", model.mp4_url);
        [self presentViewController:detailVC animated:YES completion:nil];
    }
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
