//
//  LancheViewController.m
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/24.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "LancheViewController.h"

#import "MainViewController.h"

@interface LancheViewController ()

@end

@implementation LancheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载界面
    [self setLaunchView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self launch];
}

- (void)setLaunchView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
//    UIImage *imgBg = [UIImage imageNamed:@"Image.bundle/background_2"];
    imageView.contentMode = UIViewContentModeCenter;
    //设置图片数组
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        NSString *imagePath = [NSString stringWithFormat:@"Image.bundle/loading%d",i];
        UIImage *image = [UIImage imageNamed:imagePath];
        [images addObject:image];
    }
    [self.view addSubview:imageView];
    imageView.animationImages = images;
    imageView.animationDuration = 1.0f;
    //imageView.animationRepeatCount = 10;
    [imageView startAnimating];
    
}

- (void)launch
{
    //等待两秒
    [NSThread sleepForTimeInterval:2.0f];
    MainViewController *mainVC = [[MainViewController alloc]init];
    [self presentViewController:mainVC animated:YES completion:^{
        NSLog(@"...");
    }];
}


@end
