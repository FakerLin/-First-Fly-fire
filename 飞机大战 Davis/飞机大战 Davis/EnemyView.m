//
//  EnemyView.m
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/26.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "EnemyView.h"
#import "ImageResource.h"
#import "Enemy.h"
@implementation EnemyView

- (instancetype)initWithEnemy:(Enemy *)enemy
{
    if (self = [super initWithImage:[ImageResource sharedImages].smallEnemyImage]) {
        self.enemy = enemy;
        self.center = enemy.position;
    }
    return self;
}

@end
