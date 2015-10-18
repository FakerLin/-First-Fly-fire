//
//  Hero.h
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/25.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class Bullet;
@interface Hero : NSObject

@property (nonatomic) CGPoint position;
@property (nonatomic) CGSize size;
@property (nonatomic,strong) Bullet *currentBullet;

+ (instancetype)heroWithPosition:(CGPoint)position andSize:(CGSize)size;

- (void)fire;
@end
