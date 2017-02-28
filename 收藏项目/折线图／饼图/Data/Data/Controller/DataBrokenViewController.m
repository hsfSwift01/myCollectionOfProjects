//
//  DataBrokenViewController.m
//  Data
//
//  Created by hipiao on 16/8/29.
//  Copyright © 2016年 James. All rights reserved.
//

#import "DataBrokenViewController.h"
#import "BrokenSelfViewController.h"


@interface DataBrokenViewController ()
<
   UIWebViewDelegate,
   PYEchartsViewDelegate
>


@property (nonatomic, weak) IBOutlet PYZoomEchartsView *kEchartView;


@end

@implementation DataBrokenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAll];
}
-(void)createUi{

    self.title = @"折线图";
    self.tabBarController.title=@"折线图";
    UIButton * btnRight = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btnRight addTarget:self action:@selector(btnViewMothed) forControlEvents:UIControlEventTouchUpInside];
    [btnRight setImage:[UIImage imageNamed:@"oqj"] forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:btnRight];
    self.tabBarController.navigationItem.rightBarButtonItem = rightItem;
 
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.title=@"折线图";
    self.tabBarController.navigationItem.rightBarButtonItem=nil;
    [self createUi];
}
-(void)btnViewMothed{

    BrokenSelfViewController * broken = [[BrokenSelfViewController alloc]init];
    [self.navigationController pushViewController:broken animated:YES];
}
- (void)initAll {
    
    
    [self showStandardLineDemo];
    [_kEchartView loadEcharts];
    
    [_kEchartView refreshEcharts];
}
/**
 *  标准折线图
 */
- (void)showStandardLineDemo {
    PYOption * option = [[PYOption alloc] init];
    PYTitle *title = [[PYTitle alloc] init];
    title.text = @"未来一周气温变化";
    title.subtext = @"纯属虚构";
    option.title = title;
    PYTooltip *tooltip = [[PYTooltip alloc] init];
    tooltip.trigger = @"axis";
    option.tooltip = tooltip;
    PYGrid *grid = [[PYGrid alloc] init];
    grid.x = @(40);
    grid.x2 = @(50);
    option.grid = grid;
    
    
    /*----------------------最高最低-----------------------*/
//    PYLegend *legend = [[PYLegend alloc] init];
//    legend.data = @[@"最高温度",@"最低温度"];
//    option.legend = legend;
    
    
     /*----------------------工具栏-----------------------*/
//    PYToolbox *toolbox = [[PYToolbox alloc] init];
//    toolbox.show = YES;
//    toolbox.x = @"right";
//    toolbox.y = @"top";
//    toolbox.z = @(100);
//    toolbox.feature.mark.show = YES;
//    toolbox.feature.dataView.show = YES;
//    toolbox.feature.dataView.readOnly = NO;
//    toolbox.feature.magicType.show = YES;
//    toolbox.feature.magicType.type = @[PYSeriesTypeLine, PYSeriesTypeBar];
//    toolbox.feature.restore.show = YES;
//    option.toolbox = toolbox;
    
    
    /*----------------------横纵坐标系-----------------------*/
    option.calculable = YES;
    PYAxis *xAxis = [[PYAxis  alloc] init];
    xAxis.type = @"category";
    xAxis.boundaryGap = @(NO);
    xAxis.data = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日",@"周八",@"周九",@"周十"];
    option.xAxis = [[NSMutableArray alloc] initWithObjects:xAxis, nil];
    
    PYAxis * yAxis = [[PYAxis alloc] init];
    yAxis.type = @"category";
    yAxis.axisLabel.formatter = @"{value} ℃";//单位
    yAxis.boundaryGap = @(NO);
    yAxis.data = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"];
    option.yAxis = [[NSMutableArray alloc] initWithObjects:yAxis, nil];
    
    
    /*----------------------数据1组-----------------------*/
    PYSeries *series1 = [[PYSeries alloc] init];
    series1.name = @"最高温度";
    series1.type = PYSeriesTypeLine;
    series1.data = @[@(11),@(11),@(15),@(13),@(12),@(13),@(10),@(12),@(13),@(10)];
    
    
    PYMarkPoint *markPoint = [[PYMarkPoint alloc] init];
    markPoint.data = @[@{@"type" : @"max", @"name": @"最大值"},@{@"type" : @"min", @"name": @"最小值"}];
    series1.markPoint = markPoint;
    
    
    PYMarkLine *markLine = [[PYMarkLine alloc] init];
    markLine.data = @[@{@"type" : @"average", @"name": @"平均值"}];
    series1.markLine = markLine;
    
    
    
    /*----------------------数据2组-----------------------*/
    PYSeries *series2 = [[PYSeries alloc] init];
    series2.name = @"最低温度";
    series2.type = PYSeriesTypeLine;
    series2.data = @[@(11),@(8),@(12),@(15),@(13),@(12),@(12),@(13),@(12),@(10)];
    
    
    PYMarkPoint *markPoint2 = [[PYMarkPoint alloc] init];
    markPoint2.data = @[@{@"type" : @"max", @"name": @"最大值"},@{@"type" : @"min", @"name": @"最小值"}];
    series2.markPoint = markPoint2;
    
    
    PYMarkLine *markLine2 = [[PYMarkLine alloc] init];
    markLine2.data = @[@{@"type" : @"average", @"name": @"平均值"}];
    series2.markLine = markLine2;
    

        /*----------------------数据3组-----------------------*/
    PYCartesianSeries *series11 = [[PYCartesianSeries alloc] init];
    series11.name = @"成交";
    series11.type = PYSeriesTypeLine;
    series11.smooth = YES;
    series11.itemStyle = [[PYItemStyle alloc] init];
    series11.itemStyle.normal = [[PYItemStyleProp alloc] init];
    series11.itemStyle.normal.areaStyle = [[PYAreaStyle alloc] init];
    series11.itemStyle.normal.areaStyle.type = @"default";
    series11.data = @[@(1),@(2),@(3),@(4),@(2),@(3),@(4),@(5),@(8),@(15)];
    
        /*----------------------数据4组-----------------------*/
    PYCartesianSeries *series12 = [[PYCartesianSeries alloc] init];
    series12.name = @"预购";
    series12.type = PYSeriesTypeLine;
    series12.smooth = YES;
    series12.itemStyle = [[PYItemStyle alloc] init];
    series12.itemStyle.normal = [[PYItemStyleProp alloc] init];
    series12.itemStyle.normal.areaStyle = [[PYAreaStyle alloc] init];
    series12.itemStyle.normal.areaStyle.type = @"default";
    series12.data = @[@(5),@(6),@(4),@(5),@(6),@(7),@(5),@(3),@(3),@(4)];
    
    
        /*----------------------数据5组-----------------------*/
    PYCartesianSeries *series13 = [[PYCartesianSeries alloc] init];
    series13.name = @"意向";
    series13.type = PYSeriesTypeLine;
    series13.smooth = YES;
    series13.itemStyle = [[PYItemStyle alloc] init];
    series13.itemStyle.normal = [[PYItemStyleProp alloc] init];
    series13.itemStyle.normal.areaStyle = [[PYAreaStyle alloc] init];
    series13.itemStyle.normal.areaStyle.type = @"default";
    series13.data = @[@(12),@(6),@(7),@(5),@(4),@(5),@(3),@(2),@(1),@(0)];
     option.series = [[NSMutableArray alloc] initWithObjects:series1, series2,series11,series12,series13,  nil];
    
        [_kEchartView setOption:option];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{


    NSLog(@"_!!!!_________________%@",request);
    return YES;
}
- (BOOL)echartsView:(PYEchartsView *)echartsView didReceivedLinkURL:(NSURL *)url{


        NSLog(@"_!!!!_*________________%@",url);
    return YES;
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
