//
//  SearchBarController.m
//  MyCar2.0
//
//  Created by lanouhn on 16/3/13.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "SearchBarController.h"
#import "Header.h"
@interface SearchBarController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *search;
@property (strong, nonatomic) IBOutlet UITableView *tableV;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation SearchBarController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
    self.search.delegate = self;
    
}

- (void)reloadDataWithUrl:(NSString *)url {
[AFManegerHelp Get:url parameters:nil success:^(id responseObjeck) {
    NSMutableArray *arr = responseObjeck [@"suglist"];
    if (self.dataArray != nil) {
        [self.dataArray removeAllObjects];
    }
    for (NSDictionary *dic in arr) {
        DetailModel *model = [DetailModel new];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArray addObject:model];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableV reloadData];

    });
} failure:^(NSError *error) {
    
}];

}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text.length != 0 && searchBar.text != nil) {
        NSString *string = searchBar.text;
        NSString *srt = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
         [self reloadDataWithUrl:[NSString stringWithFormat:kSearchUrl, srt]];
       
           }
    [self.tableV reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchBar.text.length != 0 && searchBar.text != nil) {
        NSString *string = searchBar.text;
        NSString *srt = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        [self reloadDataWithUrl:[NSString stringWithFormat:kSearchUrl, srt]];
    }
    [self.tableV reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    DetailModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"segueSearch" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailController *detailVC = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableV indexPathForSelectedRow];
    DetailModel *model = self.dataArray[indexPath.row];
//    NSLog(@"%@", model.name);
//    NSLog(@"%@", model.AId);
    detailVC.serialId = [model.AId intValue] ;
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
