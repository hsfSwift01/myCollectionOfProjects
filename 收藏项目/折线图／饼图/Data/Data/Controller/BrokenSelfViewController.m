//
//  BrokenSelfViewController.m
//  Data
//
//  Created by hipiao on 16/8/31.
//  Copyright © 2016年 James. All rights reserved.
//

#import "BrokenSelfViewController.h"
#import "BrokenSelfSViewController.h"
#import "BrokenSelfView.h"
@interface BrokenSelfViewController ()

@property (nonatomic,strong) BrokenSelfView * brokenView;
@end

@implementation BrokenSelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUi];
    
    [self settingView];
}
-(void)settingView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.brokenView = [[BrokenSelfView alloc]initWithFrame:self.view.bounds];
    self.brokenView.unitxArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    self.brokenView.unityArray = @[@"0",@"10",@"20",@"30",@"40",@"50",@"60",@"70",@"80",@"90",@"100",@"110",@"120"];
    self.brokenView.pointArray = @[@"21",@"30",@"51",@"31",@"110",@"40",@"30",@"30",@"10",@"40",@"10",@"20"];
    [self.view addSubview:self.brokenView];

}
-(void)createUi{
    self.title=@"RECT折线";
    
    UIButton * btnRight = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [btnRight addTarget:self action:@selector(btnViewMothed) forControlEvents:UIControlEventTouchUpInside];
    [btnRight setImage:[UIImage imageNamed:@"oqj"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:btnRight];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)btnViewMothed{

    BrokenSelfSViewController * viewS = [[BrokenSelfSViewController alloc]init];
    [self.navigationController pushViewController:viewS animated:YES];

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
