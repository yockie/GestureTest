//
//  YCCustomGestureRecognizer.m
//  GestureTest
//
//  Created by baidu on 15/12/25.
//  Copyright © 2015年 yockie. All rights reserved.
//

#import "YCCustomGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation YCCustomGestureRecognizer

#define kMinTickleSpacing   20.0
#define kMaxTickleCount     3


- (void)reset {
    _tickleCount = 0;
    _currentTickleStart = CGPointZero;
    _lastDirection = DirectionUnknown;
    
    if (self.state == UIGestureRecognizerStatePossible) {
        self.state = UIGestureRecognizerStateFailed;
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    _currentTickleStart = [touch locationInView:self.view];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //“当前挠痒开始坐标位置”和“移动后坐标位置”进行X轴值比较，得到是想做还是向右移动
    UITouch *touch = [touches anyObject];
    CGPoint tickleEnd = [touch locationInView:self.view];
    CGFloat tickleSpacing = tickleEnd.x - _currentTickleStart.x;
    Direction currentDirection = tickleSpacing>0?DirectionRight:DirectionLeft;
    
    //移动的X轴间距值是否符合要求，足够大
    if (ABS(tickleSpacing) >= kMinTickleSpacing) {
        //判断是否有三次不同方向的动作，如果有则手势结束，将执行回调方法
        if (_lastDirection==DirectionUnknown ||
            (_lastDirection==DirectionLeft && currentDirection==DirectionRight) ||
            (_lastDirection==DirectionRight && currentDirection==DirectionLeft) ) {
            _tickleCount++;
            _currentTickleStart = tickleEnd;
            _lastDirection = currentDirection;
            
            if (_tickleCount >= kMaxTickleCount && self.state==UIGestureRecognizerStatePossible) {
                self.state = UIGestureRecognizerStateEnded;
                NSLog(@"自定义手势成功，将自动执行回调方法");
            }
        }
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self reset];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self reset];
}

@end





















