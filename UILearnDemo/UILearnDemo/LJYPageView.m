//
//  LJYPageView.m
//  UILearnDemo
//
//  Created by LJY on 2018/3/7.
//  Copyright © 2018年 LJY. All rights reserved.
//

#import "LJYPageView.h"

@interface LJYPageView()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

/**
 定时器
 */
@property(nonatomic,weak) NSTimer *timer;

@end

@implementation LJYPageView

//提供类构造方法，加载xib文件
+(instancetype)pageView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

//加载xib后的初始化操作
-(void)awakeFromNib{
    [super awakeFromNib];
    self.pageControl.hidesForSinglePage=YES;//单页时隐藏pageControl
    //设置pageControl图片
    [self.pageControl setValue:[UIImage imageNamed:@"current"] forKey:@"_currentPageImage"];
    [self.pageControl setValue:[UIImage imageNamed:@"other"] forKey:@"_pageImage"];
    //开启定时器
    [self startTimer];
}

//设置图片数组
-(void)setImageNames:(NSArray *)imageNames{
    _imageNames=imageNames;
    //0.移除之前添加的
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //1.创建并添加imageView
    CGFloat scrollViewWidth=self.scrollView.frame.size.width;
    CGFloat scrollViewHeight=self.scrollView.frame.size.height;
    NSUInteger count=imageNames.count;
    for (int i=0; i<count; i++) {
        UIImageView *imageView=[[UIImageView alloc]init];
        imageView.image=[UIImage imageNamed:imageNames[i]];
        imageView.frame=CGRectMake(scrollViewWidth*i, 0, scrollViewWidth, scrollViewHeight);
        [self.scrollView addSubview:imageView];
    }
    //2.设置scrollView滚动范围
    self.scrollView.contentSize=CGSizeMake(scrollViewWidth*count, 0);
    //3.设置pageControl页数
    self.pageControl.numberOfPages=count;
    
}

//开始定时任务
-(void)startTimer{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
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
    if (page==self.imageNames.count) {
        page=0;
    }
    //滚动到下页
    [self.scrollView setContentOffset:CGPointMake(page*self.scrollView.frame.size.width, 0) animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //scrollView滚动监听控制pageControl的页码显示
    int page=(int)(scrollView.contentOffset.x/scrollView.frame.size.width+0.5);
    self.pageControl.currentPage=page;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //用户开始拖拽时停止自动滚动的定时任务
    [self stopTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //用户刚停止拖拽时开启自动滚动的定时任务
    [self startTimer];
}



@end
