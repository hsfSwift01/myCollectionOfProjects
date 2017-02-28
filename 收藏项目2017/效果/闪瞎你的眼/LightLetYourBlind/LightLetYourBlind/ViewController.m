//
//  ViewController.m
//  LightLetYourBlind
//
//  Created by 刘俊 on 2017/2/21.
//  Copyright © 2017年 刘俊. All rights reserved.
//

#import "ViewController.h"
#import "UIView+LightLetYourBlind.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIView *test1View;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)testAction:(id)sender {
    
    self.imageView.lightRotationAngle = M_PI / 6.0;
    self.imageView.lightWidth = 30.f;
    self.imageView.lightAnimationInterval = 1.f;
    self.imageView.lightAniDirection = LightLetYourBlindAnimationDirectionRightBottom;
    self.imageView.lightAnimationNextShowInterval = 3.f;
    [self.imageView startLightAnimation];
    
    
    self.test1View.lightRotationAngle = 0.f;
    self.test1View.lightWidth = 100.f;
    self.test1View.lightAnimationInterval = .5f;
    self.test1View.lightAniDirection = LightLetYourBlindAnimationDirectionRight;
    self.test1View.lightAnimationNextShowInterval = 3.f;
    [self.test1View startLightAnimation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
