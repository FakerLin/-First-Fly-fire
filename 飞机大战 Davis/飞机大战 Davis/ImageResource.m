//
//  ImageResource.m
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/24.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "ImageResource.h"

@implementation ImageResource

+ (instancetype)sharedImages
{
    static ImageResource *shared;
#if 0
    //最简单的单例实现
    if (shared == nil) {
        shared = [[ImageResource alloc]init];
    }
    
#else
    //在多线程标准的单例写法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[ImageResource alloc]initSharedImages];
    });
#endif
    return shared;
}

- (instancetype)initSharedImages
{
    if (self = [super init]) {
        //取出imageBundle
        NSString *bundlePath = [[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"Image.bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithPath:bundlePath];
        
        //创建主界面的背景图片
        //之前未封装的代码
//        NSString *imagePath = [imageBundle pathForResource:@"background_2" ofType:@"png"];
        
        _mainBackImage = [self imageWithImageName:@"background_2" andBundle:imageBundle];
        
        //取出logo图片
        _logoImage = [self imageWithImageName:@"BurstAircraftLogo" andBundle:imageBundle];
        
        //游戏背景图片
        _gameBackImage = [self imageWithImageName:@"background_2" andBundle:imageBundle];
        
        //游戏开始暂停控制图片
        _controlButtonPause = @[[self imageWithImageName:@"BurstAircraftPause" andBundle:imageBundle],
                                [self imageWithImageName:@"BurstAircraftPauseHL" andBundle:imageBundle],
                                [self imageWithImageName:@"BurstAircraftStart" andBundle:imageBundle],
                                [self imageWithImageName:@"BurstAircraftStartHL" andBundle:imageBundle]
                               ];
        //获取英雄飞机的图片组
        _heroFlyImages = [self imagesWithFormat:@"hero_fly_" andBundle:imageBundle andCount:2];
        
        //子弹图片
        _bulletImage = [self imageWithImageName:@"bullet2" andBundle:imageBundle];
        
        //小敌机的图片
        _smallEnemyImage = [self imageWithImageName:@"enemy1_fly_1" andBundle:imageBundle];
        
        //获取飞机击中图片组
        _smallEnemyBlowUpImgaes = [self imagesWithFormat:@"enemy1_blowup_" andBundle:imageBundle andCount:4];
    }
    return self;
}

- (UIImage *)imageWithImageName:(NSString *)imageName andBundle:(NSBundle *)bundle
{
    NSString *imagePath = [bundle pathForResource:imageName ofType:@"png"];
    UIImage *image = [UIImage imageNamed:imagePath];
    return image;
}

//生成图片组
- (NSArray *)imagesWithFormat:(NSString *)format andBundle:(NSBundle *)bundle andCount:(NSInteger)count
{
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = 1; i < count+1 ; i++) {
        UIImage *image = [self imageWithImageName:[NSString stringWithFormat:@"%@%ld",format,(long)i] andBundle:bundle];
        [images addObject:image];
    }
    return images;
}
@end
