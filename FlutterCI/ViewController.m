//
//  ViewController.m
//  FlutterCI
//
//  Created by 郝宏伟 on 2020/5/28.
//  Copyright © 2020 郝宏伟. All rights reserved.
//

@import Flutter;
#import "AppDelegate.h"
#import "ViewController.h"

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    // Make a button to call the showFlutter function when pressed.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(showFlutter)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Show Flutter!" forState:UIControlStateNormal];
    button.backgroundColor = UIColor.blueColor;
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
}

- (void)showFlutter {

    FlutterViewController *flutterViewController =
        [[FlutterViewController alloc] init];
    [self presentViewController:flutterViewController animated:YES completion:nil];
}
@end
