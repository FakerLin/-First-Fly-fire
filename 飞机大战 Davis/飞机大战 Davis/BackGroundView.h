//
//  BackGroundView.h
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/25.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackGroundView : UIView

@property (nonatomic,strong) UIImageView *backImageView1;
@property (nonatomic,strong) UIImageView *backImageView2;

- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)iamge;

- (void)setBackGroundFrame1:(CGRect)frame1 andBackGroundFrame2:(CGRect)frame2;
@end
