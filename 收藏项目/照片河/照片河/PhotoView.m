//
//  PhotoView.m
//  照片河
//
//  Created by tarena on 16/6/12.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PhotoView.h"

@implementation PhotoView


- (instancetype)initWithI:(int)i
{
    self = [super init];
    if (self) {
        //0.2-1;
        float flag = i/10.0 + 0.1;
        
        
        self.alpha = flag;
        self.speed = flag*2;
        float w = 45+(90*flag);
        float h = 30+(60*flag);
        
        self.frame = CGRectMake(-w, arc4random()%(int)(667-h), w, h);
        
        self.dv = [[DrawView alloc]initWithFrame:self.bounds];
        self.dv.userInteractionEnabled = NO;
        [self addSubview:self.dv];
        
        //创建图片 要显示在绘制控件的上面
        self.iv = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:self.iv];
        //加白边
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 2;
        
        
        //添加单指点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        
        [self addGestureRecognizer:tap];
//        添加两个手指点击
        UITapGestureRecognizer *twoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoTapAction)];
        //设置2个手指点击
        twoTap.numberOfTouchesRequired = 2;
        [self addGestureRecognizer:twoTap];
    }
    return self;
}

-(void)twoTapAction{
    if (self.status == PhotoViewStatusBig) {
        
        [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
        
        //加动画
        CATransition *animation = [CATransition new];
        animation.duration = 1;
        animation.type = @"oglFlip";
        animation.subtype = @"fromLeft";
        [self.layer addAnimation:animation forKey:nil];
        
        //从放大状态变成 绘制状态
        self.status = PhotoViewStatusDraw;
        self.dv.userInteractionEnabled = YES;
    }else if (self.status == PhotoViewStatusDraw){
        self.status = PhotoViewStatusBig;
        self.dv.userInteractionEnabled = NO;
        
        [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
        //加动画
        CATransition *animation = [CATransition new];
        animation.duration = 1;
        animation.type = @"oglFlip";
        
        [self.layer addAnimation:animation forKey:nil];
    }

}
-(void)tapAction{
    
    
    if (self.status==PhotoViewStatusBig) {//还原到移动状态
        
        [UIView animateWithDuration:.5 animations:^{
            self.frame = self.oldFrame;
            self.iv.frame = self.bounds;
            self.dv.frame = self.bounds;
            
            self.speed = self.oldSpeed;
            self.alpha = self.oldAlpha;
            //从放大状态变成流动normal
            self.status = PhotoViewStatusNormal;
        }];

        
        
    }else if(self.status == PhotoViewStatusNormal){
       [UIView animateWithDuration:.5 animations:^{
           
           //放大之前记录原来的frame speed alpha
           self.oldFrame = self.frame;
           self.oldSpeed = self.speed;
           self.oldAlpha = self.alpha;
           
           self.bounds = CGRectMake(0, 0, 300, 200);
           self.center = CGPointMake(375/2.0, 667/2.0);
           self.speed = 0;
           self.alpha = 1;
           
           self.iv.frame = self.bounds;
           self.dv.frame = self.bounds;
           
           [self.superview bringSubviewToFront:self];
           
           self.status = PhotoViewStatusBig;
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
