//
//  BirChartView.m
//  Data
//
//  Created by hipiao on 16/9/1.
//  Copyright © 2016年 James. All rights reserved.
//

#import "BirChartView.h"

@implementation BirChartView



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
        lbX.center = CGPointMake(50+i*(self.AllWidth+20)/self.pointArray.count+10, self.AllHeight+15);
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
    
    /*---------------------------坐标轴箭头--------------------------------*/
    //获得处理的上下文
    CGContextRef contextArrow = UIGraphicsGetCurrentContext();
    
    //设置线条样式
    CGContextSetLineCap(contextArrow, kCGLineCapSquare);
    CGContextSetLineWidth(contextArrow, 2.0); //设置线条粗细宽度
    CGContextSetStrokeColorWithColor(contextArrow,self.coorColor.CGColor);//设置颜色
    
    //开始一个起始路径
    CGContextBeginPath(contextArrow);
    CGContextMoveToPoint(contextArrow, 45,110);//起点
    CGContextAddLineToPoint(contextArrow, 50, 100);
    CGContextAddLineToPoint(contextArrow, 55, 110);
    
    CGContextMoveToPoint(contextArrow, self.AllWidth+50+10, self.AllHeight-5);//起点
    CGContextAddLineToPoint(contextArrow, self.AllWidth+50+20, self.AllHeight);
    CGContextAddLineToPoint(contextArrow, self.AllWidth+50+10, self.AllHeight+5);
    
    
    CGContextStrokePath(contextArrow);
    CGContextClosePath(contextArrow);
    
    
    
    
    
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
    
    /*---------------------------数据点--------------------------------*/
    
    
    for (int i = 0; i<self.pointArray.count; i++) {
        UILabel * lbData = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
        lbData.center = CGPointMake( 50+i*(self.AllWidth+20)/self.pointArray.count+10, self.AllHeight-[[self.pointArray objectAtIndex:i] intValue]*(self.AllHeight-100)/self.unityArray.count/self.everHeight-10);
        lbData.font = [UIFont systemFontOfSize:14];
        [lbData setTextAlignment:NSTextAlignmentCenter];
        lbData.text = [self.pointArray objectAtIndex:i];
        [lbData sizeToFit];
        [self addSubview:lbData];
    }
    
    CGContextRef contextFull = UIGraphicsGetCurrentContext();
    CGFloat lengthsFull[] = {4,0};//先画4个点再画2个点
    CGContextSetLineDash(contextFull,0, lengthsFull,2);//代表虚线
    CGContextSetStrokeColorWithColor(contextFull,self.lineColor.CGColor);//设置颜色
    
    for (int i = 0; i<self.pointArray.count; i++) {
            CGFloat X = (self.AllWidth+20)/self.pointArray.count;
            CGFloat floatX = 50+i*X;
            CGFloat floatY = self.AllHeight-[[self.pointArray objectAtIndex:i] intValue]*(self.AllHeight-100)/self.unityArray.count/self.everHeight;
            //开始一个起始路径
            CGContextMoveToPoint(contextFull, floatX,self.AllHeight);//起点
            CGContextAddLineToPoint(contextFull, floatX, floatY);
            CGContextAddLineToPoint(contextFull, floatX+20, floatY);
            CGContextAddLineToPoint(contextFull, floatX+20, self.AllHeight);

    }

    
    CGContextSetFillColorWithColor(contextFull, [[UIColor greenColor]colorWithAlphaComponent:0.3].CGColor);//填充颜色
    CGContextDrawPath(contextFull, kCGPathFillStroke);//进行颜色填充
    CGContextStrokePath(contextFull);
    
}


@end
