//
//  FindCarController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/10.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "FindCarController.h"
#import "Header.h"
#import "FindCarCell.h"
@interface FindCarController () 
@property (strong, nonatomic) IBOutlet UITableView *tableV;

@property (assign, nonatomic) BOOL isDown;
@property (strong, nonatomic) NSMutableDictionary *dataDic;
@property (strong, nonatomic) ShowTableView *showVC;

;
@end

@implementation FindCarController


- (NSMutableDictionary *)dataDic {
    if (!_dataDic) {
        self.dataDic = [[NSMutableDictionary alloc]init];
    }
    return _dataDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isDown = YES;
    
    [self.tableV registerNib:[UINib nibWithNibName:@"SearchCarCell" bundle:nil] forCellReuseIdentifier:@"SearchCarCell"];
    
    [self addRefreshAndMore];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.showVC = [story instantiateViewControllerWithIdentifier:@"showVC"];
    self.showVC.view.frame = CGRectMake(kWidth, 0, kWidth - 80, kHeight);
    [self addChildViewController:self.showVC];
//    [self.tableV addSubview:self.showVC.view];
    
    UISwipeGestureRecognizer * swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
    [self.view addGestureRecognizer:swip];
}

- (void)addRefreshAndMore {
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.isDown = YES;
        
        [self paseDataWithURL:kFindCarListUrl];
    }];
    
    [self.tableV.mj_header beginRefreshing];
    
    
}

///NSString *statickey = @"A";

- (void)paseDataWithURL:(NSString *)urlStr {
    [AFManegerHelp Get:urlStr parameters:nil success:^(id responseObjeck) {
        NSArray *arr = responseObjeck[@"data"];
        NSLog(@"%@", responseObjeck);
        for (NSDictionary *dic in arr) {
        FindCarModel *model = [[FindCarModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
            [model setValuesForKeysWithDictionary:dic];
            NSString *initialKey = dic[@"initial"];
            if (![[self.dataDic allKeys]containsObject:initialKey]) {
                NSMutableArray *array = [NSMutableArray array];
                [array addObject:model];
                [self.dataDic setObject:array forKey:initialKey];
            }else {
                [[self.dataDic objectForKey:initialKey] addObject:model];
            }
        }
//        NSLog(@"%@", self.dataDic);
        [self.tableV.mj_header endRefreshing];
        [self.tableV reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataDic.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return [[self.dataDic objectForKey:[[self sortKey] objectAtIndex:section - 1]]count];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return;
    }
    self.delegate = self.showVC;
    
    [self.delegate loadDataWithBrand:[[[self.dataDic objectForKey:[[self sortKey] objectAtIndex:indexPath.section - 1]] objectAtIndex:indexPath.row] valueForKey:@"masterId"] andpic:[[[self.dataDic objectForKey:[[self sortKey] objectAtIndex:indexPath.section - 1]] objectAtIndex:indexPath.row] valueForKey:@"logoUrl"]];
    
    
    [self moveOut];
    
}


#pragma mark -

- (void)moveOut
{
    [self.view insertSubview:self.showVC.view aboveSubview:self.view];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.showVC.view.frame = CGRectMake(80, 0, kWidth - 80, kHeight);
    }];
}

- (void)moveIn
{
    [UIView animateWithDuration:0.3 animations:^{
        self.showVC.view.frame = CGRectMake(kWidth, 0, kWidth - 80, kHeight);
    }];
}


- (void)gestureAction:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self moveIn];
        
        
    }else if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        [self moveOut];
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self moveIn];
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        if (indexPath.section == 0) {
            FindCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FindCarCell" forIndexPath:indexPath];
            
            return cell;
        }else{
            SearchCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCarCell" forIndexPath:indexPath];
//            NSLog(@"%@", model.name);
            
            FindCarModel *model = [[self.dataDic objectForKey:[[self sortKey] objectAtIndex:indexPath.section -1]] objectAtIndex:indexPath.row];
            
            [cell setValueWithModel:model];
        
        return cell;
        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   if (indexPath.section != 0){
        return 60;
    }else {
        return 80;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
        if (section == 0) {
            UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kWidth, 10)] ;
            
            aLabel.text = @"条件选车";
            aLabel.textAlignment = 1;
            
            aLabel.backgroundColor = [UIColor colorWithRed:0.122 green:0.200 blue:0.455 alpha:0.711];
            return aLabel;
        } else {
            UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, 30)];
            aLabel.backgroundColor = [UIColor colorWithRed:0.122 green:0.200 blue:0.455 alpha:0.711];
            aLabel.text = [NSString stringWithFormat:@"      %@", [[self sortKey] objectAtIndex:section - 1]];
//            NSLog(@"%@", _allKeysMutbleArray);
            
            
            aLabel.font = [UIFont boldSystemFontOfSize:15];
            return aLabel;
        }
    }

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

#pragma mark 索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[self sortKey]];
    
    [arr insertObject:@"#" atIndex:0];
    return (NSArray *)arr;

}

- (NSArray *)sortKey
{
    return  [[self.dataDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
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
