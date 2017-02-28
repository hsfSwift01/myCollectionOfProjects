//
//  AppDelegate.m
//  Data
//
//  Created by hipiao on 16/8/27.
//  Copyright © 2016年 James. All rights reserved.
//

#import "AppDelegate.h"


#import "DataHisTogramViewController.h"
#import "DataBrokenViewController.h"
#import "DataPieViewController.h"

#import "WhaterProgressViewController.h"
@interface AppDelegate ()<UITabBarDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    DataBrokenViewController * dataLine = [[DataBrokenViewController alloc]init];
    dataLine.tabBarItem.title=@"折线图";
    dataLine.tabBarItem.image=[UIImage imageNamed:@"imBroke.png"];
    DataHisTogramViewController * dataHis = [[DataHisTogramViewController alloc]init];
    dataHis.tabBarItem.title=@"柱状图";
    dataHis.tabBarItem.image=[UIImage imageNamed:@"imBroke.png"];
    DataPieViewController * dataPie = [[DataPieViewController alloc]init];
    dataPie.tabBarItem.title=@"饼状图";
    dataPie.tabBarItem.image=[UIImage imageNamed:@"imBroke.png"];
    
    
    WhaterProgressViewController * data = [[WhaterProgressViewController alloc]init];
    data.tabBarItem.title=@"水波图";
    data.tabBarItem.image=[UIImage imageNamed:@"imBroke.png"];
    
    
    
    UITabBarController * tabbar = [[UITabBarController alloc]init];
    tabbar.viewControllers=@[dataLine,dataHis,dataPie,data];
    
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:tabbar];
    [nav.navigationBar setBackgroundColor:[UIColor greenColor]];
    nav.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    nav.navigationBar.tintColor=[UIColor whiteColor];
    nav.navigationBar.barStyle=UIBarStyleBlack;

    
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [self.window setBackgroundColor:[UIColor whiteColor]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController {
    
    
    
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
