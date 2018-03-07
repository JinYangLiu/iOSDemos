//
//  Test005ViewController.m
//
//  使用UIScrollView抽出的pageView
//
//  Created by LJY on 2018/3/7.
//  Copyright © 2018年 LJY. All rights reserved.
//

#import "Test005ViewController.h"
#import "LJYPageView.h"

@interface Test005ViewController ()

@property(nonatomic,weak) LJYPageView *pageView;

@end

@implementation Test005ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建自定义轮播图
    LJYPageView *pageView=[LJYPageView pageView];
    pageView.center=self.view.center;
    pageView.frame=CGRectMake(30, 30, 200, 200);
    [self.view addSubview:pageView];
    self.pageView=pageView;
    [self.pageView layoutIfNeeded];//上面修改了frame，调用此方法强制刷新pageView的frame
    pageView.imageNames=@[@"picTest001",@"picTest002",@"picTest003",@"picTest004"];
}
- (IBAction)changeImg:(id)sender {
    self.pageView.imageNames=@[@"bg",@"bg2",@"current",@"other"];
}



@end
