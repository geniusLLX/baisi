//
//  LLXTopicVideoView.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/21.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXTopicVideoView.h"
#import "LLXTopics.h"
#import "LLXShowPictureController.h"
#import "LLXProgressView.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
@interface LLXTopicVideoView()
/* 创建播放控制器 */
@property (nonatomic, strong) MPMoviePlayerViewController *playerVc;
@property (weak, nonatomic) IBOutlet UILabel *VoiceTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *PlayCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet LLXProgressView *progressView;
@end
@implementation LLXTopicVideoView

-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.ImageView.userInteractionEnabled=YES;
    [self.ImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)]];
}
-(void)showPicture{
    
    LLXShowPictureController *PVC=[[LLXShowPictureController alloc]init];
    PVC.topic=self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:PVC animated:YES completion:nil];
}
-(void)setTopic:(LLXTopics *)topic
{
    _topic=topic;
    [self.ImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.topic.pictureProgress=(1.0*receivedSize/expectedSize) ;
        self.progressView.hidden = NO;
        [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden=YES;
    }];
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    
    self.VoiceTimeLabel.text=[NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    self.PlayCountLabel.text=[NSString stringWithFormat:@"%zd播放",topic.playcount];

}
- (MPMoviePlayerViewController *)playerVc
{
    _playerVc=nil;
    if (_playerVc == nil) {
        NSURL *url = [NSURL URLWithString:self.topic.videouri];
        
        _playerVc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    }
    return _playerVc;
}
- (IBAction)Play {
     [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.playerVc animated:YES completion:nil];
}

@end
