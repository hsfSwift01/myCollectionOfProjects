//
//  PieDataView.m
//  Data
//
//  Created by hipiao on 16/9/1.
//  Copyright © 2016年 James. All rights reserved.
//

#import "PieDataView.h"
@implementation PieDataView

- (id)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if(self) {
        
    }
    
    return self;
}
-(void)addFansData:(NSArray *)carray dataArray:(NSArray *)darray narray:(NSArray *)narray{
    
    NSMutableArray * aarray = [NSMutableArray array];
    float AllData = 0.0;
    for (int i = 0; i<darray.count; i++) {//求和
        AllData = AllData+[[darray objectAtIndex:i] floatValue];
    }
    for (int i = 0; i<darray.count; i++) {//求百分比
        CGFloat cdata;
        cdata = [[darray objectAtIndex:i] floatValue];
        [aarray addObject:[NSString stringWithFormat:@"%f",cdata/AllData]];
    }
    for (int i = 0; i<carray.count; i++) {
        if (i<carray.count-1) {
            self.pieView  = [[DataFansView alloc] initWithFrame:self.bounds
                                                  andBeginAngle:self.currentAngel
                                                    andEndAngle:self.currentAngel+[[aarray objectAtIndex:i]floatValue]*M_PI*2
                                                   andFillColor:[carray objectAtIndex:i]
                                                           name:[narray objectAtIndex:i]
                                                           data:[aarray objectAtIndex:i]];
            [self addSubview:self.pieView];
            self.currentAngel = self.currentAngel + [[aarray objectAtIndex:i]floatValue]*M_PI*2 ;
        }else{
            self.pieView  = [[DataFansView alloc] initWithFrame:self.bounds
                                                  andBeginAngle:self.currentAngel
                                                    andEndAngle:M_PI*2
                                                   andFillColor:[carray objectAtIndex:i]
                                                           name:[narray objectAtIndex:i]
                                                           data:[aarray objectAtIndex:i]];
            [self addSubview:self.pieView];
        }
    }
}
@end
