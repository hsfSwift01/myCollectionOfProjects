//
//  ViewController.m
//  星星评价
//
//  Created by mac on 16/11/6.
//  Copyright © 2016年 mac.gu. All rights reserved.
//

#import "ViewController.h"
#import "XHLevelView.h"
#import "XHStarView.h"
@interface ViewController ()

@property (nonatomic, strong) XHLevelView *levelView;
@property (nonatomic, strong) XHStarView *starView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    XHStarView *starView = [XHStarView loadStarView];
    NSLog(@"控制器分数 %f",starView.score2);
    [self.view addSubview:starView];
    
}


- (IBAction)btnClick:(id)sender {
    
    XHLevelView *levelView = [[XHLevelView alloc]init];
    levelView.frame = CGRectMake(100, 400, 60, 12);
    
    
    levelView.level = self.starView.score2;
    NSLog(@"--------%f",self.starView.score2);
    [self.view addSubview:levelView];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
