//
//  YCTouchEventViewController.m
//  GestureTest
//
//  Created by baidu on 15/12/22.
//  Copyright © 2015年 yockie. All rights reserved.
//

#import "YCTouchEventViewController.h"
#import "YCImage.h"

@interface YCTouchEventViewController ()
@property (nonatomic, strong) YCImage *imageView;

@end



@implementation YCTouchEventViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[YCImage alloc]initWithFrame:CGRectMake(50, 50, 150, 169)];
    [self.view addSubview:_imageView];
}


#pragma mark - 视图控制器的触摸事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"UIViewController start touche...");
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //获得一个触摸对象（对于多点触摸可能有多个对象）
    UITouch *touch = [touches anyObject];
    
    //取得当前位置
    CGPoint current = [touch locationInView:self.view];
    //取得前一个位置
    CGPoint previous = [touch previousLocationInView:self.view];
    
    //移动前的中点位置
    CGPoint center = _imageView.center;
    //移动偏移量
    CGPoint offset = CGPointMake(current.x-previous.x, current.y-previous.y);
    
    //重新设置新位置
    _imageView.center = CGPointMake(center.x+offset.x, center.y+offset.y);
    
    NSLog(@"UIViewController moving ...");
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"UIViewController touch end.");
}




@end
