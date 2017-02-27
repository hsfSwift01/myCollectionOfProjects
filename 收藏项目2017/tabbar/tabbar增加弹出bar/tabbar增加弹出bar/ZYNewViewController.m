//
//  ZYNewViewController.m
//  tabbar增加弹出bar
//
//  Created by tarena on 16/7/2.
//  Copyright © 2016年 张永强. All rights reserved.
//

#import "ZYNewViewController.h"

@interface ZYNewViewController ()

@end

@implementation ZYNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分界面";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
