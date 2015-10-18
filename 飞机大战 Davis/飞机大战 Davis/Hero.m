//
//  Hero.m
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/25.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "Hero.h"
#import "Bullet.h"
@implementation Hero

+ (instancetype)heroWithPosition:(CGPoint)position andSize:(CGSize)size
{
    Hero *hero = [[Hero alloc]init];
    hero.position = position;
    hero.size = size;
    return hero;
}

- (void)fire
{
    Bullet *bullet = [Bullet bulletWithPosition:CGPointMake(self.position.x, self.position.y - (self.size.height/2))];
    self.currentBullet = bullet;
}
@end
