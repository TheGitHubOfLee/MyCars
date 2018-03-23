//
//  InformationViewController.m
//  MyCar
//
//  Created by lanouhn on 16/3/3.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "InformationViewController.h"
#import "Header.h"
BOOL isDown;

@interface InformationViewController ()<NetWorkHelperDelegate, SDCycleScrollViewDelegate>

@property (assign, nonatomic) NSInteger page;
@property (strong, nonatomic) NSMutableArray *picArray;
@end

@implementation InformationViewController

- (NSMutableArray *)picArray {
    if (!_picArray) {
        self.picArray = [NSMutableArray array];
    }
    return _picArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.tableView registerNib:[UINib nibWithNibName:@"ListCell1" bundle:nil] forCellReuseIdentifier:@"ListCell"];
    [self.tableView registerNib: [UINib nibWithNibName:@"ListCell2" bundle:nil]forCellReuseIdentifier:@"ListCell2"];
    isDown = YES;
    self.page = 1;
    [NetWorkHelper shareHelper].delegate = self;
//    [[NetWorkHelper shareHelper] paseDataWithURL:kInfUrl];

    [self addRefreshAndMore];

    
    
}

- (void)addRefreshAndMore {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        isDown = YES;
        self.page = 1;
        [[NetWorkHelper shareHelper] paseDataWithURL:[NSString stringWithFormat:kInfUrl, self.page]];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        isDown = NO;
        self.page++;
        [[NetWorkHelper shareHelper] paseDataWithURL:[NSString stringWithFormat:kInfUrl, self.page]];
    }];
    [self.tableView.mj_header beginRefreshing];
    
}


- (void)tableViewReloadData {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.page == 1) {
            [self.tableView.mj_header endRefreshing];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
        
        
        /*
        [self.picArray addObjectsFromArray:[NetWorkHelper shareHelper].picUrl];
        DCPicScrollView *picView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, kWidth, 180) WithImageUrls:self.picArray];
        picView.placeImage = [UIImage imageNamed:@"666"];
        [self.view addSubview:picView];
        [picView setImageViewDidTapAtIndex:^(NSInteger index) {
            
            DetailWebController *detailVC = [DetailWebController new];
            ListModel *model = [NetWorkHelper shareHelper].dcPic[index];
            detailVC.detailStr = [NSString stringWithFormat:kDetailUrl1, model.newsId];
            detailVC.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:detailVC animated:YES];
            
        }];
        picView.AutoScrollDelay = 3.0f;
        
        
        self.tableView.tableHeaderView = picView;
         */
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kWidth, 180) shouldInfiniteLoop:YES imageNamesGroup:[NetWorkHelper shareHelper].picUrl];
        cycleScrollView.delegate = self;
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        cycleScrollView.pageControlAliment =SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView.titlesGroup = [NetWorkHelper shareHelper].titleArr;
        cycleScrollView.autoScrollTimeInterval = 4.0;
        [self.view addSubview:cycleScrollView];
        self.tableView.tableHeaderView = cycleScrollView;
//        NSLog(@"%@", [NetWorkHelper shareHelper].picUrl);
        [self.tableView reloadData];
    });

}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    DetailWebController *detailVC = [DetailWebController new];
    ListModel *model = [NetWorkHelper shareHelper].dcPic[index];
    detailVC.detailStr = [NSString stringWithFormat:kDetailUrl1, model.newsId];
    detailVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detailVC animated:YES];
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
//    NSLog(@"%ld", [NetWorkHelper shareHelper].dataArray.count);
    return [NetWorkHelper shareHelper].dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailWebController *detailVC = [DetailWebController new];
    ListModel *model = [NetWorkHelper shareHelper].dataArray[indexPath.row];
    detailVC.detailStr = [NSString stringWithFormat:kDetailUrl1, model.newsId];
    detailVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
        
        ListModel *listModel = [NetWorkHelper shareHelper].dataArray[indexPath.row];
        if ([listModel.picCover rangeOfString:@";"].location != NSNotFound) {
            ListCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell2" forIndexPath:indexPath];
            [cell configureCellWithModel:listModel];
            return cell;
        }else {
        ListCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell" forIndexPath:indexPath];
            [cell setValueWithModel:listModel];
            return cell;
        }
        
    }



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
            ListModel *listModel = [NetWorkHelper shareHelper].dataArray[indexPath.row];
        if ([listModel.picCover rangeOfString:@";"].location != NSNotFound) {
            return 100 + 5;
        }else {
            return 76 +5;
        
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
