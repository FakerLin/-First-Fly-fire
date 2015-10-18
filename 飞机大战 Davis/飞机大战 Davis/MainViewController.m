//
//  MainViewController.m
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/24.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "MainViewController.h"
#import "ImageResource.h"
#import "GameViewController.h"

#define SharedImages [ImageResource sharedImages]
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor clearColor];
    //设置主界面视图
    [self setMainView];
}

- (void)setMainView
{
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    bgView.image = SharedImages.mainBackImage;
    
    UIImageView *logoView = [[UIImageView alloc]initWithImage:SharedImages.logoImage];
    logoView.center = CGPointMake(([UIScreen mainScreen].bounds.size.width)/2, ([UIScreen mainScreen].bounds.size.height)/2);
    [bgView addSubview:logoView];
    [self.view addSubview:bgView];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    GameViewController *gameVC = [[GameViewController alloc]init];
    [self presentViewController:gameVC animated:YES completion:^{
        
    }];
}

@end
