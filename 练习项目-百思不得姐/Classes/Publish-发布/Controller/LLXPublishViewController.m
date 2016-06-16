//
//  LLXPublishViewController.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/20.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXPublishViewController.h"
#import "LLXLoginBtn.h"
#import "LLXPostWordViewController.h"
#import "LLXNavigationController.h"
@interface LLXPublishViewController ()

@end

@implementation LLXPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.y = LLXScreenH * 0.2;
    sloganView.centerX = LLXScreenW * 0.5;
    [self.view addSubview:sloganView];
    
    // 数据
    NSArray *images = @[@"publish-video" , @"publish-picture",
                        @"publish-text"  , @"publish-audio",
                        @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子",
                        @"发声音", @"审帖"  , @"离线下载"];
    
    // 中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (LLXScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (LLXScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i<images.count; i++) {
        LLXLoginBtn *button = [[LLXLoginBtn alloc] init];
        button.tag=i;
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];        // 设置frame
        button.width = buttonW;
        button.height = buttonH;
        int row = i / maxCols;
        int col = i % maxCols;
        button.x = buttonStartX + col * (xMargin + buttonW);
        button.y = buttonStartY + row * buttonH;
        [self.view addSubview:button];
    }
}
-(void)buttonClick:(UIButton *)sender
{
    if (sender.tag==2) {
        
        LLXPostWordViewController *postWordVC=[[LLXPostWordViewController alloc]init];
        LLXNavigationController *navVc=[[LLXNavigationController alloc]initWithRootViewController:postWordVC];
        [self dismissViewControllerAnimated:YES completion:^{
            UIViewController *rootVC=[UIApplication sharedApplication].keyWindow.rootViewController;
            [rootVC presentViewController:navVc animated:YES completion:^{
                [navVc.view setBackgroundColor:[UIColor whiteColor]];
            }];
        }];
    }
}
- (IBAction)Cancel {
    self.view.userInteractionEnabled=NO;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

@end
