//
//  UIImageView+LightLetYourBlind.m
//  LightLetYourBlind
//
//  Created by 刘俊 on 2017/2/22.
//  Copyright © 2017年 刘俊. All rights reserved.
//

#import "UIImageView+LightLetYourBlind.h"
#import <objc/runtime.h>

static const char lightRotationAngleKey = '1';
static const char lightWidthKey = '2';
static const char lightAnimationIntervalKey = '3';
static const char lightAnimationNextShowIntervalKey = '4';
static const char lightAniDirectionKey = '5';
static const char lightBackLayerKey = '6';
static const char grandLayerKey = '7';
static const char nextAnimationTimerKey = '8';


@interface UIImageView () <CAAnimationDelegate>

@property (strong, nonatomic) CALayer *lightBackLayer;

@property (strong, nonatomic) CALayer *grandLayer;

@property (strong, nonatomic) NSTimer *nextAnimationTimer;

@end

@implementation UIImageView (LightLetYourBlind)

- (void)dealloc {
    [self.nextAnimationTimer invalidate];
    self.nextAnimationTimer = nil;
}

/**
 开启动画
 */
- (void)startLightAnimation {
    
    if ([self isKindOfClass:[UIImage class]]) {
        if (!self.lightBackLayer) {
            //亮光的背景Layer 到时候就在这个页面添加Mask
            CALayer *lightBackLayer = [[CALayer alloc] init];
            lightBackLayer.backgroundColor = [UIColor clearColor].CGColor;
            lightBackLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
            [self.layer addSublayer:lightBackLayer];
            self.lightBackLayer = lightBackLayer;
            
            //亮光渐变的Layer
            CAGradientLayer *grandLayer = [[CAGradientLayer alloc] init];
            grandLayer.colors = @[(__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:0.0].CGColor,(__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:0.8].CGColor,(__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:0.0].CGColor];
            grandLayer.frame = CGRectMake(0, 0, self.lightWidth, CGRectGetHeight(self.frame));
            grandLayer.startPoint = CGPointMake(0, 0.5);//渲染的开始
            grandLayer.endPoint = CGPointMake(1, 0.5);//渲染的结束
            [self.layer addSublayer:grandLayer];
            grandLayer.transform = CATransform3DMakeRotation(self.lightRotationAngle, 0.0, 0.0, 1);
            self.grandLayer = grandLayer;
            
            [lightBackLayer addSublayer:grandLayer];
            lightBackLayer.mask = [self maskLayer];
        }
    }else {
        //亮光渐变的Layer
        CAGradientLayer *grandLayer = [[CAGradientLayer alloc] init];
        grandLayer.colors = @[(__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:0.0].CGColor,(__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:0.8].CGColor,(__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:0.0].CGColor];
        grandLayer.frame = CGRectMake(0, 0, self.lightWidth, CGRectGetHeight(self.frame));
        grandLayer.startPoint = CGPointMake(0, 0.5);//渲染的开始
        grandLayer.endPoint = CGPointMake(1, 0.5);//渲染的结束
        [self.layer addSublayer:grandLayer];
        grandLayer.transform = CATransform3DMakeRotation(self.lightRotationAngle, 0.0, 0.0, 1);
        self.grandLayer = grandLayer;
    }
    [self beginAnimation];
}

- (void)beginAnimation {
    //然后移动的动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    if (self.lightAniDirection == LightLetYourBlindAnimationDirectionRightBottom) {
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    }else if (self.lightAniDirection == LightLetYourBlindAnimationDirectionRightTop) {
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, CGRectGetHeight(self.bounds))];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.bounds), 0)];
    }else {
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, CGRectGetHeight(self.bounds) * 0.5)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) * 0.5)];
    }
    animation.repeatCount = 2;
    animation.duration = self.lightAnimationInterval * 2;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    [self.grandLayer addAnimation:animation forKey:@"lightBlindAnimation"];
}

- (CALayer *)maskLayer {
    CALayer *layer = [[CALayer alloc] init];
    layer.contents = (__bridge id _Nullable)(self.image.CGImage);
    layer.frame = self.bounds;
    return layer;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//    if (flag) {
//        [self.grandLayer removeAnimationForKey:@"lightBlindAnimation"];
//    }
    if (self.lightAnimationNextShowInterval == 0) {
        [self.lightBackLayer removeFromSuperlayer];
        self.lightBackLayer = nil;
        self.grandLayer = nil;
    }
    else {
        [self.nextAnimationTimer invalidate];
        self.nextAnimationTimer = nil;
        self.nextAnimationTimer = [NSTimer scheduledTimerWithTimeInterval:self.lightAnimationNextShowInterval target:self selector:@selector(beginAnimation) userInfo:nil repeats:NO];
    }
}

#pragma mark -
#pragma mark - 属性
- (void)setLightRotationAngle:(CGFloat)lightRotationAngle {
    objc_setAssociatedObject(self, &lightRotationAngleKey, @(lightRotationAngle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)lightRotationAngle {
    NSNumber *value = objc_getAssociatedObject(self, &lightRotationAngleKey);
    return [value floatValue];
}

- (void)setLightWidth:(CGFloat)lightWidth {
    objc_setAssociatedObject(self, &lightWidthKey, @(lightWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)lightWidth {
    NSNumber *value = objc_getAssociatedObject(self, &lightWidthKey);
    if (!value) {
        value = @(50);
    }
    return [value floatValue];
}

- (void)setLightAnimationInterval:(NSTimeInterval)lightAnimationInterval {
    objc_setAssociatedObject(self, &lightAnimationIntervalKey, @(lightAnimationInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)lightAnimationInterval {
    NSNumber *value = objc_getAssociatedObject(self, &lightAnimationIntervalKey);
    if (!value) {
        value = @(0.5);
    }
    return [value floatValue];
}

- (void)setLightAniDirection:(LightLetYourBlindAnimationDirection)lightAniDirection {
    objc_setAssociatedObject(self, &lightAniDirectionKey, @(lightAniDirection), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LightLetYourBlindAnimationDirection)lightAniDirection {
    NSNumber *value = objc_getAssociatedObject(self, &lightAniDirectionKey);
    return [value floatValue];
}

- (void)setLightAnimationNextShowInterval:(NSTimeInterval)lightAnimationNextShowInterval {
    objc_setAssociatedObject(self, &lightAnimationNextShowIntervalKey, @(lightAnimationNextShowInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)lightAnimationNextShowInterval {
    NSNumber *value = objc_getAssociatedObject(self, &lightAnimationNextShowIntervalKey);
    return [value floatValue];
}

- (void)setLightBackLayer:(CALayer *)lightBackLayer {
    objc_setAssociatedObject(self, &lightBackLayerKey, lightBackLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)lightBackLayer {
    return objc_getAssociatedObject(self, &lightBackLayerKey);
}

- (void)setGrandLayer:(CALayer *)grandLayer {
    objc_setAssociatedObject(self, &grandLayerKey, grandLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)grandLayer {
    return objc_getAssociatedObject(self, &grandLayerKey);
}

- (void)setNextAnimationTimer:(NSTimer *)nextAnimationTimer {
    objc_setAssociatedObject(self, &nextAnimationTimerKey, nextAnimationTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimer *)nextAnimationTimer {
    return objc_getAssociatedObject(self, &nextAnimationTimerKey);
}

@end
