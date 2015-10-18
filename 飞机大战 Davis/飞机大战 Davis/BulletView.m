//
//  BulletView.m
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/26.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "BulletView.h"

@implementation BulletView

- (instancetype)initWithBullet:(Bullet *)bullet andImage:(UIImage *)image
{
    if (self = [super initWithImage:image]) {
        self.bullet = bullet;
    }
    return self;
}

@end
