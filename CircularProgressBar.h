//
//  CircularProgressBar.h
//  CircularProgressBar
//
//  Created by du on 10/8/15.
//  Copyright © 2015 du. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CircularProgressDelegate

- (void)CircularProgressEnd;

@end


@interface CircularProgressBar : UIView
{
    CGFloat startAngle;
    CGFloat endAngle;
    
    UIFont *textFont;
    UIColor *textColor;
    NSMutableParagraphStyle *textStyle;
    
    NSTimer *m_timer;
//    CGFloat huangchong;
}

@property(nonatomic, weak) id<CircularProgressDelegate> delegate;
@property(nonatomic)CGFloat time_left;

@property(nonatomic, assign) bool b_timerRunning;
@property(nonatomic, assign) int  totalTime;
@property(nonatomic,assign)CGFloat huangchong;
- (void)setTotalSecondTime:(CGFloat)time;
- (void)setTotalMinuteTime:(CGFloat)time;

- (void)startTimer;
- (void)stopTimer;
- (void)pauseTimer;

@end
