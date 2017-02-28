//
//  UIImageView+LightLetYourBlind.h
//  LightLetYourBlind
//
//  Created by 刘俊 on 2017/2/22.
//  Copyright © 2017年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LightLetYourBlindAnimationDirection) {
    LightLetYourBlindAnimationDirectionRight = 0, //水平向右
    LightLetYourBlindAnimationDirectionRightBottom, //斜向右下
    LightLetYourBlindAnimationDirectionRightTop, //斜向右上
};

/**
 亮瞎你的眼
 */
@interface UIImageView (LightLetYourBlind)

@property (assign, nonatomic) CGFloat lightRotationAngle;/**< 亮光旋转的角度 默认为0*/

@property (assign, nonatomic) CGFloat lightWidth;/**< 亮光的宽度 默认50*/

@property (assign, nonatomic) NSTimeInterval lightAnimationInterval;/**< 动画时间 默认为0.5*/

@property (assign, nonatomic) LightLetYourBlindAnimationDirection lightAniDirection;/**< 动画移动的方向 默认水平*/

@property (assign, nonatomic) NSTimeInterval lightAnimationNextShowInterval;/**< 下一个周期显示动画的间隔时间 为0的时候 没有下一个周期*/

/**
 开启动画
 */
- (void)startLightAnimation;



@end
