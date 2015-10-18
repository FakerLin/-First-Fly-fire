//
//  EnemyView.h
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/26.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Enemy;
@interface EnemyView : UIImageView

@property (nonatomic,strong) Enemy *enemy;

- (instancetype) initWithEnemy:(Enemy *)enemy;

@end
