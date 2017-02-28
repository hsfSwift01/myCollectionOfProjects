//
//  SXDataSource.h
//  Wonderful
//
//  Created by dongshangxian on 15/12/21.
//  Copyright © 2015年 Sankuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXCLEntity.h"

@interface SXDataSource : NSObject

@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSMutableArray *marray;

- (SXCLEntity *)randomAColorEntity;
- (void)getDataSource;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com