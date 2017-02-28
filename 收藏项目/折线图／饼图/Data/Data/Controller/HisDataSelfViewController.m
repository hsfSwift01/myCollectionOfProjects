//
//  HisDataSelfViewController.m
//  Data
//
//  Created by hipiao on 16/9/1.
//  Copyright © 2016年 James. All rights reserved.
//

#import "HisDataSelfViewController.h"
#import "BirChartView.h"
@interface HisDataSelfViewController ()


@property (nonatomic,strong) BirChartView * birchartView;
@end

@implementation HisDataSelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self settingView];
}
-(void)settingView{
    self.title = @"BAR CHART";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.birchartView = [[BirChartView alloc]initWithFrame:self.view.bounds];
    self.birchartView.unitxArray = @[@"2",@"4",@"6",@"8",@"10",@"12"];
    self.birchartView.unityArray = @[@"0",@"10",@"20",@"30",@"40",@"50",@"60"];
    self.birchartView.pointArray = @[@"31",@"51",@"42",@"59",@"47",@"40"];
    [self.view addSubview:self.birchartView];
    
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
