//
//  ImageResource.h
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/24.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, GamePause)
{
    GamePauseNormal = 0,
    GamePauseHeilighted,
    GamePauseRestar,
    GamePauseRestarHilighted
};
@interface ImageResource : NSObject

@property (nonatomic,strong) UIImage *mainBackImage;

@property (nonatomic,strong) UIImage *logoImage;

@property (nonatomic,strong) UIImage *gameBackImage;

@property (nonatomic,strong) NSArray *controlButtonPause;

@property (nonatomic,strong) NSArray *heroFlyImages;

@property (nonatomic,strong) UIImage *bulletImage;

@property (nonatomic,strong) UIImage *smallEnemyImage;

@property (nonatomic,strong) NSArray *smallEnemyBlowUpImgaes;
+ (instancetype)sharedImages;


@end
