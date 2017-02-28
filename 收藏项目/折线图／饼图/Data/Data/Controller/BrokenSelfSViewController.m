//
//  BrokenSelfSViewController.m
//  Data
//
//  Created by hipiao on 16/9/1.
//  Copyright © 2016年 James. All rights reserved.
//

#import "BrokenSelfSViewController.h"

#import "BrokrnSelfSView.h"

@interface BrokenSelfSViewController ()

@property (nonatomic,strong) BrokrnSelfSView * brokenView;

@end

@implementation BrokenSelfSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingView];
}
-(void)settingView{
    self.title = @"面积折线";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.brokenView = [[BrokrnSelfSView alloc]initWithFrame:self.view.bounds];
    self.brokenView.unitxArray = @[@"2",@"4",@"6",@"8",@"10",@"12"];
    self.brokenView.unityArray = @[@"0",@"10",@"20",@"30",@"40",@"50",@"60"];
    self.brokenView.pointArray = @[@"31",@"51",@"42",@"59",@"47",@"40"];
    [self.view addSubview:self.brokenView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
