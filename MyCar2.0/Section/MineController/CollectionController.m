//
//  CollectionController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "CollectionController.h"
#import "DataBaseHeader.h"
#import "Header.h"
#import "AboutController.h"
#import "CollectionDetailController.h"
@interface CollectionController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableV;
@property (nonatomic, strong) NSMutableArray * collectionArray;

@end

@implementation CollectionController
- (NSMutableArray *)collectionArray
{
    if (_collectionArray == nil) {
        self.collectionArray = [NSMutableArray arrayWithArray:[DataBaseHeader returnTableData]];
    }
    return _collectionArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableV registerNib:[UINib nibWithNibName:@"ListCell1" bundle:nil] forCellReuseIdentifier:@"ListCell"];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
   
    self.title = @"我的收藏";
    self.tableV.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    

    
}


- (void)leftBarButtonItemAction {
    
    // 倒着删除
    NSMutableArray *indexPathArray = [NSMutableArray arrayWithArray:self.tableV.indexPathsForSelectedRows];
    
    // 这里面的key一定要是数组中的对象的属性
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"row" ascending:NO];
    [indexPathArray sortUsingDescriptors:@[sortDescriptor]];
    
    for (NSIndexPath *indexPath in indexPathArray) {
        NSLog(@"%@", self.collectionArray[indexPath.row]);
        CollectionModel *model2 = self.collectionArray[indexPath.row];
        [DataBaseHeader deleteDataWithKey:model2.sid];
        [self.collectionArray removeObjectAtIndex:indexPath.row];
    }
    [self.tableV deleteRowsAtIndexPaths:self.tableV.indexPathsForSelectedRows withRowAnimation:(UITableViewRowAnimationAutomatic)];
    
    
}

/**
 * 多选
 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

// 是否能编辑
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    if (editing) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftBarButtonItemAction)];
    }else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:nil style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBarButtonItemAction2)];
    }
    [self.tableV setEditing:editing animated:animated];
}

- (void)leftBarButtonItemAction2 {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - tableView的代理协议方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
    
}

//[DataBaseHeader deleteDataWithKey:[cell.allTypesModel.sid intValue]];

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"%ld", self.collectionArray.count);
    return  self.collectionArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 81;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CollectionModel *model = self.collectionArray[indexPath.row];
     ListCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell" forIndexPath:indexPath];
    if ([model.picUrl rangeOfString:@";"].location == NSNotFound) {
       
        [cell setCollectionValueWithModel:model];
        return cell;
    }else {
       
        [cell configureCellectionCellWithModel:model];
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView.isEditing) {
        return;
    }
    
    CollectionModel *model = self.collectionArray[indexPath.row];
    CollectionDetailController *detailVC = [CollectionDetailController  new];
    detailVC.DetailUrl = model.mp4Link;
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
