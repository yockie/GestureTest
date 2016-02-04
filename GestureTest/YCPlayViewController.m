//
//  YCPlayViewController.m
//  GestureTest
//
//  Created by baidu on 15/12/24.
//  Copyright © 2015年 yockie. All rights reserved.
//

#import "YCPlayViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface YCPlayViewController ()

@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic) BOOL isPlaying;
@property (nonatomic, strong) AVPlayer *player;

@end

@implementation YCPlayViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
}




-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
    //http://ydown.smzy.com/yinpin/2015-12/smzy_2015122105.mp3
    _player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:@"http://stream.jewishmusicstream.com:8000"]];
    
    
    
    //[_player play];
    
}


-(void)viewWillDisappear:(BOOL)animated {
    
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
    
    [super viewWillDisappear:animated];
}

-(void)remoteControlReceivedWithEvent:(UIEvent *)event {
    NSLog(@"%li, %li", (long)event.type, (long)event.subtype);
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                [_player play];
                _isPlaying = true;
                break;
            case UIEventSubtypeRemoteControlTogglePlayPause:
                if (_isPlaying) {
                    [_player pause];
                }
                else {
                    [_player play];
                }
                _isPlaying = !_isPlaying;
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"Next track");
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"Previous track");
                break;
            case UIEventSubtypeRemoteControlBeginSeekingForward:
                NSLog(@"Begin seek forward...");
                break;
            case UIEventSubtypeRemoteControlEndSeekingForward:
                NSLog(@"End seek forward...");
                break;
            case UIEventSubtypeRemoteControlBeginSeekingBackward:
                NSLog(@"Begin seek backward");
                break;
            case UIEventSubtypeRemoteControlEndSeekingBackward:
                NSLog(@"End seek backward");
            default:
                break;
        }
        
        [self changeUIState];
    }
}

- (void)setupLayout {
    //专辑封面
    UIImage *image = [UIImage imageNamed:@"0"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    //播放控制面板
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 320, 320, 88)];
    view.backgroundColor = [UIColor lightGrayColor];
    view.alpha = 0.8;
    [self.view addSubview:view];
    
    //添加播放按钮
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _playButton.bounds = CGRectMake(0, 0, 50, 50);
    _playButton.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2);
    [self changeUIState];
    [_playButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_playButton];
}


- (void) changeUIState {
    if (_isPlaying) {
        [_playButton setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    }
    else {
        [_playButton setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    }
}

- (void)btnClick : (UIButton *)btn {
    if (_isPlaying) {
        [_player pause];
    }
    else {
        [_player play];
    }
    
    _isPlaying = !_isPlaying;
    [self changeUIState];
}

@end






























