//
//  XHLevelView.m
//  星星评价
//
//  Created by mac on 16/11/6.
//  Copyright © 2016年 mac.gu. All rights reserved.
//

#import "XHLevelView.h"
#define kStartCount 5
@implementation XHLevelView

- (void)setLevel:(CGFloat)level{
    
    _level = level;
    //1.满星  把小数强转成NSInteger 成满星个数
    NSInteger fullStarCount = (NSInteger)level;
    for (NSInteger i = 0; i < fullStarCount; i++) {
        //添加满星
        [self makeStarViewWithImageName:@"full_star" startPosition:i];
        
    }
    //2.半星   if成立表示有半星
    if (level - fullStarCount) {
        
        [self makeStarViewWithImageName:@"half_star" startPosition:fullStarCount];
        //统计星星目前个数(满星+半星)
        fullStarCount ++;
    }
    //3.空星
    for (NSInteger i = fullStarCount; i < kStartCount ; i++) {
        [self makeStarViewWithImageName:@"empty_star" startPosition:i];
    }
}

#pragma mark - 根据图片创建星星
- (void)makeStarViewWithImageName:(NSString *)imageName startPosition:(NSInteger) position{
    
    //如果重新设置评分,会重新创建imageView 需要判断 若已经存在5个imageView不去创建
    UIImageView *imageView = nil;
    if (self.subviews.count == kStartCount) {
        
        imageView = self.subviews[position];
        imageView.image = [UIImage imageNamed:imageName];
        
        return;
    }
    
    imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:imageName];
    [imageView sizeToFit];
    imageView.frame = CGRectOffset(imageView.bounds, imageView.bounds.size.width*position, 0);
    [self addSubview:imageView];
    
}


@end
