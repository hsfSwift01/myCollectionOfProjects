//
//  ZYPathButton.m
//  ZYPathButton
//
//  Created by tang dixi on 30/7/14.
//  Copyright (c) 2014 Tangdxi. All rights reserved.
//

#import "ZYPathButton.h"

@interface ZYPathButton ()<ZYPathItemButtonDelegate>

#pragma mark - Private Property

@property (strong, nonatomic) NSMutableArray *itemButtonImages;
@property (strong, nonatomic) NSMutableArray *itemButtonHighlightedImages;

@property (strong, nonatomic) UIImage *centerImage;
@property (strong, nonatomic) UIImage *centerHighlightedImage;

@property (assign, nonatomic) CGSize bloomSize;
@property (assign, nonatomic) CGSize foldedSize;

@property (assign, nonatomic) CGPoint folZYenter;
@property (assign, nonatomic) CGPoint bloomCenter;
@property (assign, nonatomic) CGPoint expanZYenter;
@property (assign, nonatomic) CGPoint pathCenterButtonBloomCenter;

@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIButton *pathCenterButton;
@property (strong, nonatomic) NSMutableArray *itemButtons;

@property (assign, nonatomic) SystemSoundID foldSound;
@property (assign, nonatomic) SystemSoundID bloomSound;
@property (assign, nonatomic) SystemSoundID selectedSound;

@property (assign, nonatomic, getter = isBloom) BOOL bloom;

@end

@implementation ZYPathButton

#pragma mark - Initialization

- (instancetype)initWithCenterImage:(UIImage *)centerImage
                   highlightedImage:(UIImage *)centerHighlightedImage {
    return [self initWithButtonFrame:CGRectZero
                         centerImage:centerImage
                      highlightedImage:centerHighlightedImage];
}

- (instancetype)initWithButtonFrame:(CGRect)centerButtonFrame
                        centerImage:(UIImage *)centerImage
                   highlightedImage:(UIImage *)centerHighlightedImage {
    
    if (self = [super init]) {
        
        // Configure center and high light center image
        //
        self.centerImage = centerImage;
        self.centerHighlightedImage = centerHighlightedImage;
        
        // Init button and image array
        //
        self.itemButtonImages = [[NSMutableArray alloc]init];
        self.itemButtonHighlightedImages = [[NSMutableArray alloc]init];
        self.itemButtons = [[NSMutableArray alloc]init];
        
        // Configure views layout
        //
        if (centerButtonFrame.size.width == 0 && centerButtonFrame.size.height == 0) {
            [self configureViewsLayoutWithButtonSize:self.centerImage.size];
        }
        else {
            [self configureViewsLayoutWithButtonSize:centerButtonFrame.size];
            self.ZYButtonCenter = centerButtonFrame.origin;
        }
        
        // Configure the bloom direction
        //
        _bloomDirection = kZYPathButtonBloomDirectionTop;
        
        // Configure sounds
        //
        _bloomSoundPath = [[NSBundle bundleForClass:[self class]]pathForResource:@"bloom" ofType:@"caf"];
        _foldSoundPath = [[NSBundle bundleForClass:[self class]]pathForResource:@"fold" ofType:@"caf"];
        _itemSoundPath = [[NSBundle bundleForClass:[self class]]pathForResource:@"selected" ofType:@"caf"];

        _allowSounds = YES;
        
        _bottomViewColor = [UIColor blackColor];
        
        _allowSubItemRotation = YES;
        
        _basicDuration = 0.3f;
        
    }
    return self;
}

- (void)configureViewsLayoutWithButtonSize:(CGSize)centerButtonSize {
    // Init some property only once
    //
    self.foldedSize = centerButtonSize;
    self.bloomSize = [UIScreen mainScreen].bounds.size;
    
    self.bloom = NO;
    self.bloomRadius = 105.0f;
    self.bloomAngel = 120.0f;
    
    // Configure the view's center, it will change after the frame folded or bloomed
    //
    self.folZYenter = CGPointMake(self.bloomSize.width / 2, self.bloomSize.height - 25.5f);
    self.bloomCenter = CGPointMake(self.bloomSize.width / 2, self.bloomSize.height / 2);
    
    // Configure the ZYPathButton's origin frame
    //
    self.frame = CGRectMake(0, 0, self.foldedSize.width, self.foldedSize.height);
    
    // Default set the folZYenter as the ZYPathButton's center
    //
    self.center = self.folZYenter;
    
    // Configure center button
    //
    _pathCenterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.centerImage.size.width, self.centerImage.size.height)];
    [_pathCenterButton setImage:self.centerImage forState:UIControlStateNormal];
    [_pathCenterButton setImage:self.centerHighlightedImage forState:UIControlStateHighlighted];
    [_pathCenterButton addTarget:self action:@selector(centerButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    _pathCenterButton.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self addSubview:_pathCenterButton];
    
    // Configure bottom view
    //
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bloomSize.width * 2, self.bloomSize.height * 2)];
    _bottomView.backgroundColor = self.bottomViewColor;
    _bottomView.alpha = 0.0f;
    
}

#pragma mark - Configure Bottom View Color

- (void)setBottomViewColor:(UIColor *)bottomViewColor {
    
    if (bottomViewColor) {
        _bottomView.backgroundColor = bottomViewColor;
    }
    _bottomViewColor = bottomViewColor;
    
}

#pragma mark - Configure Button Sound
//
//- (void)setBloomSoundPath:(NSString *)bloomSoundPath {
//    
//    _bloomSoundPath = bloomSoundPath;
//    
//    [self configureSounds];
//    
//}
//
//- (void)setFoldSoundPath:(NSString *)foldSoundPath {
//    
//    _foldSoundPath = foldSoundPath;
//    
//    [self configureSounds];
//    
//}
//
//- (void)setItemSoundPath:(NSString *)itemSoundPath {
//    
//    _itemSoundPath = itemSoundPath;
//    
//    [self configureSounds];
//    
//}

//- (void)configureSounds {
//    
//    // Configure bloom sound
//    //
//    NSURL *bloomSoundURL = [NSURL fileURLWithPath:self.bloomSoundPath];
//
//    // Configure fold sound
//    //
//    NSURL *foldSoundURL = [NSURL fileURLWithPath:self.foldSoundPath];
//    
//    // Configure selected sound
//    //
//    NSURL *selectedSoundURL = [NSURL fileURLWithPath:self.itemSoundPath];
//    
//    if (self.allowSounds) {
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)bloomSoundURL, &_bloomSound);
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)foldSoundURL, &_foldSound);
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)selectedSoundURL, &_selectedSound);
//    }
//    else {
//        AudioServicesDisposeSystemSoundID(_bloomSound);
//        AudioServicesDisposeSystemSoundID(_foldSound);
//        AudioServicesDisposeSystemSoundID(_selectedSound);
//    }
//}

#pragma mark - Configure Center Button Images

- (void)setCenterImage:(UIImage *)centerImage {
    
    if (!centerImage) {
        NSLog(@"Load center image failed ... ");
        return ;
    }
    _centerImage = centerImage;
}

- (void)setCenterHighlightedImage:(UIImage *)highlightedImage {
    
    if (!highlightedImage) {
        NSLog(@"Load highted image failed ... ");
        return ;
    }
    _centerHighlightedImage = highlightedImage;
}

#pragma mark - Configure Button's Center

- (void)setZYButtonCenter:(CGPoint)ZYButtonCenter {
    
    _ZYButtonCenter = ZYButtonCenter;
    
    // reset the ZYPathButton's center
    //
    self.center = ZYButtonCenter;
}

#pragma mark - Configure Expand Center Point

- (void)setPathCenterButtonBloomCenter:(CGPoint)centerButtonBloomCenter {
    
    // Just set the bloom center once
    //
    if (_pathCenterButtonBloomCenter.x == 0) {
        _pathCenterButtonBloomCenter = centerButtonBloomCenter;
    }
    return ;
}

- (void)setAllowSounds:(BOOL)soundsEnable {
    _allowSounds = soundsEnable;
    
//    [self configureSounds];
}

#pragma mark - Expand Status

- (BOOL)isBloom {
    return _bloom;
}

#pragma mark - Center Button Delegate

- (void)centerButtonTapped {
    self.isBloom? [self pathCenterButtonFold] : [self pathCenterButtonBloom];
}

#pragma mark - Caculate The Item's End Point

- (CGPoint)createEndPointWithRadius:(CGFloat)itemExpandRadius
                           andAngel:(CGFloat)angel {
    switch (self.bloomDirection) {
            
        case kZYPathButtonBloomDirectionTop:
            
            return CGPointMake(self.pathCenterButtonBloomCenter.x + cosf((angel + 1) * M_PI) * itemExpandRadius,
                               self.pathCenterButtonBloomCenter.y + sinf((angel + 1) * M_PI) * itemExpandRadius);
        case kZYPathButtonBloomDirectionBottomLeft:
            
            return CGPointMake(self.pathCenterButtonBloomCenter.x + cosf((angel + 0.25) * M_PI) * itemExpandRadius,
                               self.pathCenterButtonBloomCenter.y + sinf((angel + 0.25) * M_PI) * itemExpandRadius);
            
        case kZYPathButtonBloomDirectionLeft:
            
            return CGPointMake(self.pathCenterButtonBloomCenter.x + cosf((angel + 0.5) * M_PI) * itemExpandRadius,
                               self.pathCenterButtonBloomCenter.y + sinf((angel + 0.5) * M_PI) * itemExpandRadius);
            
        case kZYPathButtonBloomDirectionTopLeft:
            
            return CGPointMake(self.pathCenterButtonBloomCenter.x + cosf((angel + 0.75) * M_PI) * itemExpandRadius,
                               self.pathCenterButtonBloomCenter.y + sinf((angel + 0.75) * M_PI) * itemExpandRadius);
            
        case kZYPathButtonBloomDirectionBottom:
            
            return CGPointMake(self.pathCenterButtonBloomCenter.x + cosf(angel * M_PI) * itemExpandRadius,
                               self.pathCenterButtonBloomCenter.y + sinf(angel * M_PI) * itemExpandRadius);
            
        case kZYPathButtonBloomDirectionBottomRight:
            
            return CGPointMake(self.pathCenterButtonBloomCenter.x + cosf((angel + 1.75) * M_PI) * itemExpandRadius,
                               self.pathCenterButtonBloomCenter.y + sinf((angel + 1.75) * M_PI) * itemExpandRadius);
            
        case kZYPathButtonBloomDirectionRight:
            
            return CGPointMake(self.pathCenterButtonBloomCenter.x + cosf((angel + 1.5) * M_PI) * itemExpandRadius,
                               self.pathCenterButtonBloomCenter.y + sinf((angel + 1.5) * M_PI) * itemExpandRadius);
            
        case kZYPathButtonBloomDirectionTopRight:
            
            return CGPointMake(self.pathCenterButtonBloomCenter.x + cosf((angel + 1.25) * M_PI) * itemExpandRadius,
                               self.pathCenterButtonBloomCenter.y + sinf((angel + 1.25) * M_PI) * itemExpandRadius);
        
        default:
            
            NSAssert(self.bloomDirection, @"ZYPathButtonError: An error occur when you configuring the bloom direction");
            return CGPointZero;
            
    }
}


#pragma mark - Center Button Fold

- (void)pathCenterButtonFold {
    
    // ZYPathButton Delegate
    //
    if ([_delegate respondsToSelector:@selector(willDismissZYPathButtonItems:)]) {
        [_delegate willDismissZYPathButtonItems:self];
    }
    
    // Play fold sound
    //
    if (self.allowSounds) {
        AudioServicesPlaySystemSound(self.foldSound);
    }
    
    CGFloat itemGapAngel = self.bloomAngel / (self.itemButtons.count - 1) ;
    CGFloat currentAngel = (180.0f - self. bloomAngel)/2.0f;
    
    // Load item buttons from array
    //
    for (int i = 0; i < self.itemButtons.count; i++) {
        
        ZYPathItemButton *itemButton = self.itemButtons[i];
        
        CGPoint farPoint = [self createEndPointWithRadius:self.bloomRadius + 5.0f andAngel:currentAngel/180.0f];
        
        CAAnimationGroup *foldAnimation = [self foldAnimationFromPoint:itemButton.center withFarPoint:farPoint];
        
        [itemButton.layer addAnimation:foldAnimation forKey:@"foldAnimation"];
        itemButton.center = self.pathCenterButtonBloomCenter;
        
        currentAngel += itemGapAngel;
        
    }
    
    [self bringSubviewToFront:self.pathCenterButton];
    
    // Resize the ZYPathButton's frame to the foled frame and remove the item buttons
    //
    [self resizeToFoldedFrame];
    
    // ZYPathButton Delegate
    //
    if ([_delegate respondsToSelector:@selector(didDismissZYPathButtonItems:)]) {
        [_delegate didDismissZYPathButtonItems:self];
    }
    
}

- (void)resizeToFoldedFrame {
    
    if (self.allowCenterButtonRotation) {
        [UIView animateWithDuration:0.0618f * 3
                              delay:0.0618f * 2
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _pathCenterButton.transform = CGAffineTransformMakeRotation(0);
                         }
                         completion:nil];
    }
    
    [UIView animateWithDuration:0.1f
                          delay:self.basicDuration + 0.05f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         _bottomView.alpha = 0.0f;
                     }
                     completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // Remove the button items from the superview
        //
        [self.itemButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        self.frame = CGRectMake(0, 0, self.foldedSize.width, self.foldedSize.height);
        self.center = _ZYButtonCenter;
        
        self.pathCenterButton.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        [self.bottomView removeFromSuperview];
    });
    
    _bloom = NO;
}

- (CAAnimationGroup *)foldAnimationFromPoint:(CGPoint)endPoint
                                withFarPoint:(CGPoint)farPoint {
    // 1.Configure rotation animation
    //
    CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.values = @[@(0), @(M_PI), @(M_PI * 2)];
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotationAnimation.duration = self.basicDuration + 0.05f;
    
    // 2.Configure moving animation
    //
    CAKeyframeAnimation *movingAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // Create moving path
    //
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, endPoint.x, endPoint.y);
    CGPathAddLineToPoint(path, NULL, farPoint.x, farPoint.y);
    CGPathAddLineToPoint(path, NULL, self.pathCenterButtonBloomCenter.x, self.pathCenterButtonBloomCenter.y);
    
    movingAnimation.keyTimes = @[@(0.0f), @(0.75), @(1.0)];
    
    movingAnimation.path = path;
    movingAnimation.duration = self.basicDuration + 0.05f;
    CGPathRelease(path);
    
    // 3.Merge animation together
    //
    CAAnimationGroup *animations = [CAAnimationGroup animation];
    animations.animations = (self.allowSubItemRotation? @[rotationAnimation, movingAnimation] : @[movingAnimation]);
    animations.duration = self.basicDuration + 0.05f;
    
    return animations;
}

#pragma mark - Center Button Bloom

- (void)setBloomDirection:(kZYPathButtonBloomDirection)bloomDirection {
    
    _bloomDirection = bloomDirection;
    
    if (bloomDirection == kZYPathButtonBloomDirectionBottomLeft |
        bloomDirection == kZYPathButtonBloomDirectionBottomRight |
        bloomDirection == kZYPathButtonBloomDirectionTopLeft |
        bloomDirection == kZYPathButtonBloomDirectionTopRight) {
        
        _bloomAngel = 90.0f;
        
    }
    
}

- (void)pathCenterButtonBloom {
    
    // ZYPathButton Delegate
    //
    if ([_delegate respondsToSelector:@selector(willPresentZYPathButtonItems:)]) {
        [_delegate willPresentZYPathButtonItems:self];
    }
    
    // Play bloom sound
    //
    if (self.allowSounds) {
        AudioServicesPlaySystemSound(self.bloomSound);
    }
    
    // Configure center button bloom
    //
    // 1. Store the current center point to centerButtonBloomCenter
    //
    self.pathCenterButtonBloomCenter = self.center;
    
    // 2. Resize the ZYPathButton's frame
    //
    self.frame = CGRectMake(0, 0, self.bloomSize.width, self.bloomSize.height);
    self.center = CGPointMake(self.bloomSize.width / 2, self.bloomSize.height / 2);
    
    [self insertSubview:self.bottomView belowSubview:self.pathCenterButton];
    
    // 3. Excute the bottom view alpha animation
    //
    [UIView animateWithDuration:0.0618f * 3
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _bottomView.alpha = 0.618f;
                     }
                     completion:nil];
    
    // 4. Excute the center button rotation animation
    //
    if (self.allowCenterButtonRotation) {
        [UIView animateWithDuration:0.1575f
                         animations:^{
                             _pathCenterButton.transform = CGAffineTransformMakeRotation(-0.75f * M_PI);
                         }];
    }
    
    self.pathCenterButton.center = self.pathCenterButtonBloomCenter;
    
    // 5. Excute the bloom animation
    //
    CGFloat itemGapAngel = self.bloomAngel / (self.itemButtons.count - 1) ;
    CGFloat currentAngel = (180.0f - self. bloomAngel)/2.0f;
    
    for (int i = 0; i < self.itemButtons.count; i++) {
        
        ZYPathItemButton *pathItemButton = self.itemButtons[i];
        
        pathItemButton.delegate = self;
        pathItemButton.index = i;
        pathItemButton.transform = CGAffineTransformMakeTranslation(1, 1);
        pathItemButton.alpha = 1.0f;
        
        // 1. Add pathItem button to the view
        //
        
        pathItemButton.center = self.pathCenterButtonBloomCenter;
        
        [self insertSubview:pathItemButton belowSubview:self.pathCenterButton];
        
        // 2.Excute expand animation
        //
        CGPoint endPoint = [self createEndPointWithRadius:self.bloomRadius andAngel:currentAngel/180.0f];
        CGPoint farPoint = [self createEndPointWithRadius:self.bloomRadius + 10.0f andAngel:currentAngel/180.0f];
        CGPoint nearPoint = [self createEndPointWithRadius:self.bloomRadius - 5.0f andAngel:currentAngel/180.0f];
        
        CAAnimationGroup *bloomAnimation = [self bloomAnimationWithEndPoint:endPoint
                                                                  andFarPoint:farPoint
                                                                andNearPoint:nearPoint];
        
        [pathItemButton.layer addAnimation:bloomAnimation
                                    forKey:@"bloomAnimation"];
        
        pathItemButton.center = endPoint;
        
        currentAngel += itemGapAngel;
        
    }
    
    // Configure the bloom status
    //
    _bloom = YES;
    
    // ZYPathButton Delegate
    //
    if ([_delegate respondsToSelector:@selector(didPresentZYPathButtonItems:)]) {
        [_delegate didPresentZYPathButtonItems:self];
    }
    
}

- (CAAnimationGroup *)bloomAnimationWithEndPoint:(CGPoint)endPoint
                                     andFarPoint:(CGPoint)farPoint
                                    andNearPoint:(CGPoint)nearPoint {
    
    // 1.Configure rotation animation
    //
    CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.values = @[@(0.0), @(- M_PI), @(- M_PI * 1.5), @(- M_PI * 2)];
    rotationAnimation.duration = self.basicDuration;
    rotationAnimation.keyTimes = @[@(0.0), @(0.3), @(0.6), @(1.0)];
    
    // 2.Configure moving animation
    //
    CAKeyframeAnimation *movingAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // Create moving path
    //
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.pathCenterButtonBloomCenter.x, self.pathCenterButtonBloomCenter.y);
    CGPathAddLineToPoint(path, NULL, farPoint.x, farPoint.y);
    CGPathAddLineToPoint(path, NULL, nearPoint.x, nearPoint.y);
    CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    
    movingAnimation.path = path;
    movingAnimation.keyTimes = @[@(0.0), @(0.5), @(0.7), @(1.0)];
    movingAnimation.duration = self.basicDuration;
    CGPathRelease(path);
    
    // 3.Merge two animation together
    //
    CAAnimationGroup *animations = [CAAnimationGroup animation];
    animations.animations = (self.allowSubItemRotation? @[movingAnimation, rotationAnimation] : @[movingAnimation]);
    animations.duration = self.basicDuration;
    animations.delegate = self;
    
    return animations;
}

#pragma mark - Add PathButton Item

- (void)addPathItems:(NSArray *)pathItemButtons {
    [self.itemButtons addObjectsFromArray:pathItemButtons];
}

#pragma mark - ZYPathButton Touch Event

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event {
    
    // Tap the bottom area, excute the fold animation
    //
    [self pathCenterButtonFold];
    
}

#pragma mark - ZYPathButton Item Delegate

- (void)itemButtonTapped:(ZYPathItemButton *)itemButton {
    
    if ([_delegate respondsToSelector:@selector(pathButton:clickItemButtonAtIndex:)]) {
        
        ZYPathItemButton *selectedButton = self.itemButtons[itemButton.index];
        
        // Play selected sound
        //
        if (self.allowSounds) {
            AudioServicesPlaySystemSound(self.selectedSound);
        }
        
        // Excute the explode animation when the item is seleted
        //
        [UIView animateWithDuration:0.0618f * 5
                         animations:^{
                             selectedButton.transform = CGAffineTransformMakeScale(3, 3);
                             selectedButton.alpha = 0.0f;
                         }];
        
        // Excute the dismiss animation when the item is unselected
        //
        for (int i = 0; i < self.itemButtons.count; i++) {
            if (i == selectedButton.index) {
                continue;
            }
            ZYPathItemButton *unselectedButton = self.itemButtons[i];
            [UIView animateWithDuration:0.0618f * 2
                             animations:^{
                                 unselectedButton.transform = CGAffineTransformMakeScale(0, 0);
                             }];
        }
        
        // Excute the delegate method
        //
        if ([_delegate respondsToSelector:@selector(pathButton:clickItemButtonAtIndex:)]) {
            [_delegate pathButton:self clickItemButtonAtIndex:itemButton.index];
        }
        if ([_delegate respondsToSelector:@selector(willDismissZYPathButtonItems:)]) {
            [_delegate willDismissZYPathButtonItems:self];
        }

        // Resize the ZYPathButton's frame
        //
        [self resizeToFoldedFrame];

        if ([_delegate respondsToSelector:@selector(didDismissZYPathButtonItems:)]) {
            [_delegate didDismissZYPathButtonItems:self];
        }
    }
}

#pragma mark - UIGestureRecognizer Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0) {
    return YES;
}

@end
