//
//  BrokenSelfView.m
//  Data
//
//  Created by hipiao on 16/8/31.
//  Copyright © 2016年 James. All rights reserved.
//

#import "BrokenSelfView.h"


@implementation BrokenSelfView

- (id)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if(self) {
        
        [self selfViewSetting];
        [self createUi];
        
    }
    
    return self;
}
-(void)createUi{

    self.lbTitle = [[UILabel alloc]initWithFrame:CGRectMake(50, 70, self.AllWidth, 20)];
    [self.lbTitle setTextAlignment:NSTextAlignmentCenter];
    self.lbTitle.font = [UIFont systemFontOfSize:20];
    self.lbTitle.text = @"我是标题是真的";
    [self addSubview:self.lbTitle];
    
    self.lbUnitX = [[UILabel alloc]initWithFrame:CGRectMake(self.AllWidth+60, self.AllHeight+5, 30, 20)];
    self.lbUnitX.font = [UIFont systemFontOfSize:12];
    self.lbUnitX.text = @"(/月)";
    [self addSubview:self.lbUnitX];
    
    self.lbUnitY = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 30, 20)];
    self.lbUnitY.font = [UIFont systemFontOfSize:11];
    self.lbUnitY.text = @"(万元)";
    [self addSubview:self.lbUnitY];
}
-(void)selfViewSetting{

    self.AllWidth  = self.frame.size.width-100;
    self.AllHeight = self.frame.size.height-50;
    self.backgroundColor = [UIColor whiteColor];
    self.coorColor       = [UIColor blackColor];
    self.lineColor       = [UIColor redColor];
    self.coorLineColor   = [UIColor lightGrayColor];
    self.startPointx = CGPointMake(50, self.AllHeight);//x轴
    self.endPointx   = CGPointMake(self.AllWidth+70, self.AllHeight);
    self.startPointy = CGPointMake(50, self.AllHeight);//y轴
    self.endPointy   = CGPointMake(50, 100);
    
}
- (void)drawRect:(CGRect)rect
{
    self.everHeight = [[self.unityArray objectAtIndex:1] floatValue]-[[self.unityArray objectAtIndex:0] floatValue];

    /*---------------------------坐标轴--------------------------------*/
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context,2);//线宽度
    CGContextSetStrokeColorWithColor(context,self.coorColor.CGColor);
    CGContextMoveToPoint(context,self.startPointx.x,self.startPointx.y);
    CGContextAddLineToPoint(context,self.endPointx.x,self.endPointx.y);
    CGContextMoveToPoint(context,self.startPointy.x,self.startPointy.y);
    CGContextAddLineToPoint(context,self.endPointy.x,self.endPointy.y);
    
    CGContextMoveToPoint(context, 45,110);//起点
    CGContextAddLineToPoint(context, 50, 100);
    CGContextAddLineToPoint(context, 55, 110);
    
    CGContextMoveToPoint(context, self.AllWidth+50+10, self.AllHeight-5);//起点
    CGContextAddLineToPoint(context, self.AllWidth+50+20, self.AllHeight);
    CGContextAddLineToPoint(context, self.AllWidth+50+10, self.AllHeight+5);
    
    CGContextStrokePath(context);
    CGContextClosePath(context);
    
   
    /*---------------------------虚线线条--------------------------------*/
    CGContextRef contextAxes = UIGraphicsGetCurrentContext();
    //设置线条样式
    CGContextSetLineCap(contextAxes, kCGLineCapButt);
    
    CGContextBeginPath(contextAxes);
    CGContextSetLineWidth(contextAxes,0.5);//线宽度
    CGContextSetStrokeColorWithColor(contextAxes,self.coorLineColor.CGColor);
    CGFloat lengthsAxes[] = {4,2};//先画4个点再画2个点
    CGContextSetLineDash(contextAxes,0, lengthsAxes,2);//代表虚线
    for (int i = 0; i<self.pointArray.count; i++) {
        if (i != 0) {
            CGContextMoveToPoint(contextAxes,50+i*(self.AllWidth+20)/self.pointArray.count,self.startPointx.y);
            CGContextAddLineToPoint(contextAxes,50+i*(self.AllWidth+20)/self.pointArray.count,self.AllHeight-[[self.pointArray objectAtIndex:i] intValue]*(self.AllHeight-100)/self.unityArray.count/self.everHeight);
        }
    }
    CGContextStrokePath(contextAxes);
    CGContextClosePath(contextAxes);
    
    
    CGContextRef contextAxesy = UIGraphicsGetCurrentContext();
    //设置线条样式
    CGContextSetLineCap(contextAxesy, kCGLineCapButt);
    
    CGContextBeginPath(contextAxesy);
    CGContextSetLineWidth(contextAxesy,2);//线宽度
    CGContextSetStrokeColorWithColor(contextAxesy,self.coorColor.CGColor);
    CGFloat lengthsAxesy[] = {4,2};//先画4个点再画2个点
    CGContextSetLineDash(contextAxesy,0, lengthsAxesy,2);//代表虚线
    for (int i = 0; i<self.unityArray.count; i++) {
        if (i != 0) {
            CGContextMoveToPoint(contextAxesy,50,self.AllHeight-i*(self.AllHeight-100)/self.unityArray.count);
            CGContextAddLineToPoint(contextAxesy,55,self.AllHeight-i*(self.AllHeight-100)/self.unityArray.count);
        }
    }
    CGContextStrokePath(contextAxesy);
    CGContextClosePath(contextAxesy);
    
    
    /*---------------------------坐标单位--------------------------------*/
    for (int i = 0; i<self.unitxArray.count; i++) {
        UILabel * lbX = [[UILabel alloc]initWithFrame:CGRectMake(0,0, (self.AllWidth+20)/self.pointArray.count, 20)];
        lbX.center = CGPointMake(50+i*(self.AllWidth+20)/self.pointArray.count, self.AllHeight+15);
        lbX.text = [self.unitxArray objectAtIndex:i];
        [lbX setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:lbX];
    }
    
    for (int i = 0; i<self.unityArray.count; i++) {
        UILabel * lbY = [[UILabel alloc]initWithFrame:CGRectMake(10, self.AllHeight-i*(self.AllHeight-100)/self.unityArray.count-10, 30, 20)];
        lbY.font = [UIFont systemFontOfSize:14];
        [lbY setTextAlignment:NSTextAlignmentRight];
        lbY.text = [self.unityArray objectAtIndex:i];
        [lbY sizeToFit];
        [self addSubview:lbY];
    }
    
    
    /*---------------------------数据点--------------------------------*/
    //获得处理的上下文
    CGContextRef contextData = UIGraphicsGetCurrentContext();
    
    //设置线条样式
    CGContextSetLineCap(contextData, kCGLineCapRound);
    CGContextSetLineWidth(contextData, 1.0); //设置线条粗细宽度
    CGContextSetStrokeColorWithColor(contextData,self.lineColor.CGColor);//设置框线颜色
    
    CGContextSetFillColorWithColor(contextData, self.lineColor.CGColor);//设置填充颜色
    CGFloat lengthsData[] = {1,0};//先画4个点再画2个点
    CGContextSetLineDash(contextData,2, lengthsData,2);//代表虚线
    //开始一个起始路径
    CGContextBeginPath(contextData);
    CGContextMoveToPoint(contextData, 50, self.AllHeight-[[self.pointArray objectAtIndex:0] intValue]*(self.AllHeight-100)/self.unityArray.count/self.everHeight);//起点
    for (int i = 0; i<self.pointArray.count; i++) {
        if (i !=0) {
             CGContextAddLineToPoint(contextData, 50+i*(self.AllWidth+20)/self.pointArray.count, self.AllHeight-[[self.pointArray objectAtIndex:i] intValue]*(self.AllHeight-100)/self.unityArray.count/self.everHeight);
        }
    }
//        CGContextDrawPath(contextData, kCGPathFillStroke);//进行填充
    CGContextStrokePath(contextData);
    CGContextClosePath(contextData);
    
    
    for (int i = 0; i<self.pointArray.count; i++) {
        UILabel * lbData = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
        lbData.center = CGPointMake( 50+i*(self.AllWidth+20)/self.pointArray.count, self.AllHeight-[[self.pointArray objectAtIndex:i] intValue]*(self.AllHeight-100)/self.unityArray.count/self.everHeight);
        lbData.font = [UIFont systemFontOfSize:14];
        [lbData setTextAlignment:NSTextAlignmentRight];
        lbData.text = [self.pointArray objectAtIndex:i];
        lbData.backgroundColor = self.lineColor;
        [lbData sizeToFit];
        [self addSubview:lbData];
    }
    
    
    
    /*---------------------------平均值--------------------------------*/
    CGContextRef contextAverage = UIGraphicsGetCurrentContext();
    //设置线条样式
    CGContextSetLineCap(contextAverage, kCGLineCapButt);
    
    CGContextBeginPath(contextAverage);
    CGContextSetLineWidth(contextAverage,1);//线宽度
    CGContextSetStrokeColorWithColor(contextAverage,[UIColor redColor].CGColor);
    CGFloat lengthsAverage[] = {4,2};//先画4个点再画2个点
    CGContextSetLineDash(contextAverage,0, lengthsAverage,2);//代表虚线

    float average = 0.0;
    for (int i = 0; i<self.pointArray.count; i++) {
        average = average +[[self.pointArray objectAtIndex:i] intValue];
    }
    float avy = self.AllHeight-average/self.pointArray.count*(self.AllHeight-100)/self.unityArray.count/self.everHeight;
    CGContextMoveToPoint(contextAverage,50,avy);
    CGContextAddLineToPoint(contextAverage,(50+self.AllWidth+20),avy);

    CGContextMoveToPoint(contextAverage, (50+self.AllWidth+10),avy-5);//起点
    CGContextAddLineToPoint(contextAverage,(50+self.AllWidth+20),avy);
    CGContextAddLineToPoint(contextAverage, (50+self.AllWidth+10),avy+5);

    dispatch_async(dispatch_get_main_queue(), ^{
    });
    
    CGContextStrokePath(contextAverage);
    CGContextClosePath(contextAverage);
    
    UILabel * lbAverage = [[UILabel alloc]initWithFrame:CGRectMake(self.AllWidth+20, avy-30, 50, 20)];
    lbAverage.font = [UIFont systemFontOfSize:14];
    lbAverage.text = [NSString stringWithFormat:@"%.2f",average/self.pointArray.count];
    [self addSubview:lbAverage];
}
-(void)drawCurve:(CGContextRef)context
{//画曲线  比赛尔曲线
    
    CGContextRef contextData1 = UIGraphicsGetCurrentContext();
    
    
    CGContextSetRGBStrokeColor(contextData1, 255, 100, 100, 1);
    CGContextMoveToPoint(contextData1, 150, 250);//起始点
    CGContextSetLineWidth(contextData1, 5.0);
    CGContextAddCurveToPoint(contextData1, 100, 100, 150, 200, 150, 450);
    CGContextAddQuadCurveToPoint(contextData1, 150, 100, 300, 400);
    CGContextStrokePath(contextData1);
}
@end
