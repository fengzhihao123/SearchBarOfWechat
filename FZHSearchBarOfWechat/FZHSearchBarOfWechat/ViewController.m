//
//  ViewController.m
//  FZHSearchBarOfWechat
//
//  Created by 冯志浩 on 16/6/4.
//  Copyright © 2016年 FZH. All rights reserved.
//

#import "ViewController.h"
#import "FZHPopView.h"
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
static CGFloat viewOffset = 64;
@interface ViewController ()<UISearchBarDelegate,FZHPopViewDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) FZHPopView *popView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleArray = [NSMutableArray arrayWithObjects:@"friend",@"article",@"number", nil];
    [self setupSearchBar];
}

- (void)setupSearchBar{

    self.searchBar = [[UISearchBar alloc]init];
    
    self.searchBar.frame = CGRectMake(0, viewOffset, SCREEN_WIDTH, viewOffset);
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"搜索";
    [self.view addSubview:self.searchBar];
    
}

#pragma mark -UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [UIView animateWithDuration:0.5 animations:^{
        
       //1.
        self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, -viewOffset);
        self.searchBar.transform = CGAffineTransformMakeTranslation(0, -viewOffset);
        //2.
        self.searchBar.showsCancelButton = YES;
        [self setupCancelButton];
        //3.
        [self setupPopView];
    }];
}

- (void)setupPopView{
    self.popView = [[FZHPopView alloc]init];
    self.popView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.popView.fzhPopViewDelegate = self;
    [self.popView showThePopViewWithArray:self.titleArray];
    [self.view addSubview:self.popView];
}

- (void)setupCancelButton{
    
    UIButton *cancelButton = [self.searchBar valueForKey:@"_cancelButton"];
    [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClickEvent) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)cancelButtonClickEvent{
    
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        //1.
        self.navigationController.navigationBar.transform = CGAffineTransformIdentity;
        self.searchBar.transform = CGAffineTransformIdentity;
        //2.
        self.searchBar.showsCancelButton = NO;
        [self.searchBar endEditing:YES];
        //3.
        [self.popView dismissThePopView];
    }];
    self.searchBar.placeholder = @"搜索";
    
}

#pragma mark -FZHPopViewDelegate
-(void)getTheButtonTitleWithButton:(UIButton *)button{
    self.searchBar.placeholder = button.titleLabel.text;
    [self.popView dismissThePopView];
}

@end
