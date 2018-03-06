//
//  Test004ViewController.m
//
//  UIScrollView 的使用
//
//  Created by LJY on 2018/3/6.
//  Copyright © 2018年 LJY. All rights reserved.
//

#import "Test004ViewController.h"

@interface Test004ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation Test004ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.添加一个view
    UIView *redView=[[UIView alloc]init];
    redView.backgroundColor=[UIColor redColor];
    redView.frame=CGRectMake(0, 0, 50, 50);
    [self.scrollView addSubview:redView];
    //超出时裁剪内容，默认YES
    self.scrollView.clipsToBounds=NO;
    //设置内容尺寸/滚动范围
    self.scrollView.contentSize=CGSizeMake(200, 200);
    //是否能滚动
//    self.scrollView.scrollEnabled=NO;
    //是否能够跟用户交互(scrollView及其内部子控件都不能相应用户交互)
//    self.scrollView.userInteractionEnabled=NO;
    //是否有弹簧效果
//    self.scrollView.bounces=YES;
    //当滚动界面设置小于当前界面时依然反弹(可用于下拉刷新)
    self.scrollView.alwaysBounceHorizontal=NO;
    self.scrollView.alwaysBounceVertical=YES;
    //是否显示滚动条
    self.scrollView.showsHorizontalScrollIndicator=YES;
    self.scrollView.showsVerticalScrollIndicator=NO;
    //千万不要通过索引去subviews数组访问scrollView的子控件(原因：包括进度条，无序)
    NSLog(@"------>%@",self.scrollView.subviews);
    //内容的偏移量（控制，获取）
    self.scrollView.contentOffset=CGPointMake(-100, -100);
    //内边距
    self.scrollView.contentInset=UIEdgeInsetsMake(100, 0, 0, 0);
    //设置代理
    self.scrollView.delegate=self;
}


/**
 点击控制器的view会自动调用这个方法
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    /*
    [UIView animateWithDuration:1.0 animations:^{
        CGPoint offset=self.scrollView.contentOffset;
        offset.y-=30;
        self.scrollView.contentOffset=offset;
    }];
     */
    CGPoint offset=self.scrollView.contentOffset;
    offset.y-=30;
    [self.scrollView setContentOffset:offset animated:YES];
    
    
//    self.view.backgroundColor=[UIColor greenColor];
}

/**
 刚刚开始拖拽scrollView时调用
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"------>刚刚开始拖拽 scrollViewWillBeginDragging");
}

/**
 当scrollView正在滚动时会自动调用这个方法(包括弹动时)
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    NSLog(@"------>正在滚动 scrollViewDidScroll");
}

/**
 刚刚停止拖拽scrollView时调用
 */
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"------>刚刚停止拖拽 scrollViewWillEndDragging");
}

/**
 用户停止拖拽时调用
 判断scrollview停止滚动：step1
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"------>停止拖拽时调用 scrollViewDidEndDragging");
    if (decelerate==NO) {
        NSLog(@"用户停止拖拽,停止滚动");
    }else{
        NSLog(@"用户停止拖拽,但是scrollview由于惯性继续滚动，减速中");
    }
}

/**
 scrollView减速完毕停止滚动时调用
 判断scrollview停止滚动：step2
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"------>减速完毕停止滚动时调 scrollViewDidEndDecelerating");
    NSLog(@"scrollView减速完毕，停止滚动");
}


@end
