//
//  LLXWebViewController.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/27.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXWebViewController.h"
#import "NJKWebViewProgress.h"
@interface LLXWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIWebView *WebView;
- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goforward;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goback;
- (IBAction)goforward:(id)sender;
- (IBAction)refresh:(id)sender;
/** 进度代理对象 */
@property (nonatomic, strong) NJKWebViewProgress *progress;
@end

@implementation LLXWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progress=[[NJKWebViewProgress alloc]init];
    [self.WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.goforward.enabled=NO;
    self.goback.enabled=NO;
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress) {
        weakSelf.progressView.progress=progress;
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    self.progress.webViewProxyDelegate = self;
    
    self.WebView.delegate=self.progress;
}

- (IBAction)goback:(id)sender {
    [self.WebView goBack];
}
- (IBAction)goforward:(id)sender {
    [self.WebView goForward];
}
- (IBAction)refresh:(id)sender {
    [self.WebView reload];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.goforward.enabled=webView.canGoForward;
    self.goback.enabled = webView.canGoBack;
}
@end
