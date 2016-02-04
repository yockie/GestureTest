//
//  YCCustomGestureRecognizer.h
//  GestureTest
//
//  Created by baidu on 15/12/25.
//  Copyright © 2015年 yockie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, Direction) {
    DirectionUnknown,
    DirectionLeft,
    DirectionRight
};

//挠痒功能，左右扫动共3次或以上，设置两个图片视图为居中，同时以水平居中的特定偏移量定位
@interface YCCustomGestureRecognizer : UIGestureRecognizer

@property (nonatomic, assign) NSUInteger tickleCount;   //挠痒次数
@property (nonatomic, assign) CGPoint currentTickleStart;   //当前挠痒开始坐标位置
@property (nonatomic, assign) Direction lastDirection;      //最后一次挠痒方向

@end



























