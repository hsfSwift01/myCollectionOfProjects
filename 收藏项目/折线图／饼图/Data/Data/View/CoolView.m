//
//  CoolView.m
//  Data
//
//  Created by hipiao on 16/9/22.
//  Copyright © 2016年 James. All rights reserved.
//

#import "CoolView.h"

@implementation CoolView

- (id)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if(self) {
        
        
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    [self setingrateAnno];
}
//倒计时
-(void)setingrateAnno
{
    __block int timeout = 0; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),0.05*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout == 1)
        {
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self addDataToArr:10];
            });
        }
    });
    dispatch_resume(_timer);
    
    
    CGFloat wi = 30;
    CGContextRef contextData1 = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(contextData1,[UIColor redColor].CGColor);//设置颜色
    CGFloat lengthsData1[] = {4,0};//先画4个点再画2个点
    CGContextSetLineDash(contextData1,0, lengthsData1,2);//代表虚线
    CGContextSetLineWidth(contextData1, 2.0);
                
                
    
    CGContextMoveToPoint(contextData1, self.frame.origin.x+wi*0, 100);//起始点
    
    CGContextAddCurveToPoint(contextData1, self.frame.origin.x+wi/3+wi*0, 300,self.frame.origin.x+wi/3*2+wi*0,0,self.frame.origin.x+wi,100);//控制点1  控制点2  数据点
    
    CGContextAddCurveToPoint(contextData1, self.frame.origin.x+wi/3+wi*1, 300,self.frame.origin.x+wi/3*2+wi*1,0,self.frame.origin.x+wi+wi*1,100);//控制点1  控制点2  数据点
    
    CGContextAddCurveToPoint(contextData1, self.frame.origin.x+wi/3+wi*2, 300,self.frame.origin.x+wi/3*2+wi*2,0,self.frame.origin.x+wi+wi*2,100);//控制点1  控制点2  数据点
    
    CGContextAddCurveToPoint(contextData1, self.frame.origin.x+wi/3+wi*3, 300,self.frame.origin.x+wi/3*2+wi*3,0,self.frame.origin.x+wi+wi*3,100);//控制点1  控制点2  数据点
    
    CGContextAddCurveToPoint(contextData1, self.frame.origin.x+wi/3+wi*4, 300,self.frame.origin.x+wi/3*2+wi*4,0,self.frame.origin.x+wi+wi*4,100);//控制点1  控制点2  数据点
    
    CGContextAddCurveToPoint(contextData1, self.frame.origin.x+wi/3+wi*5, 300,self.frame.origin.x+wi/3*2+wi*5,0,self.frame.origin.x+wi+wi*5,100);//控制点1  控制点2  数据点
    
    CGContextAddCurveToPoint(contextData1, self.frame.origin.x+wi/3+wi*6, 300,self.frame.origin.x+wi/3*2+wi*6,0,self.frame.origin.x+wi+wi*6,100);//控制点1  控制点2  数据点

    CGContextAddCurveToPoint(contextData1, self.frame.origin.x+wi/3+wi*7, 300,self.frame.origin.x+wi/3*2+wi*7,0,self.frame.origin.x+wi+wi*7,100);//控制点1  控制点2  数据点
    
    CGContextAddCurveToPoint(contextData1, self.frame.origin.x+wi/3+wi*8, 300,self.frame.origin.x+wi/3*2+wi*8,0,self.frame.origin.x+wi+wi*8,100);//控制点1  控制点2  数据点
    
    CGContextAddCurveToPoint(contextData1, self.frame.origin.x+wi/3+wi*9, 300,self.frame.origin.x+wi/3*2+wi*9,0,self.frame.origin.x+wi+wi*9,100);//控制点1  控制点2  数据点

    
    CGContextStrokePath(contextData1);
    
}
- (void)addDataToArr:(CGFloat)data {

    self.frame = CGRectMake(self.frame.origin.x-data, self.frame.origin.y, self.frame.size.width + data, self.frame.size.height);
    
    plussCount++;
}





@end
