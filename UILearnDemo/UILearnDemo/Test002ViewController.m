//
//  Test002ViewController.m
//  UILearnDemo
//
//  Created by LJY on 2018/2/27.
//  Copyright © 2018年 LJY. All rights reserved.
//

#import "Test002ViewController.h"
#import "AVFoundation/AVFoundation.h"

@interface Test002ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mImageView;

@property (nonatomic,strong)AVPlayer *player;

@property(nonatomic,strong)NSArray *images;

@end

@implementation Test002ViewController

/**
 1.系统调用
 2.控制器的view加载完毕的时候调用
 3.控件控件的初始化，数据的初始化（懒加载）
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    //UIImageView使用：
    //创建
    UIImageView *imageView=[[UIImageView alloc]init];
    //设置位置尺寸
    //方式1.
    imageView.frame=CGRectMake(30, 30, 300, 200);
    //方式2.
//    imageView.frame=(CGRect){{50,50},{200,300}};
    //方式3.
//    UIImage *image=[UIImage imageNamed:@"picTest002"];
//    imageView.frame=CGRectMake(0, 0, image.size.width, image.size.height);
//    imageView.image=image;
    //方式4.
//    UIImage *image=[UIImage imageNamed:@"picTest002"];
//    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, image.size.width, image.size.height)];
//    imageView.image=image;
    //方式5.
//    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"picTest002"]];
//    imageView.center=CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height*0.5);
//    //设置背景
    imageView.backgroundColor=[UIColor greenColor];
    //设置图片
    /*
     图片的两种存放位置：
     1. 加载Assets.xcassets里面的图片
     --1.打包后变成Assets.car
     --2.拿不到路径
     --3.只能通过imageNamed加载图片
     --4.不能通过imageWithContentsOfFile加载图片
     2. 放到项目中的图片
     --1.可以拿到路径
     --2.能通过imageNamed加载图片
     --3.能通过imageWithContentsOfFile加载图片
     
     图片的两种加载方式：
     1.imageNamed：
     --1.就算指向它的指针被销毁，该资源也不会被从内存中释放
     --2.放到Assets.xcassets中的图片默认就有缓存
     --3.图片经常被使用
     2.imageWithContentsOfFile：
     --1.指向它的指针被销毁，该资源会被从内存中释放
     --2.放到项目中的图片就不会缓存
     --3.不经常用，大批量的图片
     */
    //方式1:
//    imageView.image=[UIImage imageNamed:@"picTest002"];
    //方式2:
    NSString *path=[[NSBundle mainBundle] pathForResource:@"picTest003" ofType:@"png"];
    imageView.image=[UIImage imageWithContentsOfFile:path];
    //设置内容模式
//    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.contentMode=UIViewContentModeScaleAspectFit;
//    imageView.contentMode=UIViewContentModeScaleToFill;
//    imageView.contentMode=UIViewContentModeRedraw;
    //是否裁剪多余部分
    imageView.clipsToBounds=YES;
    //加毛玻璃
//    UIToolbar *toolBar=[[UIToolbar alloc]init];
//    toolBar.frame=imageView.bounds;
//    toolBar.barStyle=UIBarStyleBlack;
//    toolBar.alpha=0.96;
//    [imageView addSubview:toolBar];
    //添加到控制器的view中
    [self.view addSubview:imageView];
    
    //加载所有图片
    NSMutableArray<UIImage *> *images=[NSMutableArray array];
    for (int i=0; i<4; i++) {
        NSString *imageName=[NSString stringWithFormat:@"picTest00%d",i+1];
        UIImage *image=[UIImage imageNamed:imageName];
        [images addObject:image];
    }
    self.images=images;
    
    //初始化音乐播放器
//    NSString *musicPath=[[NSBundle mainBundle]pathForResource:@"mySong1.mp3" ofType:nil];
//    NSLog(@"musicPath=%@",musicPath);
//    NSURL *url=[NSURL fileURLWithPath:musicPath];
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"mySong1.mp3" withExtension:nil];
    AVPlayerItem *playerItem=[[AVPlayerItem alloc]initWithURL:url];
    self.player=[[AVPlayer alloc]initWithPlayerItem:playerItem];
    
}

/**
 1.系统调用
 2.控制器收到内存警告时调用
 3.去除一些不必要的内存占用，去除耗时的内存
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)clickAnim {
    //1. 动画：
    //延迟执行startAnim
    [self performSelector:@selector(startAnim:) withObject:self.images afterDelay:2.1];
    
    //2. 播放音乐：
    [self.player play];
    
    
}

//设置帧动画
-(void)startAnim:(NSMutableArray<UIImage *> *) images{
    //设置动画图片
    self.mImageView.animationImages=images;
    //设置播放次数(0为无限循环)
    self.mImageView.animationRepeatCount=0;
    //设置播放时长
    self.mImageView.animationDuration=1.2;
    //播放
    [self.mImageView startAnimating];
}
- (IBAction)stopMusic {
    //暂停音乐
    [self.player pause];
    [self.mImageView stopAnimating];
}
- (IBAction)changeMusic {
    //切换音乐
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"mySong2.mp3" withExtension:nil];
    AVPlayerItem *playerItem=[[AVPlayerItem alloc]initWithURL:url];
    self.player=[[AVPlayer alloc]initWithPlayerItem:playerItem];
    [self.player play];
    
}



@end
