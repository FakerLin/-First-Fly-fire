//
//  Bullet.m
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/26.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "Bullet.h"

@implementation Bullet

+ (instancetype)bulletWithPosition:(CGPoint)position
{
    Bullet *bullet = [[Bullet alloc]init];
    bullet.position = position;
    return bullet;
}

@end
