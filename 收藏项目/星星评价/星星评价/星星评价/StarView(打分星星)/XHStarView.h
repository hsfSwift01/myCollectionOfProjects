//
//  XHStarView.h
//  星星评价进阶2
//
//  Created by mac on 16/11/7.
//  Copyright © 2016年 mac.gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHStarView : UIView

+ (instancetype)loadStarView;

@property (nonatomic, assign) CGFloat score;


//给外界调用
@property (nonatomic, assign) CGFloat score2;

@end
