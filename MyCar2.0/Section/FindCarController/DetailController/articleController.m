//
//  articleController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/11.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "articleController.h"
#import "Header.h"

@interface articleController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableV;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) BOOL isDown;
@property (assign, nonatomic) NSInteger page;

@end

@implementation articleController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isDown = YES;
    self.page = 1;
    
    
}

- (void)RelodDataWithUrl2:(NSString *)url2{
    [self addRefreshAndMoreWithUrl:url2];
}


- (void)addRefreshAndMoreWithUrl:(NSString *)url {
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.isDown = YES;
        self.page = 1;
        NSString *str = [NSString stringWithFormat:kArctilurl2, self.page];
        [self paseDataWithURL:[NSString stringWithFormat:@"%@%@", url, str]];
    }];
    
    self.tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.isDown = NO;
        self.page++;
        NSString *str = [NSString stringWithFormat:kArctilurl2, self.page];
        [self paseDataWithURL:[NSString stringWithFormat:@"%@%@", url, str]];
    }];
    [self.tableV.mj_header beginRefreshing];
    
}

- (void)paseDataWithURL:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    //    NSLog(@"%@", urlStr);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            if (_isDown) {
                //                NSLog(@"123");
                [self.dataArray removeAllObjects];
            }
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            NSDictionary *dic1 = dic[@"data"];
            NSArray *listArr = dic1[@"list"];
            for (NSDictionary *dict in listArr) {
                DetailModel *model = [DetailModel new];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataArray addObject:model];
            }
            
            [self tableViewReloadData];
        }
    }];
    
    [dataTask resume];
    
};


- (void)tableViewReloadData {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.page == 1) {
            [self.tableV.mj_header endRefreshing];
        }else {
            [self.tableV.mj_footer endRefreshing];
        }
        [self.tableV reloadData];
    });
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"articalCell" forIndexPath:indexPath];
    DetailModel *model = self.dataArray[indexPath.row];
    [cell setValueWithModel:model];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailWebController *detailVC = [DetailWebController new];
    DetailModel *model = self.dataArray[indexPath.row];
    detailVC.detailStr = [NSString stringWithFormat:kArctilDetailUrl, model.newsId];
    detailVC.hidesBottomBarWhenPushed = YES;
    
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
