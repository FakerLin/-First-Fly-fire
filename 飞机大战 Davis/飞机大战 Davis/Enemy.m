//
//  Enemy.m
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/26.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

+ (instancetype)enemyWithSize:(CGSize)size andGameRect:(CGRect)gameRect
{
    Enemy *enemy = [[Enemy alloc]init];
    
    //敌机从屏幕正上方加载，所以同类型敌机的origin.y是确定的，只需要制造随机的x即可
    CGFloat x = arc4random_uniform(gameRect.size.width-size.width)+size.width/2;
    CGPoint position = CGPointMake(x, -size.height/2);
    enemy.position = position;
    enemy.speed = 3;
    enemy.isBlowUp = NO;
    enemy.price = 2;
    return enemy;
}

@end
