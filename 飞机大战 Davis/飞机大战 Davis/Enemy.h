//
//  Enemy.h
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/26.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Enemy : NSObject

@property (nonatomic,assign) CGPoint position;
@property (nonatomic,assign) NSInteger speed;
@property (nonatomic) BOOL isBlowUp;
@property (nonatomic) NSInteger blowUpFrame;
@property (nonatomic) NSInteger price;

//根据游戏区域和敌机素材大小来生成敌机对象
+ (instancetype)enemyWithSize:(CGSize)size andGameRect:(CGRect)gameRect;

@end
