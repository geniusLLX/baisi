//
//  LLXRecommandTagsViewController.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/15.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXRecommandTagsViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "LLXRecommendTag.h"
#import "LLXRecommandTagsCell.h"
@interface LLXRecommandTagsViewController ()
@property(nonatomic,strong)NSArray *tags;
@end

@implementation LLXRecommandTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"推荐关注";
    //注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LLXRecommandTagsCell class]) bundle:nil] forCellReuseIdentifier:@"tag"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 48, 0);
    self.tableView.rowHeight = 70;
    self.view.backgroundColor=LLXGlobelColor;
    [self loadCategoryData];
    
}
-(void)loadCategoryData{
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"tag_recommend";
    params[@"c"]=@"topic";
    params[@"action"]=@"sub";
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php"parameters:params progress:^(NSProgress *  downloadProgress) {
        
    } success:^(NSURLSessionDataTask *  task, id   responseObject) {
        
        self.tags=[LLXRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismissWithDelay:0.5];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
        [SVProgressHUD dismissWithDelay:0.5];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLXRecommandTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tag"];
    cell.recommandTag=self.tags[indexPath.row];
    
    
    return cell;
}

@end
