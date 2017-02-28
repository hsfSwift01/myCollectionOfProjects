//
//  XHStarView.m
//  星星评价进阶2
//
//  Created by mac on 16/11/7.
//  Copyright © 2016年 mac.gu. All rights reserved.
//

#import "XHStarView.h"
#import "UIView+Extension.h"
@interface XHStarView ()

@property (weak, nonatomic) IBOutlet UIImageView *starOne;
@property (weak, nonatomic) IBOutlet UIImageView *starTwo;
@property (weak, nonatomic) IBOutlet UIImageView *starThree;
@property (weak, nonatomic) IBOutlet UIImageView *starFour;
@property (weak, nonatomic) IBOutlet UIImageView *starFive;

@end

//判断是否添加星星
@implementation XHStarView{
    BOOL _isAddStar;
}

+ (instancetype)loadStarView{
    UINib *nib = [UINib nibWithNibName:@"XHStarView" bundle:nil];
    XHStarView *starView = [[nib instantiateWithOwner:nil options:nil]lastObject];
    return starView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if((point.x > self.starOne.x && point.x < (self.starFive.x + self.starFive.width))&&(point.y > self.starOne.y && point.y< self.height)){
        _isAddStar = YES;
        
    }else{
        _isAddStar = NO;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(_isAddStar){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        [self setStarForegroundViewWithPoint:point];

    }

    return;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(_isAddStar){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        [self setStarForegroundViewWithPoint:point];
    }
    _isAddStar = NO;
    return;
}

-(void)setStarForegroundViewWithPoint:(CGPoint)point{

    self.score = 0;
    self.score = self.score + [self changeImg:point.x image:self.starOne];
    self.score = self.score + [self changeImg:point.x image:self.starTwo];
    self.score = self.score + [self changeImg:point.x image:self.starThree];
    self.score = self.score + [self changeImg:point.x image:self.starFour];
    self.score = self.score + [self changeImg:point.x image:self.starFive];
    
    //评论最少半星
    if(self.score == 0){
        self.score = 0.5;
        [self.starOne setImage:[UIImage imageNamed:@"StarSelectHeaf"]];
    }
    NSLog(@"分数 %f",self.score);
}


-(CGFloat)changeImg:(float)x image:(UIImageView*)img{
    if(x > img.x + img.width/2){
        [img setImage:[UIImage imageNamed:@"StarSelected"]];
        return 1;
    }else if(x > img.x){
        [img setImage:[UIImage imageNamed:@"StarSelectHeaf"]];
        return 0.5;
    }else{
        [img setImage:[UIImage imageNamed:@"StarUnSelect"]];
        return 0;
    }
}

- (void)setScore2:(CGFloat)score2{
    _score2 = score2;
    _score2 = self.score;
    NSLog(@"----分数 %f",self.score2);
}


@end
