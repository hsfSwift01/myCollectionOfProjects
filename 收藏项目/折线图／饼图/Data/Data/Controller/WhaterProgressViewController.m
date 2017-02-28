//
//  WhaterProgressViewController.m
//  Data
//
//  Created by hipiao on 16/8/30.
//  Copyright © 2016年 James. All rights reserved.
//

#import "WhaterProgressViewController.h"

#import "WhaterProgress.h"

#import "CoolView.h"

@interface WhaterProgressViewController ()

@property (nonatomic,strong) WhaterProgress * whater;
@property (nonatomic,strong) WhaterProgress * whater1;
@property (nonatomic,strong) WhaterProgress * whater2;
@property (nonatomic,strong) WhaterProgress * whater3;
@end

@implementation WhaterProgressViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // ------在需要加入动画的地方
    [self.whater  addAnimateWithType:0];
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.title=@"折线图";
    self.tabBarController.navigationItem.rightBarButtonItem=nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.whater = [[WhaterProgress alloc]initWithFrame:CGRectMake(0, 100-26, 375, 120)];
    [self.whater setPrecent:79 textColor:[UIColor orangeColor] type:0 alpha:1];
    self.whater.endless = YES;
    [self.view addSubview:self.whater];
    
    WhaterProgress * whater1 = [[WhaterProgress alloc]initWithFrame:CGRectMake(0, 230-26, 375, 120)];
    [whater1 setPrecent:79 textColor:[UIColor orangeColor] type:0 alpha:1];
    whater1.endless = YES;
    [self.view addSubview:whater1];
    
    CoolView * cool = [[CoolView alloc]initWithFrame:CGRectMake(0, 380, 375,200)];
    cool.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.2];
    [self.view addSubview:cool];
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
