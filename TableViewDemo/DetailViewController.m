//
//  DetailViewController.m
//  TableViewDemo
//
//  Created by xuan on 2015/9/15.
//  Copyright (c) 2015年 YaSheng. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image4;
@property (weak, nonatomic) IBOutlet UITextView *info2;
@property (weak, nonatomic) IBOutlet UIButton *play3;
@property (weak, nonatomic) IBOutlet UIButton *play4;
@property (weak, nonatomic) IBOutlet UILabel *label2;


@end

@implementation DetailViewController
@synthesize play3;
@synthesize play4;

int countplay = 0;
int countplay2 = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    countplay = 0;
    countplay2 = 0;
    UIImage *photo1 = [UIImage imageNamed:@"Juon.jpg"];
    UIImage *photo2 = [UIImage imageNamed:@"Vacation.jpg"];
    UIImage *photo3 = [UIImage imageNamed:@"InsideOut.jpg"];
    
    if ( [user_input_data isEqualToString:@"咒怨：最終章" ])
    {
        self.image.image = photo1;
        self.image3.hidden = YES;
        self.stat.hidden = YES;
        self.info2.text = @"很可怕";
        
        //Not affecting background music playing
        NSError *sessionError = nil;
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&sessionError];
        [[AVAudioSession sharedInstance] setActive:YES error:&sessionError];
        
        //Set up player
        NSURL *movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"kim" ofType:@"mp4"]];
        AVAsset *avAsset = [AVAsset assetWithURL:movieURL];
        AVPlayerItem *avPlayerItem =[[AVPlayerItem alloc]initWithAsset:avAsset];
        avplayer = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem];
        
        
        //Set up player
        NSURL *movieURL2 = [NSURL URLWithString:@"https://nkgad.blob.core.windows.net//asset-6750385d-1500-80c3-3b32-f1e54c9c595c//Service%20Robot_Function_Carton_H264_1800kbps_AAC_und_ch2_128kbps.mp4?sv=2012-02-12&sr=c&si=93fa7844-b85d-4e43-a6b9-8b40832b0678&sig=3TNuicf80C1oiyx98EAm8PEnJi4MDoFWj43%2FcNTtd7Q%3D&st=2015-08-27T09%3A30%3A07Z&se=2115-08-03T09%3A30%3A07Z"];
        AVAsset *avAsset2 = [AVAsset assetWithURL:movieURL2];
        AVPlayerItem *avPlayerItem2 =[[AVPlayerItem alloc]initWithAsset:avAsset2];
        avplayer2 = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem2];
         
    }
    else if ( [user_input_data isEqualToString:@"全家玩到趴"] ) {
        self.image.image = photo2;
        self.image3.hidden = YES;
        self.stat.hidden = YES;
        self.info2.text = @"很好笑";
    }
    else if ( [user_input_data isEqualToString:@"腦筋急轉彎"] ) {
        self.image.image = photo3;
        self.image3.hidden = YES;
        self.stat.hidden = YES;
        self.info2.text = @"兒童向";
    }
    else if ( [user_input_data isEqualToString:@"camera"] ) {
        self.image.hidden = YES;
        self.info2.hidden = YES;
        self.play3.hidden = YES;
        self.play4.hidden = YES;
        self.stat.numberOfLines = 4;
        NSString *haveCamera = @"haveCamera:";
        NSString *frontCamera = @"frontCamera:";
        NSString *rearCamera = @"rearCamera:";
        NSString *flashLight = @"flashLight:";
        
        if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            haveCamera = [NSString stringWithFormat:@"%@yes", haveCamera];
        }
        else {
            haveCamera = [NSString stringWithFormat:@"%@no", haveCamera];
        }
        
        if ( [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            frontCamera = [NSString stringWithFormat:@"%@yes", frontCamera];
        }
        else {
            frontCamera = [NSString stringWithFormat:@"%@no", frontCamera];
        }
        
        if ( [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            rearCamera = [NSString stringWithFormat:@"%@yes", rearCamera];
        }
        else {
            rearCamera = [NSString stringWithFormat:@"%@no", rearCamera];
        }
        
        if ( [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear]) {
            flashLight = [NSString stringWithFormat:@"%@yes", flashLight];
        }
        else {
            flashLight = [NSString stringWithFormat:@"%@no", flashLight];
        }
        
        self.stat.text = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", haveCamera, frontCamera, rearCamera, flashLight];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)passData:(NSString *)argu
{
    user_input_data = argu;
    
    NSLog(user_input_data);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)PLAY:(UIButton *)sender {
    
    if ( [user_input_data isEqualToString:@"咒怨：最終章" ])
    {
        countplay++;
        if ( ( countplay % 2 ) != 0 ) {
            NSLog(@"%d", countplay);
            avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:avplayer];
            [avPlayerLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
            [avPlayerLayer setFrame:[[UIScreen mainScreen] bounds]];
            [self.view.layer addSublayer:avPlayerLayer];
            [avplayer seekToTime:kCMTimeZero];
            [avplayer play];
        }
        else
        {
            [avPlayerLayer removeFromSuperlayer ];
        }
    }
    else if ( [user_input_data isEqualToString:@"全家玩到趴"] ) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Robot" ofType:@"mp4"];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        //player為MPMoviePlayerController型態的指標
        player = [[MPMoviePlayerController alloc] initWithContentURL:url];
        
        //旋轉90度
        player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        //使用Observer製作完成播放時要執行的動作
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:player];
        
        //設定影片比例的縮放、重複、控制列等參數
        player.scalingMode = MPMovieScalingModeAspectFill;
        player.repeatMode = MPMovieRepeatModeNone;
        player.controlStyle = MPMovieControlStyleDefault;
        
        //將影片加至主畫面上
        player.view.frame = self.view.bounds;
        [self.view addSubview:player.view];
        
        [player play];
    }
    else if ( [user_input_data isEqualToString:@"腦筋急轉彎"] ) {
        NSURL *url = [NSURL URLWithString:@"https://nkgad.blob.core.windows.net//asset-6750385d-1500-80c3-3b32-f1e54c9c595c//Service%20Robot_Function_Carton_H264_1800kbps_AAC_und_ch2_128kbps.mp4?sv=2012-02-12&sr=c&si=93fa7844-b85d-4e43-a6b9-8b40832b0678&sig=3TNuicf80C1oiyx98EAm8PEnJi4MDoFWj43%2FcNTtd7Q%3D&st=2015-08-27T09%3A30%3A07Z&se=2115-08-03T09%3A30%3A07Z"];
        
        //player為MPMoviePlayerController型態的指標
        player = [[MPMoviePlayerController alloc] initWithContentURL:url];
        
        //旋轉90度
        // player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        //使用Observer製作完成播放時要執行的動作
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:player];
        
        //設定影片比例的縮放、重複、控制列等參數
        player.scalingMode = MPMovieScalingModeAspectFit;
        player.repeatMode = MPMovieRepeatModeNone;
        player.controlStyle = MPMovieControlStyleDefault;
        
        //將影片加至主畫面上
        player.view.frame = self.view.bounds;
        [self.view addSubview:player.view];
        
        [player play];
    }
}

- (IBAction)PLAY2:(UIButton *)sender {
    
    if ( [user_input_data isEqualToString:@"咒怨：最終章" ])
    {
        countplay2++;
        if ( ( countplay2 % 2 ) != 0 ) {
            NSLog(@"%d", countplay);
            avPlayerLayer2 = [AVPlayerLayer playerLayerWithPlayer:avplayer2];
            [avPlayerLayer2 setVideoGravity:AVLayerVideoGravityResizeAspect];
            [avPlayerLayer2 setFrame:[[UIScreen mainScreen] bounds]];
            [self.view.layer addSublayer:avPlayerLayer2];
            [avplayer2 seekToTime:kCMTimeZero];
            [avplayer2 play];
        }
        else
        {
            [avPlayerLayer2 removeFromSuperlayer ];
        }
    }
    else if ( [user_input_data isEqualToString:@"全家玩到趴"] ) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Robot" ofType:@"mp4"];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        //player為MPMoviePlayerController型態的指標
        player = [[MPMoviePlayerController alloc] initWithContentURL:url];
        
        //旋轉90度
        // player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        //使用Observer製作完成播放時要執行的動作
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:player];
        
        //設定影片比例的縮放、重複、控制列等參數
        player.scalingMode = MPMovieScalingModeAspectFit;
        player.repeatMode = MPMovieRepeatModeNone;
        player.controlStyle = MPMovieControlStyleDefault;
        
        //將影片加至主畫面上
        player.view.frame = self.view.bounds;
        [self.view addSubview:player.view];
        
        [player play];
    }
    else if ( [user_input_data isEqualToString:@"腦筋急轉彎"] ) {
        NSURL *url = [NSURL URLWithString:@"https://nkgad.blob.core.windows.net//asset-6750385d-1500-80c3-3b32-f1e54c9c595c//Service%20Robot_Function_Carton_H264_1800kbps_AAC_und_ch2_128kbps.mp4?sv=2012-02-12&sr=c&si=93fa7844-b85d-4e43-a6b9-8b40832b0678&sig=3TNuicf80C1oiyx98EAm8PEnJi4MDoFWj43%2FcNTtd7Q%3D&st=2015-08-27T09%3A30%3A07Z&se=2115-08-03T09%3A30%3A07Z"];
        
        //player為MPMoviePlayerController型態的指標
        player = [[MPMoviePlayerController alloc] initWithContentURL:url];
        
        //旋轉90度
        // player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        //使用Observer製作完成播放時要執行的動作
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:player];
        
        //設定影片比例的縮放、重複、控制列等參數
        player.scalingMode = MPMovieScalingModeAspectFit;
        player.repeatMode = MPMovieRepeatModeNone;
        player.controlStyle = MPMovieControlStyleDefault;
        
        //將影片加至主畫面上
        player.view.frame = self.view.bounds;
        [self.view addSubview:player.view];
        
        [player play];
    }

}

- (IBAction)shot:(UIButton *)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    //啟用畫面自動旋轉
    return YES;
}

- (void)moviePlayBackDidFinish:(NSNotification *)notification {
    
    //因為只播放一次所以在這就直接移除此Observer
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:player];
    [player stop];
    
    //將影片重畫面上移除
    [player.view removeFromSuperview];
    // [player release];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [avplayer pause];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [avplayer play];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

@end
