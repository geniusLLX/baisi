//
//  LLXMeFootView.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/26.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXMeFootView.h"
#import "LLXSquare.h"
#import "LLXSquareButton.h"
#import "LLXWebViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
@implementation LLXMeFootView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        // 发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *sqaures = [LLXSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            [self createSquares:sqaures];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
}
- (void)createSquares:(NSArray *)sqaures
{
    NSInteger maxCols=4;
    CGFloat buttonW=LLXScreenW/maxCols;
    CGFloat buttonH=buttonW;
    
    for (NSInteger i=0; i<sqaures.count; i++) {
        // 计算frame
        LLXSquareButton *button=[LLXSquareButton buttonWithType:UIButtonTypeCustom];
        button.square=sqaures[i];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        NSInteger col = i % maxCols;
        NSInteger row = i / maxCols;
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
        [self addSubview:button];
    }
    // 总行数
    //    NSUInteger rows = sqaures.count / maxCols;
    //    if (sqaures.count % maxCols) { // 不能整除, + 1
    //        rows++;
    //    }
    
    // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    
    NSUInteger rows = (sqaures.count + maxCols - 1) / maxCols;
    
    // 计算footer的高度
    self.height = rows * buttonH;
    
    // 重绘
    [self setNeedsDisplay];
}
-(void)clickButton:(LLXSquareButton *)button
{
    UITabBarController *rootVC=(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav=(UINavigationController *)rootVC.selectedViewController;
    LLXWebViewController *webVC=[[LLXWebViewController alloc]init];
    webVC.url=button.square.url;
    webVC.title=button.square.name;
    [webVC setHidesBottomBarWhenPushed:YES];
    [nav pushViewController:webVC animated:YES];
}
@end
