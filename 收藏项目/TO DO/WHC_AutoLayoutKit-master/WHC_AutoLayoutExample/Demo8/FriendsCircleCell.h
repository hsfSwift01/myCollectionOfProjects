//
//  FriendsCircleCell.h
//  WHC_AutoLayoutExample
//
//  Created by 吴海超 on 16/3/10.
//  Copyright © 2016年 吴海超. All rights reserved.
//

/*********************************************************
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit *
 *  本人其他优秀开源库：https://github.com/netyouli          *
 *********************************************************/

#import <UIKit/UIKit.h>
#import "FriendModel.h"
#import "UIView+WHC_AutoLayout.h"
#import "WHC_StackView.h"

@class FriendsCircleCell;

@protocol  FriendsCircleCellDelegate<NSObject>

- (void)friendsCircleCell:(FriendsCircleCell *)cell clickRow:(NSInteger)row lastCommentLabel:(UIView *)commentLabel;
- (void)friendsCircleSupperCell:(FriendsCircleCell *)cell;

@end

@class AnswerMenuView;

@protocol AnswerMenuViewDelegate <NSObject>
- (void)answerMenuView:(AnswerMenuView *)menuView isClickSupper:(BOOL)isSupper;

@end

@interface AnswerMenuView : WHC_StackView
@property (nonatomic, strong) UIButton * supperButton;
@property (nonatomic, strong) UIButton * answerButton;
@property (nonatomic, weak) id<AnswerMenuViewDelegate> delegate;

- (void)clickSupperButton:(UIButton *)sender;
- (void)clickAnswerButton:(UIButton *)sender;
@end

@interface FriendsCircleCell : UITableViewCell
@property (nonatomic , weak) id <FriendsCircleCellDelegate> delegate;
@property (nonatomic , assign)NSInteger row;
@property (nonatomic , strong)UITableView * tableView;
- (void)setFriendModel:(FriendModel *)friendModel;
@end
