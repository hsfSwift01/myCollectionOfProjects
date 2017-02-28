//
//  DataHisTogramViewController.m
//  Data
//
//  Created by hipiao on 16/8/29.
//  Copyright © 2016年 James. All rights reserved.
//

#import "DataHisTogramViewController.h"
#import "HisDataSelfViewController.h"
@interface DataHisTogramViewController ()


@property (nonatomic, weak) IBOutlet PYZoomEchartsView * kEchartView;


@end

@implementation DataHisTogramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAll];
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.title=@"折线图";
    self.tabBarController.navigationItem.rightBarButtonItem=nil;
    [self createUi];
}
#pragma mark - custom functions
- (void)initAll {
    self.title = @"柱状图";
    [self showBasicColumnDemo];
    [_kEchartView loadEcharts];
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

    HisDataSelfViewController * his = [[HisDataSelfViewController alloc]init];
    [self.navigationController pushViewController:his animated:YES];


}
/**
 *  标准柱状图
 */
- (void)showBasicColumnDemo {
    NSString *basicColumnJson = @"{\"grid\":{\"x\":30,\"x2\":45},\"title\":{\"text\":\"某地区蒸发量和降水量\",\"subtext\":\"纯属虚构\"},\"tooltip\":{\"trigger\":\"axis\"},\"legend\":{\"data\":[\"\",\"\"]},\"\":{\"show\":true,\"feature\":{\"mark\":{\"show\":true},\"dataView\":{\"show\":true,\"readOnly\":false},\"magicType\":{\"show\":true,\"type\":[\"line\",\"bar\"]},\"restore\":{\"show\":true},\"saveAsImage\":{\"show\":true}}},\"calculable\":true,\"xAxis\":[{\"type\":\"category\",\"data\":[\"1月\",\"2月\",\"3月\",\"4月\",\"5月\",\"6月\",\"7月\",\"8月\",\"9月\",\"10月\",\"11月\",\"12月\"]}],\"yAxis\":[{\"type\":\"value\"}],\"series\":[{\"name\":\"蒸发量\",\"type\":\"bar\",\"data\":[2,4.9,7,23.2,25.6,76.7,135.6,162.2,32.6,20,6.4,3.3],\"markPoint\":{\"data\":[{\"type\":\"max\",\"name\":\"最大值\"},{\"type\":\"min\",\"name\":\"最小值\"}]},\"markLine\":{\"data\":[{\"type\":\"average\",\"name\":\"平均值\"}]}},{\"name\":\"\",\"type\":\"bar\",\"data\":[2.6,5.9,9,26.4,28.7,70.7,175.6,182.2,48.7,18.8,6,2.3],\"markPoint\":{\"data\":[{\"name\":\"年最高\",\"value\":182.2,\"xAxis\":7,\"yAxis\":183,\"symbolSize\":18},{\"name\":\"年最低\",\"value\":2.3,\"xAxis\":11,\"yAxis\":3}]},\"markLine\":{\"data\":[{\"type\":\"average\",\"name\":\"平均值\"}]}}]}";
    NSData *jsonData = [basicColumnJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    PYOption * option = [RMMapper objectWithClass:[PYOption class] fromDictionary:jsonDic];
    option.calculable = false;
    [_kEchartView setOption:option];
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
