//
//  FZHPopView.h
//  test
//
//  Created by 冯志浩 on 16/5/27.
//  Copyright © 2016年 FZH. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FZHPopViewDelegate <NSObject>

- (void)getTheButtonTitleWithButton:(UIButton *)button;

@end

@interface FZHPopView : UIView
/**
 *  内容视图
 */
@property (nonatomic, strong) UIView *contentView;
/**
 *  按钮高度
 */
@property (nonatomic, assign) CGFloat buttonH;
/**
 *  按钮的垂直方向的间隙
 */
@property (nonatomic, assign) CGFloat buttonMargin;
/**
 *  内容视图的位移
 */
@property (nonatomic, assign) CGFloat contentShift;
/**
 *  动画持续时间
 */
@property (nonatomic, assign) CGFloat animationTime;
/**
 * tableView的高度
 */
@property (nonatomic, assign) CGFloat tableViewH;
@property (nonatomic, weak) id <FZHPopViewDelegate> fzhPopViewDelegate ;
/**
 *  展示popView
 *
 *  @param array button的title数组
 */
- (void)showThePopViewWithArray:(NSMutableArray *)array;
/**
 *  移除popView
 */
- (void)dismissThePopView;
@end
