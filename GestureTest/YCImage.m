//
//  YCImage.m
//  GestureTest
//
//  Created by baidu on 15/12/22.
//  Copyright © 2015年 yockie. All rights reserved.
//

#import "YCImage.h"

@implementation YCImage

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIColor *bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cat"]];
        self.backgroundColor = bgColor;
    }
    
    return self;
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"UIView start touch...");
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"UIView move...");
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"UIView touch end");
}


@end
