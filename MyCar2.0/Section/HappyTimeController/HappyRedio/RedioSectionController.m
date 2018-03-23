//
//  RedioSectionController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/19.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "RedioSectionController.h"
#import "RedioCollectionCell.h"
#import "Header.h"
#import "CollectionHeaderView.h"

@interface RedioSectionController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionVC;

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) NSMutableArray *musicArray;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *dataArray2;
@property (assign, nonatomic) BOOL isDown;
@property (assign, nonatomic) NSInteger currentPlayNumber;
@end

@implementation RedioSectionController

- (NSMutableArray *)musicArray {
    if (!_musicArray) {
        self.musicArray = [NSMutableArray array];
    }
    return _musicArray;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray    array];
    }
    
    return _dataArray;
}

- (NSMutableArray *)dataArray2 {
    if (!_dataArray2) {
        self.dataArray2 = [NSMutableArray    array];
    }
    
    return _dataArray2;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册页眉
    // 1.要重用视图的类
    // 2.要重用视图的种类kind (页眉/页脚)
    // 3.重用标识
//    [self.collectionVC registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];
    [self.collectionVC registerNib:[UINib nibWithNibName:@"RedioCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"redioCollectionCell"];
    
    self.isDown = YES;
    [self addFreshAndMore];
}

- (void)addFreshAndMore {

    self.collectionVC.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        // 进入刷新状态后会自动调用这个block
        self.isDown = YES;
        
        [self paseDataWithURL:kRediolistUrl];
    }];
    
    
    [self.collectionVC.mj_header beginRefreshing];
}

- (void)paseDataWithURL:(NSString *)urlStr {

    [AFManegerHelp Get:urlStr parameters:nil success:^(id responseObjeck) {
        for (NSDictionary *dic in responseObjeck[@"cList"]) {
            RedioModel *model = [RedioModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
            
            for (NSDictionary *dic1 in dic[@"tList"]) {
                NSDictionary *dic2 = dic1[@"radio"];
                RedioModel *model1 = [RedioModel new];
                [model1 setValuesForKeysWithDictionary:dic2];
                [self.dataArray2 addObject:model1];
            }
            
            
        }
        [self.collectionVC.mj_header endRefreshing];
        [self.collectionVC reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return self.dataArray.count ;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(kWidth/3, kWidth/2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

// 重用页眉和页脚的方法
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

        // kind存储的就是从用视图的种类
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionHeaderView *view1 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
//        UICollectionReusableView *view = nil;
//        view = view1;
        view1.backgroundColor = [UIColor lightGrayColor];
        view1.alpha = 0.6;
        RedioModel *model = self.dataArray[indexPath.section];
        view1.labelV.text = model.cname;
//        NSLog(@"%@", model.cname);
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//        label.backgroundColor = [UIColor whiteColor];
        self.view.backgroundColor = [UIColor whiteColor];
        
        view1.block = ^(){
//            NSLog(@"----%@",indexPath);
            
            RedioController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"redioList"];
            RedioModel *model = self.dataArray[indexPath.section];
            detailVC.cidStr = model.cid;
//            NSLog(@"%@", model.cid);
            [self.navigationController pushViewController:detailVC animated:YES];
            
        };
       
//            [view addGestureRecognizer:tap];
        
        
        return view1;
    }else {
        return nil;
    }
    
}




- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 30);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RedioCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"redioCollectionCell" forIndexPath:indexPath];
    
        RedioModel *model = self.dataArray2[indexPath.row + indexPath.section * 3];
        
        [cell setValueWithModel:model];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    RedioModel *model = self.dataArray2[indexPath.row + indexPath.section * 3];
   
    RedioDetailController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"redioVC"];
    detailVC.postId = model.postid;
    detailVC.cidStr = model.cid;
    
   
    [self.navigationController pushViewController:detailVC animated:YES];
}

//- (void)tapAction:(UITapGestureRecognizer *)sender {
//    NSUInteger page = [sender.view.superview.subviews indexOfObject:sender.view];

//    NSIndexPath *indexPath = [self.collectionVC indexPathForCell:(RedioCollectionCell *)sender.view.superview.superview];
//    NSLog(@"%ld", indexPath.section);
   
    
//}


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
