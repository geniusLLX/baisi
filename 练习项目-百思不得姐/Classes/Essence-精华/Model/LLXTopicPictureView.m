//
//  LLXTopicPictureView.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/20.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXTopicPictureView.h"
#import "LLXTopics.h"
#import "LLXShowPictureController.h"
#import "UIImageView+WebCache.h"
#import "LLXProgressView.h"
@interface LLXTopicPictureView()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet LLXProgressView *progressView;

@end
@implementation LLXTopicPictureView


-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled=YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)]];
}
-(void)showPicture{
    
    LLXShowPictureController *PVC=[[LLXShowPictureController alloc]init];
    PVC.topic=self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:PVC animated:YES completion:nil];
}
-(void)setTopic:(LLXTopics *)topic
{
    _topic=topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.topic.pictureProgress=(1.0*receivedSize/expectedSize) ;
        self.progressView.hidden = NO;
        [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden=YES;
    }];
    
    NSString *extension=topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    if (topic.isBigPicture) {
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    } else { // 非大图
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;

    }
}
@end
