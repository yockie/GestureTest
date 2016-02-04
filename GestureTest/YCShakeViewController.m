//
//  YCShakeViewController.m
//  GestureTest
//
//  Created by baidu on 15/12/23.
//  Copyright © 2015年 yockie. All rights reserved.
//

#import "YCShakeViewController.h"
#import "YCImageView.h"

@interface YCShakeViewController ()

@property (nonatomic, strong) YCImageView *imageView;

@end

@implementation YCShakeViewController

-(void)viewDidLoad {
    CGRect frame = [UIScreen mainScreen].bounds;
    _imageView = [[YCImageView alloc]initWithFrame:frame];
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
}





-(void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_imageView becomeFirstResponder];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [_imageView resignFirstResponder];
   
}


@end
