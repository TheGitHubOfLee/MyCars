//
//  ConversionController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/7.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "ConversionController.h"
#import "Header.h"
@interface ConversionController ()
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) BOOL isDown;
@property (assign, nonatomic) NSInteger page;
@end

@implementation ConversionController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ConversionCell" bundle:nil] forCellReuseIdentifier:@"ConversionCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ConversionVideoCell" bundle:nil] forCellReuseIdentifier:@"ConversionVideoCell"];
    self.isDown = YES;
    self.page = 1;
    
    [self addRefreshAndMore];
}

- (void)addRefreshAndMore {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.isDown = YES;
        self.page = 1;
        [self paseDataWithURL:[NSString stringWithFormat:kChangeUrl, self.page]];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.isDown = NO;
        self.page++;
        [self paseDataWithURL:[NSString stringWithFormat:kChangeUrl, self.page]];
    }];
    [self.tableView.mj_header beginRefreshing];
    
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
            
            NSArray *listArr = dic[@"data"];
            for (NSDictionary *dict in listArr) {
                ConversionModel *model = [ConversionModel new];
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
            [self.tableView.mj_header endRefreshing];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView reloadData];
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 216;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ConversionModel *model = self.dataArray[indexPath.row];
    
    if (model.type != 3) {
        ConversionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConversionCell" forIndexPath:indexPath];
        [cell setValueWithModel:model];
        return cell;
        
    } else {
        ConversionVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConversionVideoCell" forIndexPath:indexPath];
        [cell setValueWithModel:model];
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ConDetailController *detailVC = [ConDetailController new];
    ConversionModel *model = self.dataArray[indexPath.row];
    if (model.type == 1) {
        detailVC.detailStr = [NSString stringWithFormat:@"%@%@", kChangeDetailUrl1, model.modi_case[@"id"]];

        [self.navigationController pushViewController:detailVC animated:YES];
    }else if (model.type == 2) {
        detailVC.detailStr = [NSString stringWithFormat:@"%@%@", kChangeDetailUrl3, model.article[@"id"]];
        [self.navigationController pushViewController:detailVC animated:YES];
    }else {
        
        NSString *str1 = [NSString stringWithFormat:@"%@%@",kChangeDetailUrl2, model.video[@"id"]];
        NSString *str2 = [NSString stringWithFormat:@"%@%@",kChangeDetailUrl4, model.video[@"type"]];
        
        detailVC.detailStr = [NSString stringWithFormat:@"%@%@", str1, str2];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
 
    }
    
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
