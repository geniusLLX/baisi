//
//  LLXWrodViewController.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/18.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXTopicViewController.h"
#import "LLXCommentViewController.h"
#import "LLXTopics.h"
#import "LLXTopicsCell.h"
#import "LLXNewViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "MJRefresh.h"
@interface LLXTopicViewController ()
@property(nonatomic,strong)NSMutableArray *topics;
@property(nonatomic,strong)NSMutableDictionary *params;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger SeletedtabBarIndex;
@property(nonatomic,copy)NSString *maxtime;
@property(nonatomic,copy)NSString *EssenceOrNew;
@end

@implementation LLXTopicViewController
-(NSMutableArray *)topics{
    if (_topics==nil) {
        _topics=[NSMutableArray array];
    }
    return _topics;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupRefresh];

}
-(void)setupRefresh{
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}
- (NSString *)EssenceOrNew
{
    return [self.parentViewController isKindOfClass:[LLXNewViewController class]] ? @"newlist" : @"list";
}
-(void)setupTableView{
    
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = 64 + 35;
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LLXTopicsCell class]) bundle:nil] forCellReuseIdentifier:@"topic"];
    //注册Cell
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabBarClick) name:@"LLXTabBarDidSelectNotification" object:nil];
}
-(void)tabBarClick{
    
    if (self.tabBarController.selectedViewController==self.navigationController&&self.SeletedtabBarIndex==self.tabBarController.selectedIndex) {
        [self.tableView.mj_header beginRefreshing];
    }
    self.SeletedtabBarIndex=self.tabBarController.selectedIndex;
}
-(void)loadNewTopics{
    [self.tableView.mj_footer endRefreshing];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=self.EssenceOrNew;
    params[@"c"]=@"data";
    params[@"type"]=@(self.type);
    self.params=params;
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php"parameters:params progress:^(NSProgress *  downloadProgress) {
        
    } success:^(NSURLSessionDataTask *  task, NSDictionary* responseObject) {
        if (self.params!=params) return ;
        self.topics=[LLXTopics mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.tableView reloadData];
        self.page=0;
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        if (self.params != params) return;
        [self.tableView.mj_header endRefreshing];
    }];
    
}

-(void)loadMoreTopics{
    [self.tableView.mj_header endRefreshing];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSInteger page;
    page=self.page+1;
    params[@"a"]=self.EssenceOrNew;
    params[@"c"]=@"data";
    params[@"type"]=@(self.type);
    params[@"page"]=@(page);
    params[@"maxtime"] =self.maxtime;
    self.params=params;
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php"parameters:params progress:^(NSProgress *  downloadProgress) {
        
    } success:^(NSURLSessionDataTask *  task, NSDictionary* responseObject) {
        if (self.params!=params) return ;
        NSArray *NewTopics=[LLXTopics mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.topics addObjectsFromArray:NewTopics];
        [self.tableView reloadData];
        self.page=page;
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        if (self.params != params) return;
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LLXTopicsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topic"];
    
    cell.topic=self.topics[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLXTopics *topics=self.topics[indexPath.row];
    return topics.cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LLXCommentViewController *CmtVc=[[LLXCommentViewController alloc]init];
    [CmtVc setHidesBottomBarWhenPushed:YES];
    CmtVc.topics=self.topics[indexPath.row];
    [self.navigationController pushViewController:CmtVc animated:YES];
}
@end
