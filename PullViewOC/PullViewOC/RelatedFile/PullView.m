//
//  PullView.m
//  PullViewOC
//
//  Created by travelsky on 2018/4/10.
//  Copyright © 2018年 wangdicen. All rights reserved.
//

#import "PullView.h"
#import "DragView.h"

#define DX(p1,p2) (p2.x - p1.x)
#define DY(p1,p2) (p2.y - p1.y)

const NSInteger kSwipeDragMin = 16;
const NSInteger kDragLimitMax = 12;

typedef enum {
    TouchUnknown,
    TouchSwipeLeft,
    TouchSwipeRight,
    TouchSwipeUp,
    TouchSwipeDown,
}SwipeTypes;

@implementation PullView
{
    DragView *dragView;
    BOOL gestureWasHandled;
    int pointCount;
    CGPoint startPoint;
    NSUInteger touchType;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        pan.delegate = self;
        self.gestureRecognizers = @[pan];
    }
    return self;
}
/*
 是否允许多个手势识别器共同识别，一个控件的手势识别后是否阻断手势识别继续向下传播，
 默认返回NO；如果为YES，响应者链上层对象触发手势识别后，
 如果下层对象也添加了手势并成功识别也会继续执行，否则上层对象识别后则不再继续传播
 */

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)handlePan:(UIPanGestureRecognizer *)gesture
{
    //只在父视图为UIScrollView的情况下调用该方法
    if(![self.superview isKindOfClass:[UIScrollView class]])
    {
        return;
    }
    //scrollView的父视图
    UIView *supersuper = self.superview.superview;
    //父视图
    UIScrollView *scroll = (UIScrollView *)self.superview;
    
    CGPoint touchLocation = [gesture locationInView:supersuper];
    
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        gestureWasHandled = NO;
        pointCount = 1;
        startPoint = touchLocation;
    }
    if (gesture.state == UIGestureRecognizerStateChanged) {
        pointCount++;
        
        float dx = DX(touchLocation, startPoint);
        float dy = DY(touchLocation, startPoint);
        
        BOOL finished = YES;
        if ((dx > kSwipeDragMin) && (ABS(dy) < kDragLimitMax)) // hswipe left
            touchType = TouchSwipeLeft;
        else if ((-dx > kSwipeDragMin) && (ABS(dy) < kDragLimitMax)) // hswipe right
            touchType = TouchSwipeRight;
        else if ((dy > kSwipeDragMin) && (ABS(dx) < kDragLimitMax)) // vswipe up
            touchType = TouchSwipeUp;
        else if ((-dy > kSwipeDragMin) && (ABS(dx) < kDragLimitMax)) // vswipe down
            touchType = TouchSwipeDown;
        else
            finished = NO;
        
        // If unhandled and a downward swipe, produce a new draggable view
        if (!gestureWasHandled && finished && (touchType == TouchSwipeDown))
        {
            dragView = [[DragView alloc] initWithFrame:self.frame];
            dragView.center = touchLocation;
            dragView.backgroundColor = self.backgroundColor;
            [supersuper addSubview:dragView];
            scroll.scrollEnabled = NO;
            gestureWasHandled = YES;
        }
        else if (gestureWasHandled)
        {
            // allow continued dragging after detection
            dragView.center = touchLocation;
        }
        
    }
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        // ensure that the scroll view returns to scrollable
        if (gestureWasHandled)
            scroll.scrollEnabled = YES;
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
