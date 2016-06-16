//
//  LLXCommentViewController.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/22.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXCommentViewController.h"
#import "LLXTopicsCell.h"
#import "LLXTopics.h"
#import "LLXComments.h"
#import "LLXUser.h"
#import "LLXCommentHeaderView.h"
#import "MJRefresh.h"
#import "AFHTTPSessionManager.h"
#import "MJExtension.h"
#import "LLXCommentCell.h"
@interface LLXCommentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BottonSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSArray *saved_top_cmt;
@property(nonatomic,strong)NSMutableDictionary *params;
/**最热评论*/
@property(nonatomic,strong)NSArray *hotComment;
/**最新评论*/
@property (nonatomic, strong) NSMutableArray *latestComments;
/**页数*/
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation LLXCommentViewController
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBasic];
    [self setHead];
    [self setRefresh];
}
-(NSMutableArray *)latestComments
{
    if (_latestComments==nil) {
        _latestComments=[NSMutableArray array];
    }
    return _latestComments;
}
-(void)setBasic
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ItemWithImage:@"comment_nav_item_share_icon" HighlightedImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // cell的高度设置
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // 背景色
    self.tableView.backgroundColor = LLXGlobelColor;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LLXCommentCell class]) bundle:nil]forCellReuseIdentifier:@"comment"];
    
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, LLXTopicCellMargin, 0);
}
/**设置头部*/
-(void)setHead
{
    //清空热评
    if (self.topics.top_cmt.count) {
        self.saved_top_cmt = self.topics.top_cmt;
        self.topics.top_cmt = nil;
        [self.topics setValue:@0 forKeyPath:@"cellHeight"];
    }
    //将头部Cell用自创建的View代替
    UIView *head=[[UIView alloc]init];
    LLXTopicsCell *cell=[LLXTopicsCell viewFromXib];
    cell.topic=self.topics;
    cell.size=CGSizeMake(LLXScreenW, self.topics.cellHeight);
    
    head.height=self.topics.cellHeight+LLXTopicCellMargin;
    [head addSubview:cell];
    self.tableView.tableHeaderView=head;
    self.view.backgroundColor=LLXGlobelColor;
    
}
-(void)setRefresh
{
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];
        self.tableView.mj_footer.hidden = YES;
    
}
//加载新数据
-(void)loadNewComment
{
    [self.tableView.mj_footer endRefreshing];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"dataList";
    params[@"c"]=@"comment";
    params[@"data_id"]=self.topics.ID;
    params[@"hot"]=@"1";
    self.params=params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php"parameters:params progress:^(NSProgress *  downloadProgress) {
    } success:^(NSURLSessionDataTask *  task, NSDictionary* responseObject) {
        // 说明没有评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_header endRefreshing];
            return;
        }
        if (self.params!=params) return ;
        self.hotComment=[LLXComments mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestComments=[LLXComments mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
        self.page=1;
        
         NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        } else {
            // 结束刷新状态
            self.tableView.mj_footer.hidden=NO;
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        if (self.params != params) return;
        [self.tableView.mj_header endRefreshing];
    }];
}
//加载更多数据
-(void)loadMoreComment
{
    NSInteger page = self.page + 1;
    [self.tableView.mj_header endRefreshing];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"dataList";
    params[@"c"]=@"comment";
    params[@"data_id"]=self.topics.ID;
    params[@"page"] = @(page);
    LLXComments *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    self.params=params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php"parameters:params progress:^(NSProgress *  downloadProgress) {
        
    } success:^(NSURLSessionDataTask *  task, NSDictionary* responseObject) {
        if (self.params!=params) return ;
        NSArray *moreComments=[LLXComments mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:moreComments];
        [self.tableView reloadData];
        self.page=page;
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        } else {
            // 结束刷新状态
            self.tableView.mj_footer.hidden=NO;
            [self.tableView.mj_footer endRefreshing];
        }

    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        if (self.params != params) return;
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

-(void)keyboardWillChangeFrame:(NSNotification *)sender{
    // 键盘显示\隐藏时的frame
    CGRect frame=[sender.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    self.BottonSpace.constant=LLXScreenH-frame.origin.y
    ;
    CGFloat duration=[sender.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}
//根据有无热评 返回数据类型
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComment.count ? self.hotComment : self.latestComments;
    }
    return self.latestComments;
}
/**有热门则返回热门数据的列数  否则返回最新数据的列数*/
- (LLXComments *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}
/**返回列数*/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotComment.count) return 2;
    if (self.latestComments.count) return 1;
    return 0;
}
/**返回行数*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.hotComment.count ? self.hotComment.count:self.latestComments.count;
    }
    if (section==1) return self.latestComments.count;
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LLXComments *comment=[self commentInIndexPath:indexPath];
    return comment.cellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLXCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"comment"];
    
    cell.comment=[self commentInIndexPath:indexPath];
    return cell;
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSInteger hotCount = self.hotComment.count;
//    if (section == 0) {
//        return hotCount ? @"最热评论" : @"最新评论";
//    }
//    return @"最新评论";
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    LLXCommentHeaderView *header= [LLXCommentHeaderView headerViewWithTableView:tableView];
    
    section == 0 ? ( header.label.text= self.hotComment.count ? @"最热评论" : @"最新评论"):(header.label.text= @"最新评论");
    return header;
}
/**移除通知*/
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    
    if (self.saved_top_cmt.count) {
        self.topics.top_cmt = self.saved_top_cmt;
        [self.topics setValue:@0 forKeyPath:@"cellHeight"];
    }
        [self.manager invalidateSessionCancelingTasks:YES];
}
/**拖动scrollview退出键盘*/
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIMenuController *menu = [UIMenuController sharedMenuController];

    if ([menu isMenuVisible]) {
        [menu setMenuVisible:NO animated:YES];
    }
    else{
        LLXCommentCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        UIMenuItem *zan=[[UIMenuItem alloc]initWithTitle:@"赞" action:@selector(zan:)];
        UIMenuItem *replay=[[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report=[[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(report:)];
        menu.menuItems=@[zan,replay,report];
        CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
        [self becomeFirstResponder];
    }
    
}
-(void)zan:(UIMenuController *)menu
{
    LLXLogFunc;
}
-(void)replay:(UIMenuController *)menu
{
    LLXLogFunc;
}
-(void)report:(UIMenuController *)menu
{
    LLXLogFunc;    
}
@end
