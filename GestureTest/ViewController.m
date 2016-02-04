//
//  ViewController.m
//  GestureTest
//
//  Created by baidu on 15/12/21.
//  Copyright © 2015年 yockie. All rights reserved.
//

#import "ViewController.h"
#import "YCTouchEventViewController.h"
#import "YCPhotoViewController.h"
#import "YCShakeViewController.h"
#import "YCPlayViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createButtonIndex:1 text:@"touch event" action:@selector(btn1Clicked:)];
    [self createButtonIndex:2 text:@"PhotoViewController" action:@selector(btn2Clicked:)];
    [self createButtonIndex:3 text:@"摇一摇" action:@selector(btn3Clicked:)];
    [self createButtonIndex:4 text:@"play music" action:@selector(btn4Clicked:)];
    
}


-(void)createButtonIndex:(NSInteger)index text:(NSString *)text action:(SEL)action {
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 20+40*(index-1), 200, 30)];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)btn1Clicked:(id)sender {
    YCTouchEventViewController * viewController = [[YCTouchEventViewController alloc]init];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)btn2Clicked:(id)sender {
    YCPhotoViewController * viewController = [[YCPhotoViewController alloc]init];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)btn3Clicked:(id)sender {
    YCShakeViewController * viewController = [[YCShakeViewController alloc]init];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)btn4Clicked:(id)sender {
    YCPlayViewController * viewController = [[YCPlayViewController alloc]init];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end




































