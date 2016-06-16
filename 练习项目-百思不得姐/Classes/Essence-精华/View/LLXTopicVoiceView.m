//
//  LLXTopicVoiceView.m
//  练习项目-百思不得姐
//
//  Created by 刘大大 on 16/5/21.
//  Copyright © 2016年 GeniusLiu. All rights reserved.
//

#import "LLXTopicVoiceView.h"
#import "LLXTopics.h"
#import "LLXShowPictureController.h"
#import "LLXProgressView.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
@interface LLXTopicVoiceView()
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playOrPause;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet LLXProgressView *progressView;
@property (nonatomic, strong) AVPlayer *player;
@property (strong,nonatomic)NSString *lastVoiceUrl;
- (IBAction)VoicePlay;
@end
@implementation LLXTopicVoiceView
static NSMutableDictionary *_players;
+ (void)initialize
{
    _players = [NSMutableDictionary dictionary];
}
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
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    
    self.voicetimeLabel.text=[NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    self.playcountLabel.text=[NSString stringWithFormat:@"%zd播放",topic.playcount];
    
}

- (IBAction)VoicePlay {
    // 1.使播放器为空
    self.player=nil;
    NSString *musicName=self.topic.voiceuri;
    // 2.从字典中取player,如果取出出来是空,则对应创建对应的播放器,防止循环创建
    self.player = _players[musicName];
    if (self.player == nil) {
        // 2.1.获取对应音乐资源
       self.player= [[AVPlayer alloc] initWithURL:[NSURL URLWithString:musicName]];
        
        if (self.player == nil) return;
        [_players setObject:self.player forKey:musicName];
        
    }
    [self.player play];
    
    self.playOrPause.selected = !self.playOrPause.selected;
    if (self.lastVoiceUrl==self.topic.voiceuri) {
        if (self.playOrPause.selected==NO) {
            [self.player pause];
        }
    }
    self.lastVoiceUrl=musicName;
}
@end
