//
//  WhaterProgress.h
//  Data
//
//  Created by hipiao on 16/8/30.
//  Copyright © 2016年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhaterProgress : UIView



@property(nonatomic, assign) int type;
@property(nonatomic, assign) int precent;
@property(nonatomic, assign) CGFloat alpha;
@property(nonatomic, strong) UIImageView * bigImg;
@property(strong, nonatomic) UIView      * leftView;
@property(nonatomic, strong) UIColor     * textColor;
@property(strong, nonatomic) UIImageView * rotateImg;
@property(strong, nonatomic) UILabel     * avgScoreLbl;
@property(strong, nonatomic) UILabel     * discriptionLbl;
@property(nonatomic,assign,getter = isEndless) BOOL endless;

+ (instancetype)cell;

- (void)addAnimateWithType:(int)type;

- (void)setPrecent:(int)precent textColor:(UIColor *)tcolor type:(int)type alpha:(CGFloat)alpha;


@end
