//
//  GameModel.m
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/25.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "GameModel.h"
#import "Hero.h"

#define MoveStepOffSet 1
@implementation GameModel

+ (instancetype)gameModelWithGameArea:(CGRect)gameRect andHeroSize:(CGSize)size
{
    GameModel *gameModel = [[GameModel alloc]init];
    gameModel.gameRect = gameRect;
    //提供两个frame作为背景移动
    gameModel.bgFrame1 = gameRect;
    gameModel.bgFrame2 = CGRectOffset(gameRect, 0, -gameRect.size.height);
    
    //定位最初英雄战机的center
    CGPoint position = CGPointMake(gameRect.size.width/2, gameRect.size.height - (size.height/2));
    gameModel.hero = [Hero heroWithPosition:position andSize:size];
    return gameModel;
}

//移动游戏背景
- (void)moveBackGround
{
    //从这可以调节游戏难度，处理背景移动的效果，在计时器中不停调用该方法，让bgframe1和2一直向下移动
    _bgFrame1 = CGRectOffset(_bgFrame1, 0, MoveStepOffSet);
    _bgFrame2 = CGRectOffset(_bgFrame2, 0, MoveStepOffSet);
    //当其中一个frame移动至屏幕边界的时候移至最上方，交替显示
    if (_bgFrame1.origin.y >= _gameRect.size.height) {
        _bgFrame1 = CGRectOffset(_gameRect, 0, -_gameRect.size.height);
    }else if (_bgFrame2.origin.y >= _gameRect.size.height){
        _bgFrame2 = CGRectOffset(_gameRect, 0, -_gameRect.size.height);
    }
    
}

@end
