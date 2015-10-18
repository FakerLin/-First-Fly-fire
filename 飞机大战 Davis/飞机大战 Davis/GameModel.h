//
//  GameModel.h
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/25.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class Hero;
@interface GameModel : NSObject

@property (nonatomic) CGRect gameRect;
@property (nonatomic) CGRect bgFrame1;
@property (nonatomic) CGRect bgFrame2;
@property (nonatomic,strong) Hero *hero;

+ (instancetype)gameModelWithGameArea:(CGRect)gameRect andHeroSize:(CGSize)size;

- (void)moveBackGround;
@end
