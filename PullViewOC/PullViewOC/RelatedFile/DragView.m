//
//  DragView.m
//  PullViewOC
//
//  Created by travelsky on 2018/4/10.
//  Copyright © 2018年 wangdicen. All rights reserved.
//

#import "DragView.h"

@implementation DragView
{
    CGPoint center;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
        self.gestureRecognizers = @[pan];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.superview bringSubviewToFront:self];
    center = self.center;
}

- (void)panHandle:(UIPanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture translationInView:self.superview];
    self.center = CGPointMake(center.x + translation.x, center.y + translation.y);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
