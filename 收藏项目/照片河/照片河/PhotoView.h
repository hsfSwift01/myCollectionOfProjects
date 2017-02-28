//
//  PhotoView.h
//  照片河
//
//  Created by tarena on 16/6/12.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawView.h"
typedef NS_ENUM(NSUInteger, PhotoViewStatus) {
    PhotoViewStatusNormal,
    PhotoViewStatusBig,
    PhotoViewStatusDraw,
};
@interface PhotoView : UIView
@property (nonatomic, strong)UIImageView *iv;

@property (nonatomic)PhotoViewStatus status;
@property (nonatomic, strong)DrawView *dv;
@property (nonatomic)float speed;

@property (nonatomic)CGRect oldFrame;
@property (nonatomic)float oldSpeed;
@property (nonatomic)float oldAlpha;

-(instancetype)initWithI:(int)i;
@end
