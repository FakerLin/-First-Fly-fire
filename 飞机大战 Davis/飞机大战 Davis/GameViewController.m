//
//  GameViewController.m
//  飞机大战 Davis
//
//  Created by qingyun on 15/9/25.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//
//跟音乐播放器相关的头文件
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#import "GameViewController.h"
#import "ImageResource.h"
#import "GameModel.h"
#import "HeroView.h"
#import "BackGroundView.h"
#import "Hero.h"
#import "Bullet.h"
#import "BulletView.h"
#import "Enemy.h"
#import "EnemyView.h"
#define SharedImages [ImageResource sharedImages]

NSInteger allSteps = 0;

@interface GameViewController ()

//游戏视图的容器
@property (nonatomic,strong) UIView *gameView;

//游戏背景视图
@property (nonatomic,strong) BackGroundView *backView;

//游戏的控制视图
@property (nonatomic,strong) UIView *controlView;
//得分板
@property (nonatomic,strong) UILabel *scoreLabel;
//计时板
@property (nonatomic,strong) UILabel *clockLabel;
//英雄飞机
@property (nonatomic,strong) HeroView *heroView;
//飞机模型
@property (nonatomic,strong) GameModel *gameModel;
//游戏计时器
@property (nonatomic,strong) CADisplayLink *gameTimer;
//子弹集合
@property (nonatomic,strong) NSMutableSet *bulletSet;
//敌机集合
@property (nonatomic,strong) NSMutableSet *enemySet;
//总得分
@property (nonatomic) NSInteger totalScore;
//是否暂停
@property (nonatomic) BOOL isPause;
//播放器
@property (nonatomic,strong) AVAudioPlayer *player;
//射击的
@property (nonatomic) SystemSoundID fireSoundID;
//爆炸的声音
@property (nonatomic) SystemSoundID boolSoundID;


@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isPause = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    // 初始化子弹组
    self.bulletSet = [NSMutableSet set];
    self.enemySet = [NSMutableSet set];
    //设置游戏场景的容器
    [self setgameView];
    
    //设置hero模型⚠️这个是后来移上去了尽早实现，hero 和 position
    [self setGameModel];
    
    //设置背景
    [self setBackView];//拿到frame1 和2
    
    //设置基本游戏场景
    [self setGameSence];//在backView之上显示，不能随着backView一起移动
    
    //设置hero
    [self setHeroView];//一定要最上层
    
    //播放背景音乐
    [self playMusic];
    
    
}

- (void)playMusic
{
    //取出bundle
    NSString *bundlePath = [[[NSBundle mainBundle]bundlePath] stringByAppendingPathComponent:@"Music.bundle"];
    NSBundle *musicBundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString *musicPath = [musicBundle pathForResource:@"game_music.mp3" ofType:nil];
    NSError *error;
    //音乐播放器
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:musicPath] error:&error];
    if (error != nil) {
        NSLog(@"%@",error);
    }
    self.player = player;
    //代表一直播放
    self.player.numberOfLoops = -1;
    //驱动硬件
    [self.player prepareToPlay];
    [self.player play];
    
    //设置其他声音
    //射击的
    NSString *fireSound = [musicBundle pathForResource:@"bullet" ofType:@"mp3"];
    NSURL *fireUrl = [NSURL fileURLWithPath:fireSound];
    SystemSoundID fireID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fireUrl), &fireID);
    _fireSoundID = fireID;
    //爆炸的
    NSString *boolSound = [musicBundle pathForResource:@"enemy1_down" ofType:@"mp3"];
    NSURL *boolUrl = [NSURL fileURLWithPath:boolSound];
    SystemSoundID BoolID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(boolUrl), &BoolID);
    _boolSoundID = BoolID;
}

//在游戏全部加载之后实现时间器
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [NSThread sleepForTimeInterval:1.0f];
    //设置时间器
    [self setGameTimer];
}

- (void)setgameView
{
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _gameView = view;
    [self.view addSubview:_gameView];
}

- (void)setBackView
{
    //将来背景需要移动。所以需要两个背景视图交替显示，所以自定义一个backgroundView
    BackGroundView *view = [[BackGroundView alloc]initWithFrame:self.view.bounds andImage:SharedImages.gameBackImage];
    _backView = view;
    [self.gameView addSubview:_backView];
    
    [_backView setBackGroundFrame1:self.gameModel.bgFrame1 andBackGroundFrame2:self.gameModel.bgFrame2];
    
//    UIImageView *backView = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    backView.image = SharedImages.gameBackImage;
//    [self.gameView addSubview :backView];
}

//设置游戏场景
- (void)setGameSence
{
    //控制视图
    UIView *controlView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    controlView.backgroundColor = [UIColor clearColor];
    _controlView = controlView;
    [self.gameView addSubview:_controlView];
    
    //设置得分板和计时板
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 200, 20)];
    label.font = [UIFont fontWithName:@"Marker Felt" size:20.0f];
    _scoreLabel = label;
    _scoreLabel.text = @"000";
    _scoreLabel.textColor = [UIColor grayColor];
    [self.controlView addSubview:_scoreLabel];
    
    UILabel *timerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.view.bounds.size.height - 40, 60, 20)];
    timerLabel.text = @"00:00";
    _clockLabel = timerLabel;
    [self.controlView addSubview:_clockLabel];
    
    //设置开始暂停按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 20, 50, 20);
    [btn setImage:SharedImages.controlButtonPause[GamePauseNormal] forState:UIControlStateNormal];
    [btn setImage:SharedImages.controlButtonPause[GamePauseHeilighted] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(pauseGame:) forControlEvents:UIControlEventTouchUpInside];
    [self.controlView addSubview:btn];
}

- (void)setHeroView
{
    HeroView *view = [[HeroView alloc]initWithHeroImages:SharedImages.heroFlyImages];
    _heroView = view;
    self.heroView.center = self.gameModel.hero.position ;
    [self.gameView addSubview:_heroView];
}

- (void)setGameModel
{
    CGSize size = [SharedImages.heroFlyImages[0] size];
    GameModel *gameModel = [GameModel gameModelWithGameArea:self.gameView.bounds andHeroSize:size];
    _gameModel = gameModel;
   // _heroView = gameModel.hero;
}

- (void)setGameTimer
{
    CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(steps)];
    //添加到循环并启动
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.gameTimer = timer;
}

//移动
- (void)steps
{
    //计时器每次运行都要将总时间++
    allSteps ++;
    
    //更新计时板
    //因为计时器每走一次是60分之1秒，所以60次为一秒
    if (allSteps % 60 == 0) {
        NSString *timeStr = [NSString stringWithFormat:@"%02ld:%02ld",(allSteps/60)/60,(allSteps/60)%60];
        _clockLabel.text = timeStr;
    }
    //所有的游戏内容都在此方法中处理,只负责更改数据，但是没有跟新视图
    [self.gameModel moveBackGround];
    //根据bgframe1和2 设置背景
    //让背景移动
    [self.backView setBackGroundFrame1:self.gameModel.bgFrame1 andBackGroundFrame2:self.gameModel.bgFrame2];
    //用来触摸移动后的更新
    self.heroView.center = self.gameModel.hero.position;
    //处理子弹效果
    if (allSteps % 10 == 0) {
        [self.gameModel.hero fire];//射击
        
        //创建新的子弹视图
        BulletView *bulletView = [[BulletView alloc]initWithBullet:self.gameModel.hero.currentBullet andImage:SharedImages.bulletImage];
        bulletView.center = bulletView.bullet.position;
        [self.gameView addSubview:bulletView];
        
        [self.bulletSet addObject:bulletView];
        
        AudioServicesPlaySystemSound(_fireSoundID);
    }
    
    //子弹飞并且处理超出的子弹
    [self bulletFly];
    
    //敌机出现
    [self creatEnmeies];
    
    //敌机起飞
    [self enemyFly];
    
    //处理子弹，敌机及英雄三种视图的碰撞效果
    [self battle];
}

- (void)bulletFly
{
    
    NSMutableSet *removeSet = [NSMutableSet set];
    
    //超出屏幕的飞机移除
    for (BulletView *bullet  in self.bulletSet) {
        //让子弹飞
        CGPoint nextPoint = CGPointMake(bullet.center.x, bullet.center.y - 30);
        bullet.center = nextPoint;
        if (CGRectGetMaxY(bullet.frame) <= 0) {
            [bullet removeFromSuperview];
            [removeSet addObject:bullet];
        }
    }
    //从根本上移除超出的bullet
    for (BulletView *bullet in removeSet) {
        [_bulletSet removeObject:bullet];
    }
    
    //创建新的子弹视图
//    BulletView *bulletView = [[BulletView alloc]initWithBullet:self.gameModel.hero.currentBullet andImage:SharedImages.bulletImage];
//    bulletView.center = bulletView.bullet.position;
//    [self.gameView addSubview:bulletView];
//    
//    [self.bulletSet addObject:bulletView];
    [removeSet removeAllObjects];
}

//创建敌机
- (void)creatEnmeies
{
    //产生一个0到Var-1 之间的随机数
    //得到一个随机数0-9之间的数，然后由总时间进度对该随机数进行整除，可以的话制造敌机以达到随机制造敌机的效果
    u_int32_t times = arc4random_uniform(10)+60;
    if (allSteps % times == 0) {
        Enemy *enemy = [Enemy enemyWithSize:SharedImages.smallEnemyImage.size andGameRect:self.gameModel.gameRect];
        EnemyView *enemyView = [[EnemyView alloc]initWithEnemy:enemy];
        [self.gameView addSubview:enemyView];
        [self.enemySet addObject:enemyView];
    }
}

- (void)enemyFly
{
    NSMutableSet *removeSet = [NSMutableSet set];
    for (EnemyView *enemyView in self.enemySet) {
        Enemy *enemy = enemyView.enemy;
        enemy.position = CGPointMake(enemy.position.x, enemy.position.y + enemy.speed);
        enemyView.center = enemy.position;
        if (enemyView.frame.origin.y >= self.gameModel.gameRect.size.height) {
            [removeSet addObject:enemyView];
        }
    }
    for (EnemyView *enemy in removeSet) {
        [enemy removeFromSuperview];
        [self.enemySet removeObject:enemy];
    }
    
}

- (void)battle
{
    NSMutableSet *removeSet = [NSMutableSet set];
    //判断是否爆炸
    for (EnemyView *enemyView in self.enemySet) {
        Enemy *enemy = enemyView.enemy;
        for (BulletView *bulletView in self.bulletSet) {
            if (CGRectIntersectsRect(enemyView.frame, bulletView.frame)) {
                enemy.isBlowUp = YES;
                //爆炸声
                AudioServicesPlaySystemSound(_boolSoundID);
                _totalScore += enemy.price;
                //更新得分板
                NSString *scoreStr = [NSString stringWithFormat:@"%ld000",_totalScore];;
                _scoreLabel.text = scoreStr;
            }
        }
    }
    if (allSteps % 20 == 0) {
        //处理爆炸效果
        for (EnemyView *enemyView in self.enemySet) {
            if (enemyView.enemy.isBlowUp) {
                enemyView.enemy.speed = 0;
                //enemyView.animationImages = SharedImages.smallEnemyBlowUpImgaes;
                enemyView.image = SharedImages.smallEnemyBlowUpImgaes[enemyView.enemy.blowUpFrame ++];
            }
            if (enemyView.enemy.blowUpFrame == SharedImages.smallEnemyBlowUpImgaes.count) {
                [removeSet addObject:enemyView];
            }
        }
        for (EnemyView *enemyView in removeSet) {
            [enemyView removeFromSuperview];
            [self.enemySet removeObject:enemyView];
        }
        [removeSet removeAllObjects];
        
        //根据敌机的爆炸情况计分
    }
    //这里可以加敌机与英雄
    if (allSteps == 60*100) {
        [self.gameTimer invalidate];
        NSString *totalScore = [NSString stringWithFormat:@"本次游戏得分%ld000",self.totalScore];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"游戏结束" message:totalScore delegate:self cancelButtonTitle:@"重新开始" otherButtonTitles:@"回到主菜单",@"退出游戏", nil];
        [alert show];
    }
}

//处理弹出框中用户交互
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //清空计时器和得分板
        self.clockLabel.text = @"00:00";
        self.scoreLabel.text = @"000";
        self.totalScore = 0;
        allSteps = 0;
        //移除所有的子弹和敌机
        for (BulletView *bullet in self.bulletSet) {
            [bullet removeFromSuperview];
        }
        for (EnemyView *enemy in self.enemySet) {
            [enemy removeFromSuperview];
        }
        //重置gameModel
        [self setGameModel];
        [self setGameTimer];
    }else if (buttonIndex == 1){
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        [UIView animateWithDuration:1.0f animations:^{
            self.view.window.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            exit(0);
        }];
    }
}

//处理英雄拖动效果
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint previous = [touch previousLocationInView:self.gameView];
    CGPoint location = [touch locationInView:self.gameView];
    //计算偏移量
    CGPoint offSet = CGPointMake(location.x-previous.x, location.y-previous.y);
    CGPoint heroPosition = CGPointMake(self.gameModel.hero.position.x+offSet.x, self.gameModel.hero.position.y+offSet.y);
    if (heroPosition.x >= self.gameView.frame.size.width - self.gameModel.hero.size.width/2) {
        heroPosition.x = self.gameView.frame.size.width - self.gameModel.hero.size.width/2;
    }else if (heroPosition.x <= self.gameModel.hero.size.width/2){
        heroPosition.x = self.gameModel.hero.size.width/2;
    }
    
    if (heroPosition.y >= self.gameView.frame.size.height - self.gameModel.hero.size.height/2) {
        heroPosition.y = self.gameView.frame.size.height - self.gameModel.hero.size.height/2;
    }else if (heroPosition.y <= self.gameModel.hero.size.height/2){
        heroPosition.y = self.gameModel.hero.size.height;
    }
    self.gameModel.hero.position = heroPosition;
}
//设置开始暂停选项
- (void)pauseGame:(UIButton *)sender
{
    if (_isPause) {
        _isPause = NO;
        [self setGameTimer];
        [self.player play];
        [sender setImage:SharedImages.controlButtonPause[GamePauseNormal] forState:UIControlStateNormal];
        [sender setImage:SharedImages.controlButtonPause[GamePauseHeilighted] forState:UIControlStateHighlighted];
    }else{
        _isPause = YES;
        //暂停计时器
        [self.gameTimer invalidate];
        [self.player stop];
        [sender setImage:SharedImages.controlButtonPause[GamePauseRestar] forState:UIControlStateNormal];
        [sender setImage:SharedImages.controlButtonPause[GamePauseRestarHilighted] forState:UIControlStateHighlighted];
    }
}

@end
