//
//  CoolView.h
//  Data
//
//  Created by hipiao on 16/9/22.
//  Copyright © 2016年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoolView : UIView
{

    int MAX_X_COUNT;
    int _maxYPower;
    BOOL isup;
    int plussCount;
}
@property(nonatomic,strong) UIImageView * selfImage;
@property(nonatomic,strong) NSMutableArray * arry;
@end
