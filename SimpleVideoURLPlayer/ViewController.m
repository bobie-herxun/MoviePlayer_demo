//
//  ViewController.m
//  SimpleVideoURLPlayer
//
//  Created by Bobie on 3/8/13.
//  Copyright (c) 2013 Bobie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initPlayerFrame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPlayerFrame     //:(NSString*)strURL (NSString*)strSourceFormat
{
    //NSURL* url = [NSURL URLWithString:strURL];
    self.player = [[MPMoviePlayerController alloc] init];
    [self.player.view setFrame:CGRectMake(10, 10, 300, 200)];
    [self.view addSubview:self.player.view];
    
    [self.player setFullscreen:NO];
    [self.player setScalingMode:MPMovieScalingModeFill];
    [self.player setControlStyle:MPMovieControlModeDefault];
}

- (void)initPlayerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onPlaybackStateChange)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onLoadStateChanged)
                                                 name:MPMoviePlayerLoadStateDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onPlaybackDidFinished)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
}

- (IBAction)startPlayURL:(id)sender
{
    NSString* string = @"http://video.nexttv.com.tw/e/w/20130312/10638792.mp4";
    //@"http://iphonestream.nexttv.com.tw/iphone/mbr.m3u8"; //@"http://www.thumbafon.com/code_examples/video/segment_example/prog_index.m3u8";
    [self.player setContentURL:[NSURL URLWithString:string]];
    
    [self initPlayerNotifications];
    
    //self.player.movieSourceType = MPMovieSourceTypeStreaming;
    self.player.movieSourceType = MPMovieSourceTypeFile;
    
    [self.player prepareToPlay];
    [self.player play];
}

- (IBAction)pausePlayback:(id)sender {
    if (self.player)
    {
        if ([self.player playbackState] == MPMoviePlaybackStatePlaying)
        {
            [self.player pause];
        }
    }
}

- (IBAction)stopPlayback:(id)sender {
    if (self.player)
    {
        if ( [self.player playbackState] == MPMoviePlaybackStatePlaying ||
             [self.player playbackState] == MPMoviePlaybackStatePaused )
        {
            [self.player stop];
        }
    }
}

#pragma mark - State-aware notifications
- (void)onPlaybackStateChange
{
    NSLog([NSString stringWithFormat:@"playbackstate: %d", [self.player playbackState]]);
    if ([self.player playbackState] == MPMoviePlaybackStateStopped)
    {
        if (self.player.fullscreen)
            [self.player setFullscreen:NO];
    }
}

- (void)onLoadStateChanged
{
    NSLog([NSString stringWithFormat:@"loadstate: %d", [self.player loadState]]);
    if ([self.player loadState] == MPMovieLoadStatePlayable)
    {
        [self.player setFullscreen:YES];
    }
}

- (void)onPlaybackDidFinished
{
    if (self.player.fullscreen)
        [self.player setFullscreen:NO animated:YES];
}

@end
