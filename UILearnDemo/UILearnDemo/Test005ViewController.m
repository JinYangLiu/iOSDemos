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

@end

@implementation Test005ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建自定义轮播图
    LJYPageView *pageView=[LJYPageView pageView];
    pageView.center=self.view.center;
    pageView.imageNames=@[@"picTest001",@"picTest002",@"picTest003",@"picTest004"];
    [self.view addSubview:pageView];
    
    
}



@end
