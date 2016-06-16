//
//  LLXShowPictureController.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/20.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXShowPictureController.h"
#import "UIImageView+WebCache.h"
#import "LLXTopics.h"
#import "LLXProgressView.h"
#import "SVProgressHUD.h"
@interface LLXShowPictureController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView *imageView;
- (IBAction)Save:(id)sender;
- (IBAction)Back:(id)sender;
@property (weak, nonatomic) IBOutlet LLXProgressView *progressView;

@end

@implementation LLXShowPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView=[[UIImageView alloc]init];
    self.imageView=imageView;
    imageView.userInteractionEnabled=YES;
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
    CGFloat screenH=[UIScreen mainScreen].bounds.size.height;
    [self.scrollView addSubview:imageView];
    // 图片尺寸
    CGFloat pictureW = screenW;
    CGFloat pictureH = screenW * self.topic.height / self.topic.width;
    if (pictureH>screenH) {
        imageView.frame=CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize=CGSizeMake(0, pictureH);
    }else{
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = screenH * 0.5;
    }
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        [self.progressView setProgress:(1.0*receivedSize/expectedSize) animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}
    // 将图片写入相册
- (IBAction)Save:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
