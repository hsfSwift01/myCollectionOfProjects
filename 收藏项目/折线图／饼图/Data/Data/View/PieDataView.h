//
//  PieDataView.h
//  Data
//
//  Created by hipiao on 16/9/1.
//  Copyright © 2016年 James. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "DataFansView.h"

@interface PieDataView : UIView

@property (nonatomic,strong) CAShapeLayer * shapeLayer;
@property (nonatomic,strong) DataFansView * pieView;
@property (nonatomic,assign) CGFloat currentAngel;
@property (nonatomic,strong) UIColor * fillColor;
@property (nonatomic,assign) CGFloat beginAngle;
@property (nonatomic,assign) CGFloat endAngle;
@property (nonatomic) float progressWidth;


@property(nonatomic,strong) NSArray * colorArray;//数据坐标
@property(nonatomic,strong) NSArray * dataArray;//数据坐标
@property(nonatomic,strong) NSArray * nameArray;//数据坐标



-(void)addFansData:(NSArray *)carray dataArray:(NSArray *)darray narray:(NSArray *)narray;
@end
