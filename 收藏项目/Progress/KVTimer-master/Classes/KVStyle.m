//
//  Created by Vlad Kochergin on 11.08.16.
//  Copyright © 2016 All rights reserved.
//


#import "KVStyle.h"

@implementation KVStyle

+ (KVStyle *)initWithFillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor lineWidth:(NSInteger)lineWidth radius:(NSInteger)radius{
    KVStyle *model = [[KVStyle alloc] init];
    if(model){
        model.fillColor = fillColor;
        model.strokeColor = strokeColor;
        model.lineWidth = lineWidth;
        model.radius = radius;
    }
    return model;
}

@end
