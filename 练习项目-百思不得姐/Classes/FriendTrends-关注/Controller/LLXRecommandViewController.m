//
//  LLXRecommandViewController.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/12.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXRecommandViewController.h"
#import "LLXRecommandCategoryCell.h"
#import "LLXRecommandCategory.h"
#import "LLXRecommandUserViewCell.h"
#import "LLXRecommandUserCategory.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "MJRefresh.h"
@interface LLXRecommandViewController ()<UITableViewDataSource,UITableViewDelegate>
//右边表格
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
//右边表格
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
//左边类型数据
@property(nonatomic,strong)NSArray *categories;
@property(nonatomic,strong)NSMutableDictionary *params;

@end

@implementation LLXRecommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self RefreshTableView];
    [self loadCategoryData];
}
//设置tableview状态
-(void)setupTableView{
    self.navigationItem.title=@"推荐关注";
    //注册Cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LLXRecommandCategoryCell class]) bundle:nil] forCellReuseIdentifier:@"category"];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LLXRecommandUserViewCell class]) bundle:nil] forCellReuseIdentifier:@"user"];
    //
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 64, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    self.view.backgroundColor=LLXGlobelColor;
    
}
//加载左边数据
-(void)loadCategoryData{
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"category";
    params[@"c"]=@"subscribe";
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php"parameters:params progress:^(NSProgress *  downloadProgress) {
        
    } success:^(NSURLSessionDataTask *  task, id   responseObject) {
        //将每一个
        
        self.categories=[LLXRecommandCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.userTableView.mj_header beginRefreshing];
        [SVProgressHUD dismissWithDelay:0.5];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
        [SVProgressHUD dismissWithDelay:0.5];
    }];
    
}
-(void)RefreshTableView{
    
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHeadData)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadFootData)];
}


-(void)loadHeadData{
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    LLXRecommandCategory*c=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    c.currentPage=1;
    params[@"a"]=@"list";
    params[@"c"]=@"subscribe";
    params[@"category_id"]=@(c.id);
    params[@"page"] = @(c.currentPage);
    self.params=params;
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress *  downloadProgress) {
        
    } success:^(NSURLSessionDataTask *  task, id   responseObject) {

        NSArray *users=[LLXRecommandUserCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [c.users removeAllObjects];
        [c.users addObjectsFromArray:users];
        c.total = [responseObject[@"total"] integerValue];
        if (self.params!=params) return ;
        [self.userTableView reloadData];
        [self.userTableView.mj_header endRefreshing];
        [self CheckRefreshTableView];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        
    }];
}
-(void)loadFootData{
    LLXRecommandCategory*c=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"list";
    params[@"c"]=@"subscribe";
    params[@"category_id"]=@(c.id);
    params[@"page"] = @(++c.currentPage);
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress *  downloadProgress) {
        
    } success:^(NSURLSessionDataTask *  task, id   responseObject) {
        NSArray *users=[LLXRecommandUserCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [c.users addObjectsFromArray:users];
        
        [self.userTableView reloadData];
        [self.userTableView.mj_footer endRefreshing];
        [self CheckRefreshTableView];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        
    }];

}-(void)CheckRefreshTableView{
    LLXRecommandCategory*c=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        self.userTableView.mj_footer.hidden = (c.users.count == 0);
    if (c.users.count==c.total) {
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.userTableView.mj_footer endRefreshing];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.categoryTableView)
    {
            return self.categories.count;
    }
    else
    {

    LLXRecommandCategory*c=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        self.userTableView.mj_footer.hidden=(c.users.count==0);
        return c.users.count;
    }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.categoryTableView) {
        //加载左边Cell
        LLXRecommandCategoryCell *cell=[tableView dequeueReusableCellWithIdentifier:@"category"];
        cell.category=self.categories[indexPath.row];
            return cell;
    }else{
        //加载右边Cell
        LLXRecommandUserViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"user"];
        LLXRecommandCategory*c=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        [self CheckRefreshTableView];
        cell.user=c.users[indexPath.row];
            return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LLXRecommandCategory*c=self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    if (c.users.count) {
        [self.userTableView reloadData];
    }else{
        //立即显示当前category的数据，以防止用户看到停留在上一层的数据
        [self.userTableView reloadData];
        //点击关注类别时知道加载其中数据
        [self.userTableView.mj_header beginRefreshing];
    }
}
@end
