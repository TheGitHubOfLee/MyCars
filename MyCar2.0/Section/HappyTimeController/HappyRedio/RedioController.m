//
//  RedioController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/9.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "RedioController.h"
#import "Header.h"
#import "RedioDetailController.h"
@interface RedioController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tablev;
@property (strong, nonatomic) NSMutableArray *dataArray1;
@property (strong, nonatomic) NSMutableArray *dataArray2;
@property (assign, nonatomic) BOOL isDown;
@property (copy, nonatomic) NSString *cid;
@property (copy, nonatomic) NSString *cname;
@end

@implementation RedioController

- (NSMutableArray *)dataArray1 {
    if (!_dataArray1) {
        self.dataArray1 = [NSMutableArray  array];
    }
    return _dataArray1;
}

- (NSMutableArray *)dataArray2 {
    if (!_dataArray1) {
        self.dataArray2 = [NSMutableArray array];
    }
    return _dataArray2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isDown = YES;

    [self addRefreshAndMore];
    // Do any additional setup after loading the view.
}

- (void)addRefreshAndMore {
    self.tablev.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.isDown = YES;
        
        [self paseDataWithURL:[NSString stringWithFormat:kRedioUrl, self.cidStr]];
    }];
    
    [self.tablev.mj_header beginRefreshing];
    
    
}

- (void)paseDataWithURL:(NSString *)urlStr {
 [AFManegerHelp Get:urlStr parameters:nil success:^(id responseObjeck) {
     NSArray *arr = responseObjeck[@"tList"];
     for (NSDictionary *dic in arr) {
         RedioModel *model = [[RedioModel alloc]init];
         
         NSDictionary *dic2 = dic[@"radio"];
         [model setValuesForKeysWithDictionary:dic2];
         [self.dataArray1 addObject:model];
         
     }
     [self.tablev.mj_header endRefreshing];
     [self.tablev reloadData];

 } failure:^(NSError *error) {
     
 }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray1.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RedioCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RedioCell" forIndexPath:indexPath];
    RedioModel *model = self.dataArray1[indexPath.row];
    [cell setValueWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RedioModel *model = self.dataArray1[indexPath.row];
    RedioDetailController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"redioVC"];
    detailVC.postId = model.postid;
    
    [self.navigationController pushViewController:detailVC animated:YES];
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
