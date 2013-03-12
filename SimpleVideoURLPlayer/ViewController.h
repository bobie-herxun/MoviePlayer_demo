//
//  ViewController.h
//  SimpleVideoURLPlayer
//
//  Created by Bobie on 3/8/13.
//  Copyright (c) 2013 Bobie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController : UIViewController

@property (nonatomic, retain) MPMoviePlayerController* player;

- (IBAction)startPlayURL:(id)sender;
- (IBAction)pausePlayback:(id)sender;
- (IBAction)stopPlayback:(id)sender;

@end
