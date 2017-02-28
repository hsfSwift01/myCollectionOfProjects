//
//  WhaterProgress.m
//  Data
//
//  Created by hipiao on 16/8/30.
//  Copyright © 2016年 James. All rights reserved.
//

#import "WhaterProgress.h"

#import "SXViewAdditions.h"


@implementation WhaterProgress

- (id)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame]) {
        _alpha = 1;
        _endless = NO;
        
        self.backgroundColor = [UIColor blueColor];
        [self initialize];
    }
    return self;
}
-(void)initialize{

    self.rotateImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-50, self.frame.size.height/2-50, 100, 100)];
    self.rotateImg.image = [UIImage imageNamed:@"fb_rotation"];
    [self addSubview:self.rotateImg];
    
    self.leftView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-50, self.frame.size.height/2-50, 100, 100)];
    [self addSubview:self.leftView];
    
    self.avgScoreLbl = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-50, self.frame.size.height/2-50+30, 100, 20)];
    [self.avgScoreLbl setTextAlignment:NSTextAlignmentCenter];
    self.avgScoreLbl.textColor = [UIColor redColor];
    [self addSubview:self.avgScoreLbl];
    
    self.discriptionLbl = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-50, self.frame.size.height/2, 100, 20)];
    self.discriptionLbl.text = @"进度";
    self.discriptionLbl.textColor = [UIColor redColor];
    [self.discriptionLbl setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.discriptionLbl];
}

- (void)setAlpha:(CGFloat)alpha{
    _alpha = alpha;
}

- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
}

- (void)setType:(int)type
{
    _type = type;
    // [self addAnimateWithType:self.type];
}
//倒计时
-(void)setingrateAnno:(int)precent
{
    __block int timeout=0; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0/precent*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout>precent)
        {
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        }
        else
        {
            //int minutes = timeout / 60;
            int seconds = timeout / 1;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.avgScoreLbl.text = [NSString stringWithFormat:@"%@%%",strTime];
            });
            timeout++;
        }
    });
    dispatch_resume(_timer);
}
- (void)setPrecent:(int)precent{
    _precent = precent;
    [self setingrateAnno:precent];
    self.avgScoreLbl.text = [NSString stringWithFormat:@"%d%%",precent];
    self.leftView.layer.cornerRadius = self.leftView.bounds.size.width/2.0;
    self.leftView.clipsToBounds = YES;
    
    UIImageView * bigImg = [[UIImageView alloc]init];
    bigImg.image = [UIImage imageNamed:@"fb_wave"];
    self.bigImg = bigImg;
    
    bigImg.alpha = 1;
    [self.leftView addSubview:bigImg];
    bigImg.frame = CGRectMake(0, 0, 450, 300);
    
    bigImg.top = 115;
    bigImg.left = -370;

}

- (void)setPrecent:(int)precent textColor:(UIColor *)tcolor type:(int)type alpha:(CGFloat)alpha
{
    [self setAlpha:alpha];
    [self setType:type];
    [self setTextColor:tcolor];
    [self setPrecent:precent];
}


- (void)addAnimateWithType:(int)type
{
    NSString * cellRotationKey = @"rotationAnimation";
    NSString * cellMoveKey = @"waveMoveAnimation";
    
    CABasicAnimation * transformRoate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    transformRoate.byValue = [NSNumber numberWithDouble:(2 * M_PI)];
    transformRoate.duration = 2;
    transformRoate.repeatCount = self.isEndless == YES ? MAXFLOAT : 2;
    [self.rotateImg.layer addAnimation:transformRoate forKey:cellRotationKey];
    
    __weak __typeof(&*self)weakSelf = self;
    void(^acallBack)(CGFloat start) = ^(CGFloat start) {
        CAKeyframeAnimation * moveAction = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
        moveAction.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:-60],[NSNumber numberWithFloat:start],nil];
        moveAction.duration = 10;
        moveAction.repeatCount = MAXFLOAT;
        [weakSelf.bigImg.layer addAnimation:moveAction forKey:cellMoveKey];
    };
    if (type == 0) {
        CGFloat avgScore = self.precent;
        [UIView animateWithDuration:4.0 animations:^{
            self.bigImg.top = 115 - ((avgScore/100.0) * 115);
            if (avgScore == 100) {
                self.bigImg.top = -20;
            }
            self.bigImg.left = 0;
        } completion:^(BOOL finished) {
            if (self.endless == YES) {
                acallBack(self.bigImg.layer.position.x);
            }
        }];
    }else if (type == 1){
        CGFloat avgScore = self.precent;
        [UIView animateWithDuration:4.0 animations:^{
            self.bigImg.top = 115 - ((avgScore/100.0) * 115);
            if (avgScore == 100) {
                self.bigImg.top = -20;
            }
            self.bigImg.left = 0;
        }completion:^(BOOL finished) {
            if (self.endless == YES) {
                acallBack(self.bigImg.layer.position.x);
            }
        }];
    }else if (type == 2){
        CGFloat avgScore = self.precent;
        [UIView animateWithDuration:1.0 animations:^{
            self.bigImg.top = 0;
            self.bigImg.left = -200;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:3.0 animations:^{
                self.bigImg.top = 115 - ((avgScore/100.0) * 115);
                if (avgScore == 100) {
                    self.bigImg.top = -20;
                }
                self.bigImg.left = 0;
            } completion:^(BOOL finished) {
                if (self.endless == YES) {
                    acallBack(self.bigImg.layer.position.x);
                }
            }];
        }];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
