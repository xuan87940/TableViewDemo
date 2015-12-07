//
//  DetailViewController.h
//  TableViewDemo
//
//  Created by xuan on 2015/9/15.
//  Copyright (c) 2015年 YaSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@protocol DetailViewDelegate

//協定中的方法
- (void)passValue:(NSString *)value;

@end

@interface DetailViewController : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    NSString *user_input_data;
    MPMoviePlayerController *player;
    AVPlayer *avplayer;
    AVPlayerItem *playerItem;
    AVPlayerLayer *avPlayerLayer;
    AVPlayer *avplayer2;
    AVPlayerLayer *avPlayerLayer2;
}

@property (weak, nonatomic) IBOutlet UILabel *stat;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIImageView *image3;

- (IBAction)PLAY:(UIButton *)sender;
- (IBAction)PLAY2:(UIButton *)sender;
- (IBAction)shot:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextView *info;

-(void) passData:(NSString *)argu;

@property (weak) id<DetailViewDelegate> delegate;



@end
