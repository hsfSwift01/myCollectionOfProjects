//
//  SXColorListEntity.m
//  Wonderful
//
//  Created by dongshangxian on 15/10/30.
//  Copyright © 2015年 Sankuai. All rights reserved.
//

#import "SXCLEntity.h"

@implementation SXCLEntity

+ (instancetype)CWV:(int)value D:(NSString *)desc N:(NSString *)name
{
    SXCLEntity *entity = [[self alloc]init];
    entity.colorValue = value;
    entity.desc = desc;
    entity.methodName = name;
    return entity;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com