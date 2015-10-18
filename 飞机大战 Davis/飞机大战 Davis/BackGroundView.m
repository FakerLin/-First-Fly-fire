//
//  BackGroundView.m
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/25.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "BackGroundView.h"

@implementation BackGroundView

//对自定义的backGroundView提供一个新的初始化方法，设计两个背景图片
- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image
{
    if (self = [super init]) {
        _backImageView1 = [[UIImageView alloc]initWithImage:image];
        [self addSubview:_backImageView1];
        
        _backImageView2 = [[UIImageView alloc]initWithImage:image];
        [self addSubview:_backImageView2];
    }
    return self;
}

- (void)setBackGroundFrame1:(CGRect)frame1 andBackGroundFrame2:(CGRect)frame2
{
    self.backImageView1.frame = frame1;
    self.backImageView2.frame = frame2;
    
}

@end
