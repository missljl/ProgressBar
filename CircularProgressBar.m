//
//  CircularProgressBar.m
//  CircularProgressBar
//
//  Created by du on 10/8/15.
//  Copyright © 2015 du. All rights reserved.
//

#import "CircularProgressBar.h"
#import "TimeHelper.h"

#define RADIUS 25*[UIScreen mainScreen].bounds.size.width/320
#define POINT_RADIUS 4
#define CIRCLE_WIDTH 4
#define PROGRESS_WIDTH 6
#define TEXT_SIZE 30
#define TIMER_INTERVAL 0.05


@implementation CircularProgressBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initData];
        [self initView];
    }
    return self;
    
}

- (void)initData {
    // 圆周为 2 * pi * R, 默认起始点于正右方向为 0 度， 改为正上为起始点
    startAngle = -0.5 * M_PI;
    endAngle = startAngle;
    
    _totalTime = 0;
//    
//    textFont = [UIFont fontWithName: @"Helvetica Neue" size: TEXT_SIZE];
//    textColor = [UIColor redColor];
//    textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
//    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    textStyle.alignment = NSTextAlignmentCenter;
    
    self.b_timerRunning = NO;

}

- (void)initView {
    self.backgroundColor =[UIColor clearColor];
    self.opaque = NO;
    
}

- (void)drawRect:(CGRect)rect {
    if (_totalTime == 0)
        endAngle = startAngle;
    else{
        endAngle = (self.time_left / _totalTime) * 2 * M_PI + startAngle;
//    _huanchongtiem=(_huanchongtiem/_totalTime) *2*M_PI+startAngle;
    
    }
            CGFloat d=(_huangchong/_totalTime)*2*M_PI+startAngle;
//        NSLog(@"%f",d);

//    NSLog(@"endangle%f,d%f,huangchong%f,totoatime%2",endAngle,d,_huangchong,_totalTime);
    
//    NSLog(@"%f",_huangchong);
    
    UIBezierPath *circle = [UIBezierPath bezierPath];
    [circle addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius:RADIUS
                      startAngle:0
                        endAngle:2 * M_PI
                       clockwise:YES];
    circle.lineWidth = CIRCLE_WIDTH;
   [[UIColor whiteColor]setStroke];
    [circle stroke];

    
    UIBezierPath *progress = [UIBezierPath bezierPath];
    [progress addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius:RADIUS
                      startAngle:startAngle
                        endAngle:d
                       clockwise:YES];
    progress.lineWidth = PROGRESS_WIDTH;
//    [[UIColor redColor] setStroke];
    [[UIColor colorWithRed:0.15 green:0.51 blue:0.99 alpha:1.0] set];
    [progress stroke];
    
    CGPoint pos = [self getCurrentPointAtAngle:d inRect:rect];
    [self drawPointAt:pos];
    
    
    
    
    UIBezierPath *progress1 = [UIBezierPath bezierPath];
    [progress1 addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                        radius:RADIUS
                    startAngle:startAngle
                      endAngle:endAngle
                     clockwise:YES];
    progress1.lineWidth = PROGRESS_WIDTH;
    //    [[UIColor redColor] setStroke];
    [[UIColor whiteColor] set];
    [progress1 stroke];
    
    CGPoint pos1 = [self getCurrentPointAtAngle:endAngle inRect:rect];
    [self drawPointAt:pos1];
    
    
    
//    UIBezierPath *progress1 = [UIBezierPath bezierPath];
//    [progress1 addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
//                        radius:RADIUS
//                    startAngle:startAngle
//                      endAngle:_huanchongtiem
//                      clockwise:YES];
//    progress1.lineWidth = PROGRESS_WIDTH;
//    //    [[UIColor redColor] setStroke];
//    [[UIColor redColor] set];
//    [progress1 stroke];
//    
//    CGPoint pos1 = [self getCurrentPointAtAngle:_huanchongtiem inRect:rect];
//    [self drawPointAt:pos1];
//
    
    
    
//    [[UIColor blackColor] setFill];
    
    //    NSString *textContent = [NSString stringWithFormat:@"%2.2f", self.time_left];
//    NSString *textContent = [TimeHelper formatTimeWithSecond:self.time_left];
//    
//    CGSize textSize = [textContent sizeWithAttributes:@{NSFontAttributeName:textFont}];
//    
//    CGRect textRect = CGRectMake(rect.size.width / 2 - textSize.width / 2,
//                                 rect.size.height / 2 - textSize.height / 2,
//                                 textSize.width , textSize.height);
//    
//    [textContent drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont, NSForegroundColorAttributeName:textColor, NSParagraphStyleAttributeName:textStyle}];
    
}

- (CGPoint)getCurrentPointAtAngle:(CGFloat)angle inRect:(CGRect)rect {
    //画个图就知道怎么用角度算了
    CGFloat y = sin(angle) * RADIUS;
    CGFloat x = cos(angle) * RADIUS;
    
    CGPoint pos = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    pos.x += x;
    pos.y += y;
    return pos;
}
//这边时调整滑动点的
- (void)drawPointAt:(CGPoint)point {

    UIBezierPath *dot = [UIBezierPath bezierPath];
    [dot addArcWithCenter:CGPointMake(point.x, point.y)
                        radius:POINT_RADIUS
                    startAngle:0
                      endAngle:2 * M_PI
                     clockwise:YES];
    dot.lineWidth = 1;
//    [[UIColor redColor] setFill];
    [dot fill];
    
}

- (void)setTotalSecondTime:(CGFloat)time {
    _totalTime = time;
    
//    self.time_left = totalTime;
}

- (void)setTotalMinuteTime:(CGFloat)time {
    _totalTime = time * 60;
    self.time_left = _totalTime;
}

- (void)startTimer {
    if (!self.b_timerRunning) {
        m_timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:@selector(setProgress) userInfo:nil repeats:YES];
        self.b_timerRunning = YES;
    }
}

- (void)pauseTimer {
    if (self.b_timerRunning) {
        [m_timer invalidate];
        m_timer = nil;
        self.b_timerRunning = NO;
    }
}

- (void)setProgress {
    if (self.time_left <= _totalTime) {
//        self.time_left += TIMER_INTERVAL;
        [self setNeedsDisplay];
    } else {
        [self pauseTimer];
        if (self.delegate ) {
            [self.delegate CircularProgressEnd];
        }
    }
}

- (void)stopTimer {
    [self pauseTimer];
    
    startAngle = -0.5 * M_PI;
    endAngle = startAngle;
    self.time_left = 0;
    [self setNeedsDisplay];

}
@end
