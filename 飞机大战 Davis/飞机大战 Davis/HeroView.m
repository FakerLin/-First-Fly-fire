//
//  HeroView.m
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/25.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "HeroView.h"

@implementation HeroView

- (instancetype)initWithHeroImages:(NSArray *)images
{
    if (self = [super initWithImage:images[0]]) {
        self.animationImages = images;
        self.animationDuration = 1.0f;
        [self startAnimating];
    }
    return self;
}

@end
