
//
//  DataFansView.m
//  Data
//
//  Created by hipiao on 16/9/2.
//  Copyright © 2016年 James. All rights reserved.
//

#import "DataFansView.h"

@implementation DataFansView

- (id)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(DataFansView *)initWithFrame:(CGRect)frame andBeginAngle:(CGFloat)beginAngle andEndAngle:(CGFloat)endAngle andFillColor:(UIColor *)fillColor  name:(NSString *)name data:(NSString *)data{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.beginAngle = beginAngle;
        self.endAngle   = endAngle;
        self.fillColor  = fillColor;
        self.name       = name;
        self.data       = data;
        currentAngel = _beginAngle+(_endAngle-_beginAngle)/2;
        floatx = 100.0 * sin(currentAngel);
        floaty = 100.0 * cos(currentAngel);
        floatx1 = 70.0 * sin(currentAngel);
        floaty1 = 70.0 * cos(currentAngel);
        [self configBaseLayer];
        
    }
    return self;
}
- (void)configBaseLayer{
    _shapeLayer = [CAShapeLayer layer];
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:30 startAngle:_beginAngle endAngle:_endAngle clockwise:YES];;
    _shapeLayer.path        = path.CGPath;
    _shapeLayer.lineWidth   = 60;
    _shapeLayer.strokeColor = _fillColor.CGColor;
    _shapeLayer.fillColor   = [UIColor clearColor].CGColor;
    [self.layer addSublayer:_shapeLayer];
    
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basic.duration  = 1.1;
    basic.fromValue = @(0.1f);
    basic.toValue   = @(1.0f);
    [_shapeLayer addAnimation:basic forKey:@"basic"];
    
    UILabel * lb = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2, self.frame.size.height/2, 0, 0)];
    [lb setTextAlignment:NSTextAlignmentCenter];
    lb.font = [UIFont systemFontOfSize:12];
    lb.textColor = _fillColor;
    lb.text = [NSString stringWithFormat:@"%.2f%%",[self.data floatValue]*100];
    [self addSubview:lb];
    
    UILabel * lb1 = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2, self.frame.size.height/2, 0, 0)];
    lb1.backgroundColor = _fillColor;
    lb1.layer.masksToBounds = YES;
    lb1.layer.cornerRadius  = 5;
    [self addSubview:lb1];
    
    [UIView animateWithDuration:1.5 animations:^{
        lb.frame  = CGRectMake(self.frame.size.width/2, self.frame.size.height/2, 50, 20);
        if (currentAngel>=0&&currentAngel<M_PI/2) {//第四象限
           lb.center = CGPointMake(self.frame.size.width/2+floaty+25,self.frame.size.height/2+floatx-12);
        }
        if (currentAngel>=M_PI/2&&currentAngel<M_PI) {//第三象限
           lb.center = CGPointMake(self.frame.size.width/2+floaty-25,self.frame.size.height/2+floatx-12);
        }
        if (currentAngel>=M_PI&&currentAngel<M_PI*3/2) {//第二象限
           lb.center = CGPointMake(self.frame.size.width/2+floaty-25,self.frame.size.height/2+floatx-12);
        }
        if (currentAngel>=M_PI*3/2&&currentAngel<M_PI*2) {//第一象限
           lb.center = CGPointMake(self.frame.size.width/2+floaty+25,self.frame.size.height/2+floatx-12);
        }
        lb1.frame  = CGRectMake(self.frame.size.width/2, self.frame.size.height/2, 10, 10);
        lb1.center = CGPointMake(self.frame.size.width/2+floaty1,self.frame.size.height/2+floatx1);
    }];
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,2);//线宽度
    CGContextSetStrokeColorWithColor(context,self.fillColor.CGColor);
    
    CGContextMoveToPoint(context, self.frame.size.width/2+floaty1,self.frame.size.height/2+floatx1);//起点
    CGContextAddLineToPoint(context, self.frame.size.width/2+floaty,self.frame.size.height/2+floatx);
    if (currentAngel>=0&&currentAngel<M_PI/2) {//第四象限
        CGContextAddLineToPoint(context, self.frame.size.width/2+floaty+50,self.frame.size.height/2+floatx);
    }
    if (currentAngel>=M_PI/2&&currentAngel<M_PI) {//第三象限
        CGContextAddLineToPoint(context, self.frame.size.width/2+floaty-50,self.frame.size.height/2+floatx);
    }
    if (currentAngel>=M_PI&&currentAngel<M_PI*3/2) {//第二象限
        CGContextAddLineToPoint(context, self.frame.size.width/2+floaty-50,self.frame.size.height/2+floatx);
    }
    if (currentAngel>=M_PI*3/2&&currentAngel<M_PI*2) {//第一象限
        CGContextAddLineToPoint(context, self.frame.size.width/2+floaty+50,self.frame.size.height/2+floatx);
    }
        CGContextStrokePath(context);
    
}
-(void)animationFinished{


}
@end
