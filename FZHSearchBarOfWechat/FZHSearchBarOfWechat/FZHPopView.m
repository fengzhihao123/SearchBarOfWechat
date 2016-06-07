//
//  FZHPopView.m
//  test
//
//  Created by 冯志浩 on 16/5/27.
//  Copyright © 2016年 FZH. All rights reserved.
//

#import "FZHPopView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface FZHPopView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end
@implementation FZHPopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        //初始化各种起始属性
        [self initAttribute];
        [self initTabelView];
    }
    return self;
}

- (void)initTabelView{
 
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.contentShift) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:self.tableView];
}

/**
 *  初始化起始属性
 */
- (void)initAttribute{
    
    self.buttonH = SCREEN_HEIGHT * (40.0/736.0);
    self.buttonMargin = 10;
    self.contentShift = SCREEN_HEIGHT * (300.0/736.0);
    self.animationTime = 0.8;
    self.backgroundColor = [UIColor colorWithWhite:0.838 alpha:0.700];
    
    [self initSubViews];
}
/**
 *  初始化子控件
 */
- (void)initSubViews{
    
    self.contentView = [[UIView alloc]init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.contentShift);
    [self addSubview:self.contentView];
}
/**
 *  展示pop视图
 *
 *  @param array 需要显示button的title数组
 */
- (void)showThePopViewWithArray:(NSMutableArray *)array{
   
    self.dataSource = array;
    [self.tableView reloadData];
    //1.执行动画
    [UIView animateWithDuration:self.animationTime animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -(SCREEN_HEIGHT - 64));

    }];
    
}

- (void)dismissThePopView{
    
    [UIView animateWithDuration:self.animationTime animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.buttonH);
    NSString * buttonStr = self.dataSource[indexPath.row];
    [button setTitle:buttonStr forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 1000 + indexPath.row;
    
    [cell addSubview:button];
    return cell;
}
#pragma mark - UITableViewDelagate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.buttonH;
}

- (void)buttonClick:(UIButton *)button{
    
    if ([self.fzhPopViewDelegate respondsToSelector:@selector(getTheButtonTitleWithButton:)]) {
        [self.fzhPopViewDelegate getTheButtonTitleWithButton:button];
    }
}
@end
