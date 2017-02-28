//
//  DemoVC6.m
//  WHC_AutoLayoutExample
//
//  Created by 吴海超 on 16/3/1.
//  Copyright © 2016年 吴海超. All rights reserved.
//

/*********************************************************
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit *
 *  本人其他优秀开源库：https://github.com/netyouli          *
 *********************************************************/

#import "DemoVC7.h"
#import "UIView+WHC_AutoLayout.h"

@interface DemoVC7 ()

@end

@implementation DemoVC7

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title =
    @"一行代码智能对Xib上所有控件智能横向布局";
    /**
     * WHC_AutoLayoutKit 2.0 简介
     * 开发者：吴海超(WHC)
     * 智能识别xib上所有UI控件之间约束关系
       来自动给xib上所有控件进行自动添加相
       应约束关系
     */
    
    /// 对xib上所有控件横向进行智能布局
    [self.view whc_AutoXibHorizontalLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
