//
//  HUDViewController.m
//  LibraryTest
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 weconex. All rights reserved.
//

#import "HUDViewController.h"
#import "MBProgressHUD+NJ.h"


@interface HUDViewController()

- (IBAction)show:(id)sender;

@end

@implementation HUDViewController

- (IBAction)show:(id)sender {
    //[MBProgressHUD showMessage:@"这个测试的"];
    //[MBProgressHUD showSuccess:@"测试showSuccess"];
    //[MBProgressHUD showError:@"测试showError"];
    //usleep(500000);
    //sleep(5);
    //[MBProgressHUD hideHUD];
    // 弹框提示
//    [MBProgressHUD showMessage:@"正在拼命检查中....."];
//    
//
    [MBProgressHUD showMessage:@"正在加载数据中....."];
    
    // 几秒后消失,当前，这里可以改为网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 移除HUD
        [MBProgressHUD hideHUD];
        
        // 提醒有没有新版本
        [MBProgressHUD showError:@"没有新数据"];
    });

}
@end
