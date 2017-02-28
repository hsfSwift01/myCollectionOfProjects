//
//  DataPieViewController.m
//  Data
//
//  Created by hipiao on 16/8/29.
//  Copyright © 2016年 James. All rights reserved.
//

#import "DataPieViewController.h"

#import "PieDataViewController.h"
#import "PYEchartsView.h"



@interface DataPieViewController ()


@property (nonatomic, weak) IBOutlet PYEchartsView *kEchartView;

@end

@implementation DataPieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAll];
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.title=@"折线图";
    self.tabBarController.navigationItem.rightBarButtonItem=nil;
    [self createUi];
}
-(void)createUi{
    
    self.title = @"折线图";
    self.tabBarController.title=@"折线图";
    UIButton * btnRight = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [btnRight addTarget:self action:@selector(btnViewMothed) forControlEvents:UIControlEventTouchUpInside];
    [btnRight setImage:[UIImage imageNamed:@"oqj"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:btnRight];
    self.tabBarController.navigationItem.rightBarButtonItem = rightItem;
    
}
-(void)btnViewMothed{
    
    PieDataViewController * his = [[PieDataViewController alloc]init];
    [self.navigationController pushViewController:his animated:YES];
    
    
}
/**
 *  初始化
 */
- (void)initAll {
    self.title = @"饼图";
    [self showBasicPieDemo];
    [_kEchartView loadEcharts];
}

/**
 *  标准饼图
 */
- (void)showBasicPieDemo {
    NSString *basicPieJson = @"{\"title\":{\"text\":\"用户访问来源\",\"subtext\":\"纯属虚构\",\"x\":\"center\"},\"tooltip\":{\"trigger\":\"item\",\"formatter\":\"{a} <br/>{b} : {c} ({d}%)\"},\"legend\":{\"orient\":\"vertical\",\"x\":\"left\",\"data\":[\"直接访问\",\"邮件营销\",\"联盟广告\",\"视频广告\",\"搜索引擎\"]},\"calculable\":false,\"series\":[{\"name\":\"访问来源\",\"type\":\"pie\",\"radius\":\"55%\",\"center\":[\"50%\",\"60%\"],\"data\":[{\"value\":335,\"name\":\"直接访问\"},{\"value\":310,\"name\":\"邮件营销\"},{\"value\":234,\"name\":\"联盟广告\"},{\"value\":135,\"name\":\"视频广告\"},{\"value\":1548,\"name\":\"搜索引擎\"}]}]}";
    NSData *jsonData = [basicPieJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    PYOption *option = [RMMapper objectWithClass:[PYOption class] fromDictionary:jsonDic];
    [_kEchartView setOption:option];
}

@end
