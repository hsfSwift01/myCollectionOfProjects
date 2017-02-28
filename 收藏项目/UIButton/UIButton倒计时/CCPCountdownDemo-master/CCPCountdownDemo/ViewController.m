//
//  CCPCountDownButton.h
//  CCPCountdownDemo
//
//  Created by CCP on 16/8/30.
//  Copyright © 2016年 CCP. All rights reserved.
//
#import "ViewController.h"
#import "CCPCountDownButton.h"
#import "MBProgressHUD.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CCPCountDownButton *CCPCountDownBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.CCPCountDownBtn.originalColor = [UIColor purpleColor];
    self.CCPCountDownBtn.processColor = [UIColor greenColor];
    self.CCPCountDownBtn.durationOfCountDown = 10;
    __weak typeof(self) weakSelf = self;
    self.CCPCountDownBtn.beginBlock = ^{
        [weakSelf afterSomeTime];
    };
}

- (void) afterSomeTime {
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [weakSelf.CCPCountDownBtn startCountDown];
    });
}

- (IBAction)clickBtn:(id)sender {
    
    self.CCPCountDownBtn.enabled = YES;
}



- (void)HUD {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = [NSString stringWithFormat:@"亲,%ds之内请勿重复操作",10];
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [hud hideAnimated:YES afterDelay:2.f];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

@end
