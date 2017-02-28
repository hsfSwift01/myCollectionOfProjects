//
//  DataFansView.h
//  Data
//
//  Created by hipiao on 16/9/2.
//  Copyright © 2016年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataFansView : UIView
{

    double currentAngel;
    float floatx ;
    float floaty ;
    float floatx1 ;
    float floaty1 ;
}
@property (nonatomic,strong) CAShapeLayer * shapeLayer;
@property (nonatomic,assign) CGFloat beginAngle;
@property (nonatomic,assign) CGFloat endAngle;
@property (nonatomic,strong) UIColor * fillColor;


@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * data;

@property (nonatomic,strong) NSArray  * arr;


-(DataFansView *)initWithFrame:(CGRect)frame andBeginAngle:(CGFloat)beginAngle andEndAngle:(CGFloat)endAngle andFillColor:(UIColor *)fillColor name:(NSString *)name data:(NSString *)data;

@end
