//
//  UIColor+Random.m
//  PullViewOC
//
//  Created by travelsky on 2018/4/10.
//  Copyright © 2018年 wangdicen. All rights reserved.
//

#import "UIColor+Random.h"

@implementation UIColor (Random)

+(UIColor *)randomColor
{
    CGFloat red = (CGFloat)(arc4random()%255);
    CGFloat green = (CGFloat)(arc4random()%255);
    CGFloat blue = (CGFloat)(arc4random()%255);
    
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];

}
@end
