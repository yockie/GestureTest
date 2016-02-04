//
//  YCPhotoViewController.m
//  GestureTest
//
//  Created by baidu on 15/12/23.
//  Copyright © 2015年 yockie. All rights reserved.
//

#import "YCPhotoViewController.h"
#import "YCCustomGestureRecognizer.h"

#define kImageCount 3

@interface YCPhotoViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) NSUInteger currentIndex;

@end

@implementation YCPhotoViewController



-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    
    [self addGesture];
    
}

#pragma mark - 初始化布局
- (void)setupLayout {
    //添加图片展示控件
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    CGFloat topPadding = 50;
    CGRect imageFrame = CGRectMake(0, topPadding, screenSize.width, screenSize.height - topPadding*2);
    _imageView = [[UIImageView alloc]initWithFrame:imageFrame];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.userInteractionEnabled = YES;        //这里必须设置YES，否则无法接收手势操作
    _imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_imageView];
    
    UIImage *image = [UIImage imageNamed:@"0"];
    _imageView.image = image;
    _currentIndex = 0;
    [self showPhotoName];
}

#pragma mark - 添加手势
- (void) addGesture {
    /*添加点按手势*/
    //创建手势对象
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
    //设置手势属性
    tapGR.numberOfTapsRequired = 1; //设置点按次数，默认为1，注意在iOS中很少用双击操作
    tapGR.numberOfTouchesRequired = 1;  //点按的手指数
    //添加手势到对象（注意，这里添加到了控制器视图中，而不是图片上，否则点击空白无法隐藏导航栏）
    [self.view addGestureRecognizer:tapGR];
    
    /*添加长按手势*/
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressImage:)];
    longPressGR.minimumPressDuration = 0.5; //设置长按时间，默认0.5秒，一般这个值不要修改
    //注意由于我们要做长按提示删除操作，因此这个手势不再添加到控制器视图上而是添加到了图片上
    [_imageView addGestureRecognizer:longPressGR];
    
    /*添加捏合手势*/
    UIPinchGestureRecognizer *pinchGR = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchImage:)];
    [self.view addGestureRecognizer:pinchGR];
    
    /*添加旋转手势*/
    UIRotationGestureRecognizer *rotationGR = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationImage:)];
    [self.view addGestureRecognizer:rotationGR];
    
    /*添加拖动手势*/
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panImage:)];
    [_imageView addGestureRecognizer:panGR];
    
    /*添加轻扫手势*/
    UISwipeGestureRecognizer *swipeGRToRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeImage:)];
    //swipeGRToRight.direction = UISwipeGestureRecognizerDirectionRight;  //默认为向右轻扫
    [self.view addGestureRecognizer:swipeGRToRight];
    
    UISwipeGestureRecognizer *swipeGRToLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeImage:)];
    swipeGRToLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGRToLeft];
    
    
    /*自定义手势*/
    //当recognizer.state为UIGestureRecognizerStateEnded时，才执行回调方法custonImage:
    YCCustomGestureRecognizer *customGR = [[YCCustomGestureRecognizer alloc]initWithTarget:self action:@selector(custonImage:)];
    [self.view addGestureRecognizer:customGR];
    
    /*解决手势冲突*/
    //解救在图片上滑动是拖动手势和轻扫手势的冲突
    [panGR requireGestureRecognizerToFail:swipeGRToLeft];
    [panGR requireGestureRecognizerToFail:swipeGRToRight];
    //解救拖动和长按手势之间的冲突
    [longPressGR requireGestureRecognizerToFail:panGR];
    //解决轻扫手势与自定义手势冲突
    [swipeGRToLeft requireGestureRecognizerToFail:customGR];
    [swipeGRToRight requireGestureRecognizerToFail:customGR];
    
    /*演示不同视图的手势同事执行
     *在上面_imageView已经添加了长按手势，这里给视图控制器的视图也加上手势让两者都执行
     */
    self.view.tag = 100;
    _imageView.tag = 200;
    UILongPressGestureRecognizer *viewLongPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressView:)];
    viewLongPressGesture.delegate = self;
    [self.view addGestureRecognizer:viewLongPressGesture];
    
    
}

#pragma mark - 显示图片名称

- (void)showPhotoName {
    NSString *title = [NSString stringWithFormat:@"%lu.png", (unsigned long)_currentIndex];
    [self setTitle:title];
}


#pragma mark - gesture action

- (void) tapImage:(UITapGestureRecognizer *)gesture {
    NSLog(@"tap:%li", (long)gesture.state);
    
    BOOL hidden = !self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:hidden animated:YES];
    
}

- (void) longPressImage:(UILongPressGestureRecognizer *)gesture {
    NSLog(@"longPress:%li", (long)gesture.state);
    
//    //注意其实在手势里面有一个view属性可以获取点按的视图
//    UIImageView *imageView = (UIImageView *)gesture.view;
    
    //由于连续手势此防范会调用多次，所以需要判定其手势状态
    if (gesture.state == UIGestureRecognizerStateBegan) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Syetem Info" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete the photo" otherButtonTitles:nil, nil];
        [actionSheet showInView:self.view];
    }
    
}

- (void) pinchImage:(UIPinchGestureRecognizer *)gesture {
    NSLog(@"pinch:%li", (long)gesture.state);
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        //捏合手势中scale属性记录的缩放比例
        _imageView.transform = CGAffineTransformMakeScale(gesture.scale, gesture.scale);
    }
    else if(gesture.state == UIGestureRecognizerStateEnded) {
        //结束瘦恢复
        [UIView animateWithDuration:0.5 animations:^{
            _imageView.transform = CGAffineTransformIdentity;
        }];
    }
    
}

- (void) rotationImage:(UIRotationGestureRecognizer *)gesture {
    NSLog(@"rotation:%li", (long)gesture.state);
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        //旋转手势中的rotation属性记录了旋转弧度
        _imageView.transform =CGAffineTransformMakeRotation(gesture.rotation);
    }
    else if(gesture.state == UIGestureRecognizerStateEnded) {
        //结束后恢复
        [UIView animateWithDuration:0.8 animations:^{
            _imageView.transform = CGAffineTransformIdentity;
        }];
    }
    
}

- (void) panImage:(UIPanGestureRecognizer *)gesture {
    NSLog(@"pan:%li", (long)gesture.state);
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        //利用拖动手势的translationInView方法取得在相对指定视图（这里是控制器根视图）的移动
        CGPoint translation = [gesture translationInView:self.view];
        _imageView.transform = CGAffineTransformMakeTranslation(translation.x, translation.y);
    }
    else if(gesture.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 animations:^{
            _imageView.transform = CGAffineTransformIdentity;
        }];
    }
    
}

//注意轻扫虽然是连续手势，但是只有在识别结束才会触发，不用判断状态
- (void) swipeImage:(UISwipeGestureRecognizer *)gesture {
    NSLog(@"swipe:%li", (long)gesture.state);
    
    //direction记录的轻扫的方向
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        [self nextImage];
    }
    else if(gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self preImage];
        
    }
}


- (void) custonImage:(YCCustomGestureRecognizer *)gesture {
    NSLog(@"custom:%li", (long)gesture.state);
}

#pragma mark - 图片切换
- (void)nextImage {
    NSUInteger index = (_currentIndex + 1) % kImageCount;
    
    NSString *imageName = [NSString stringWithFormat:@"%ld", (long)index];
    _imageView.image = [UIImage imageNamed:imageName];
    _currentIndex = index;
    
    [self showPhotoName];
}

- (void)preImage {
    NSUInteger index = (_currentIndex - 1 + kImageCount) % kImageCount;
    
    NSString *imageName = [NSString stringWithFormat:@"%ld", (long)index];
    _imageView.image = [UIImage imageNamed:imageName];
    _currentIndex = index;
    
    [self showPhotoName];
}

#pragma mark - 视图控制器视图的长按手势
-(void)longPressView:(UILongPressGestureRecognizer *)gesture {
    NSLog(@"view long press");
}

#pragma mark - 手势代理方法
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //注意，这里控制只有在UIImageView中才能向下传播，其他情况不允许
    if ([otherGestureRecognizer.view isKindOfClass:[UIImageView class]]) {
        return YES;
    }
    return NO;
}

#pragma mark - 触摸事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch begin...");
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch end");
}
@end



















