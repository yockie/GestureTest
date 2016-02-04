//
//  YCImageView.m
//  GestureTest
//
//  Created by baidu on 15/12/23.
//  Copyright © 2015年 yockie. All rights reserved.
//

#import "YCImageView.h"

#define kImageCount 3

@implementation YCImageView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.image = [self getImage];
    }
    
    return self;
}

#pragma mark - 随机取得图片
-(UIImage *)getImage {
    NSUInteger index = arc4random() % kImageCount;
    NSString *imageName = [NSString stringWithFormat:@"%lu.png", (unsigned long)index];
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
    
}

#pragma mark - 运动事件
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"motion begin...");
    
    //这里只处理摇晃事件
    if (motion == UIEventSubtypeMotionShake) {
        self.image = [self getImage];
    }
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"motion end");
}


#pragma mark - 响应者
-(BOOL)canBecomeFirstResponder {
    return YES;
}

@end
