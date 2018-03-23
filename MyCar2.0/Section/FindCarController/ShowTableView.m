//
//  ShowTableView.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/11.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "ShowTableView.h"
#import "Header.h"
#import "FindCarModel1.h"
@interface ShowTableView () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableV;
@property (nonatomic, strong) NSMutableArray * datasourceArray;
@property (strong, nonatomic) NSMutableDictionary *dataDic;
@property (strong, nonatomic) NSMutableDictionary *dict;
@property (assign, nonatomic) BOOL isDown;
@property (strong, nonatomic) NSMutableArray *introArr;
@property (strong, nonatomic) UIView *backView;
@end

@implementation ShowTableView

- (void)loadDataWithBrand:(NSString *)brand andpic:(NSString *)picUrl
{

    self.brand = brand;
    self.picUrl = picUrl;
//    NSLog(@"%@", self.picUrl);
    self.datasourceArray = nil;
    [self addRefreshAndMore];
    
}

- (NSMutableArray *)introArr {
    if (!_introArr) {
        self.introArr = [NSMutableArray array];
    }
    return _introArr;
}

- (NSMutableDictionary *)dict {
    if (!_dict) {
        self.dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}

- (NSMutableDictionary *)dataDic {
    if (!_dataDic) {
        self.dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}
-(NSMutableArray *)datasourceArray
{
    if (_datasourceArray == nil) {
        self.datasourceArray = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _datasourceArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isDown = YES;
//    self.tableV.contentInset = UIEdgeInsetsMake(64, 0, 50, 0);
    [self.tableV registerNib:[UINib nibWithNibName:@"AllVechicleModelCell" bundle:nil] forCellReuseIdentifier:@"AllVechicleModelCell"];
    [self.tableV registerNib:[UINib nibWithNibName:@"IntroductionCell" bundle:nil] forCellReuseIdentifier:@"IntroCell"];
    [self.tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
}

- (void)addRefreshAndMore {
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.isDown = YES;
        
        [self paseDataWithURL:[NSString stringWithFormat:kCarListUrl, self.brand]];
       [self loadDataWithUrl:[NSString stringWithFormat:kIntrouctionUrl,self.brand]];
    }];
    
    [self.tableV.mj_header beginRefreshing];
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth - 80, self.tableV.frame.size.height)];
//    self.backView.backgroundColor = [UIColor redColor];
    [self.tableV addSubview:self.backView];
    
}


- (void)paseDataWithURL:(NSString *)urlStr {
    
[AFManegerHelp Get:urlStr parameters:nil success:^(id responseObjeck) {
    NSArray *arr = responseObjeck[@"data"];
    NSString *key;
    if (arr != nil) {
        if (self.isDown) {
            [self.tableV.mj_header endRefreshing];
            [self.datasourceArray removeAllObjects];
            [self.dataDic removeAllObjects];
            [self.backView removeFromSuperview];
            
        }
    
    for (NSDictionary *dic in arr) {
        key = dic[@"brandName"];
        
        [self.dataDic setValue:dic[@"serialList"] forKey:key];
        
//        NSLog(@"%@", self.arr2);
        for (NSDictionary *dic2 in dic[@"serialList"]) {
            FindCarModel1 *model = [FindCarModel1 new];
            [model setValuesForKeysWithDictionary:dic2];
            [self.datasourceArray addObject:model];
        }
    }
        }
//    NSLog(@"%@", self.dataDic);
    [self.tableV reloadData];
} failure:^(NSError *error) {
    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataDic.count +1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    
    NSMutableArray *arr = [NSMutableArray array];
     arr = [self.dataDic.allValues objectAtIndex:section - 1];
//    NSLog(@"%ld", arr.count);
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.datasourceArray != nil) {
        
    
    
    if (indexPath.section != 0) {
    
    
    
    AllVechicleModelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllVechicleModelCell" forIndexPath:indexPath];
    
    
    cell.contentView.layer.borderWidth = 1;
    cell.contentView.layer.borderColor = [UIColor colorWithRed:0.000 green:0.502 blue:0.502 alpha:1.000].CGColor;
    cell.contentView.layer.cornerRadius = 8;
    FindCarModel1 *model = self.datasourceArray[indexPath.row];
    [cell setValueWithModel:model];
    
    return cell;
        }
        }
    IntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntroCell" forIndexPath:indexPath];

    [cell setValueWithPicUrl:self.picUrl];
//    self.picUrl = nil;
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60;
    }
    return 80;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    return self.dataDic.allKeys[section - 1];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        IntroductionController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"jianjie"];
        IntroductionModel *model = self.introArr[0];
        
        detailVC.masterName = model.masterName;
        
        detailVC.introduction = model.introduction;
        detailVC.logoMeaning = model.logoMeaning;
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if (self.datasourceArray != nil){
    FindCarModel1 *model = self.datasourceArray[indexPath.row];
    
    DetailController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Detail"];
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.serialId = model.serialId;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    }
    
    

}


- (void)loadDataWithUrl:(NSString *)url {
    
    
    [AFManegerHelp Get:url parameters:nil success:^(id responseObjeck) {
        NSDictionary *dic1 = responseObjeck[@"data"];
//        NSLog(@"%@", dic1);
        if (dic1 != nil) {
            [self.introArr removeAllObjects];
        }
        IntroductionModel *model = [IntroductionModel new];
        [model setValuesForKeysWithDictionary:dic1];
        [self.introArr addObject:model];
        
    }
     
    failure:^(NSError *error) {
                   
    }];
    
    
    
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
