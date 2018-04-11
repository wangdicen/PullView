//
//  ViewController.m
//  PullViewOC
//
//  Created by travelsky on 2018/4/10.
//  Copyright © 2018年 wangdicen. All rights reserved.
//

#import "ViewController.h"
#import "PullView.h"
#import "UIColor+Random.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 50)];
    scrollView.contentSize = CGSizeMake(50 * 10, 50);
    [self.view addSubview:scrollView];
    
    for (NSUInteger i = 0; i < 10; i++)
    {
    
        PullView *pullView = [[PullView alloc] initWithFrame:CGRectMake(i*50, 0, 50, 50)];
        pullView.backgroundColor = [UIColor randomColor];
        [scrollView addSubview:pullView];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
