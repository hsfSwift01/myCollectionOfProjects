//
//  PieDataViewController.m
//  Data
//
//  Created by hipiao on 16/9/1.
//  Copyright © 2016年 James. All rights reserved.
//

#import "PieDataViewController.h"
#import "PieDataView.h"
@interface PieDataViewController ()<UIPopoverPresentationControllerDelegate>

@property (nonatomic,strong) PieDataView * pieView;
@end

@implementation PieDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingView];
}
-(void)settingView{
    self.title = @"PIE VIEW";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray * colorArray = @[[UIColor redColor],[UIColor purpleColor],[UIColor blueColor],[UIColor brownColor],[UIColor blackColor],[UIColor magentaColor],[UIColor greenColor]];
    NSArray * dataArray = @[@"51167",@"81158",@"41158",@"71088",@"31208",@"51128",@"71088",@"31208"];
    NSArray * nameArray = @[@"哈利波特",@"谍影重重",@"星际迷航",@"冰川时代",@"星际穿越",@"国产007",@"冰川时代",@"星际穿越"];
    
    
    self.pieView = [[PieDataView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.pieView];
    [self.pieView addFansData:colorArray dataArray:dataArray narray:nameArray];
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
