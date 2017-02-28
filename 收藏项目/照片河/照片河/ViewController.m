//
//  ViewController.m
//  照片河
//
//  Created by tarena on 16/6/12.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ViewController.h"
#import "PhotoView.h"
@interface ViewController ()
@property (nonatomic, strong)NSMutableArray *pvs;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.pvs = [NSMutableArray array];
    
    
    for (int i=1; i<=9; i++) {
        PhotoView *pv = [[PhotoView alloc]initWithI:i];
        //设置显示图片
        pv.iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i-1]];
        [self.view addSubview:pv];
        [self.pvs addObject:pv];
        
    }
    
    [NSTimer scheduledTimerWithTimeInterval:1.0/60 target:self selector:@selector(moveAction) userInfo:nil repeats:YES];
    
    
//    创建双击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
}
-(void)tapAction{
    
    PhotoView *pv = [self.pvs firstObject];
    
    if (pv.speed!=0) {
        float w = 375/3.0;
        float h = 667/3.0;
       
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (int i=0; i<self.pvs.count; i++) {
                [NSThread sleepForTimeInterval:.25];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    PhotoView *pv = self.pvs[i];
                    
                    [self.view bringSubviewToFront:pv];
                    
                    
                    pv.oldAlpha = pv.alpha;
                    pv.oldFrame = pv.frame;
                    pv.oldSpeed = pv.speed;
                    [UIView animateWithDuration:1 animations:^{
                        pv.frame = CGRectMake(i%3*w, i/3*h, w, h);
                        pv.iv.frame = pv.bounds;
                        pv.dv.frame = pv.bounds;
                        pv.speed = 0;
                        pv.alpha = 1;
                        pv.userInteractionEnabled = NO;
                    }];

                });
            
            }

        });
        
        
    }else{
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (int i=0; i<self.pvs.count; i++) {
                
                [NSThread sleepForTimeInterval:.25];
              
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    PhotoView *pv = self.pvs[i];
                    
                    [UIView animateWithDuration:1 animations:^{
                        pv.frame = pv.oldFrame;
                        pv.iv.frame = pv.bounds;
                        pv.dv.frame = pv.bounds;
                        pv.speed = pv.oldSpeed;
                        pv.alpha = pv.oldAlpha;
                        pv.userInteractionEnabled = YES;
                    }];
                });
            }

        });
        
        
    }
    
    
    
    
}
-(void)moveAction{
    
    for (PhotoView *pv in self.pvs) {
        pv.center = CGPointMake(pv.center.x+pv.speed, pv.center.y);
        //判断如果图片移除屏幕则重置到屏幕左侧
        if (pv.center.x>375+pv.bounds.size.width/2) {
            
            CGRect frame = pv.frame;
            frame.origin.x = -pv.bounds.size.width;
            frame.origin.y = arc4random()%(int)(667-frame.size.height);
            
            pv.frame = frame;
            
            
        }
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
