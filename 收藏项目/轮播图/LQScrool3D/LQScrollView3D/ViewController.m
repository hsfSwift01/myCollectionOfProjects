//
//  ViewController.m
//  LQScrollView3D
//
//  Created by zhengliqiang on 16/12/7.
//  Copyright © 2016年 zhengliqiang. All rights reserved.
//

#import "ViewController.h"
#import "LQScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        //图片数组 目前只支持五张图片
        //图片我没放demo里 因为太大了 请自己放图片
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"001",@"002",@"003",@"004",@"005", nil];
    LQScrollView * lq = [[LQScrollView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300) imageArray:arr];
    [self.view addSubview:lq];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
