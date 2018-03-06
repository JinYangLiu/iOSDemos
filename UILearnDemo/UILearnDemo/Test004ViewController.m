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
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property(nonatomic,weak) NSTimer *timer;

@end

@implementation Test004ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
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
     */
    //设置代理
    self.scrollView.delegate=self;
    
    //scrollView支持缩放图片
    /*
    self.scrollView.contentSize=self.imageView.image.size;
    self.scrollView.maximumZoomScale=3.0;
    self.scrollView.minimumZoomScale=0.2;
    */
    
    //分页
    //0.移除所有子控件
//    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //1.添加图片
    CGFloat scrollViewWidth=self.scrollView.frame.size.width;
    CGFloat scrollViewHeight=self.scrollView.frame.size.height;
    int count=4;
    for (int i=1; i<count+1; i++) {
        UIImageView *imgView=[[UIImageView alloc]init];
        NSString *imgName=[NSString stringWithFormat:@"picTest00%d",i];
        imgView.image=[UIImage imageNamed:imgName];
        imgView.frame=CGRectMake(i*scrollViewWidth, 0, scrollViewWidth, scrollViewHeight);
        [self.scrollView addSubview:imgView];
    }
    //设置contentSize
    self.scrollView.contentSize=CGSizeMake(count*scrollViewWidth, 0);
    //开启分页
    self.scrollView.pagingEnabled=YES;
    //关闭滚动条
    self.scrollView.showsHorizontalScrollIndicator=NO;
    //单页时是否隐藏pageControl
    self.pageControl.hidesForSinglePage=YES;
    //设置pageControl图片
    [self.pageControl setValue:[UIImage imageNamed:@"current"] forKey:@"_currentPageImage"];
    [self.pageControl setValue:[UIImage imageNamed:@"other"] forKey:@"_pageImage"];
    //pagecontrol页数
    self.pageControl.numberOfPages=count;
    //自动滚动
    [self startTimer];
}

//开始定时任务
-(void)startTimer{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
//    主线程：程序一启动，系统会默认创建一条线程
//    主线程作用：显示刷新UI界面，处理与用户的交互事件
//    多线程原理：1s---->1000个0.001s
    
//    NSRunLoopCommonModes,公用，可以分配时间执行其他任务
//    NSDefaultRunLoopMode,默认，同一时间只能执行一个任务
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//结束定时任务
-(void)stopTimer{
    [self.timer invalidate];
}

-(void)nextPage{
    //计算下一页页码
    NSInteger page=self.pageControl.currentPage+1;
    //如果超过最后一页
    if (page==4) {
        page=0;
    }
    //滚动到下页
    [self.scrollView setContentOffset:CGPointMake(page*self.scrollView.frame.size.width, 0) animated:YES];
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
    //开始拖拽时停止定时器自动滚动
    [self stopTimer];
}

/**
 当scrollView正在滚动时会自动调用这个方法(包括弹动时)
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    NSLog(@"------>正在滚动 scrollViewDidScroll");
//    设置分页：方式二
    int page=(int)(scrollView.contentOffset.x/scrollView.frame.size.width+0.5);
    self.pageControl.currentPage=page;
    
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
        [self startTimer];
    }else{
        NSLog(@"用户停止拖拽,但是scrollview由于惯性继续滚动，减速中");
    }
    /*
    //设置分页：方式一
    if (decelerate==NO) {
        //计算页数
        int page=scrollView.contentOffset.x/scrollView.frame.size.width;
        //设置页数
        self.pageControl.currentPage=page;
    }
     */
}

/**
 scrollView减速完毕停止滚动时调用
 判断scrollview停止滚动：step2
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"------>减速完毕停止滚动时调 scrollViewDidEndDecelerating");
    NSLog(@"scrollView减速完毕，停止滚动");
    [self startTimer];
    /*
    //设置分页：方式一
    //计算页数
    int page=scrollView.contentOffset.x/scrollView.frame.size.width;
    //设置页数
    self.pageControl.currentPage=page;
     */
}

//返回需要缩放的子控件
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

//缩放时调用
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidZoom");
}


@end
