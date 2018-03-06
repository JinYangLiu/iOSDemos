//
//  Test002ViewController.m
//  UILearnDemo
//
//  Created by LJY on 2018/2/27.
//  Copyright © 2018年 LJY. All rights reserved.
//

#import "Test002ViewController.h"
#import "AVFoundation/AVFoundation.h"

@interface Test002ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mImageView;

@property (nonatomic,strong)AVPlayer *player;

@property(nonatomic,strong)NSArray *images;

@property(nonatomic,strong)NSString *inputHint;

@property (weak, nonatomic) IBOutlet UITextField *textFied;

@end

@implementation Test002ViewController

/**
 1.系统调用
 2.控制器的view加载完毕的时候调用
 3.控件控件的初始化，数据的初始化（懒加载）
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [self initData];
    //UIImageView使用：
    [self addImageView];
   //UIButton的使用
    [self addButton];
    //设置textField监听（UITextFieldDelegate）
    self.textFied.delegate=self ;
    /*
    [self.textFied addTarget:self action:@selector(tfEditingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self.textFied addTarget:self action:@selector(tfEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.textFied addTarget:self action:@selector(tfEditingDidEnd) forControlEvents:UIControlEventEditingDidEnd];
     */
    
    ////hint step1，弹出键盘前的设置
    self.inputHint=self.textFied.text=[NSString stringWithFormat:@"请输入数字1之外的字符"];
    self.textFied.textColor=[UIColor lightGrayColor];
    //调起键盘
//    [self.textFied becomeFirstResponder];
   
    
}

/**
 1.系统调用
 2.控制器收到内存警告时调用
 3.去除一些不必要的内存占用，去除耗时的内存
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/**
 初始化数据
 */
-(void)initData{
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
 ImageView的使用
 */
-(void)addImageView{
    //创建
    UIImageView *imageView=[[UIImageView alloc]init];
    //设置位置尺寸
    //方式1.
    imageView.frame=CGRectMake(20, 20, 300, 180);
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
    //    imageView.backgroundColor=[UIColor greenColor];
    imageView.backgroundColor=[UIColor colorWithRed:210/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
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
    //    imageView.image=[UIImage imageNamed:@"picTest001"];
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
}

-(void)addButton{
    //创建
    //设置按钮类型只能在初始化时设置
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    //设置frame
    button.frame=CGRectMake(80, 80, 200, 80);
    //背景色
    button.backgroundColor=[UIColor greenColor];
    //设置文字
    [button setTitle:@"普通按钮" forState:UIControlStateNormal];
    [button setTitle:@"高亮按钮" forState:UIControlStateHighlighted];
    //文字颜色
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    //文字字体
    button.titleLabel.font =[UIFont systemFontOfSize:23];
    //文字阴影
    [button setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    button.titleLabel.shadowOffset=CGSizeMake(3, 3);
    //设置内容图片
    [button setImage:[UIImage imageNamed:@"picTest001"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"picTest002"] forState:UIControlStateHighlighted];
    //设置背景图片
    [button setBackgroundImage:[UIImage imageNamed:@"picTest003"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"picTest004"] forState:UIControlStateHighlighted];
    //按钮点击监听
    [button addTarget:self action:@selector(testClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //enabled才能达到UIControlStateDisabled状态
//    button.enabled=NO;
//    button.userInteractionEnabled=NO;
    
    
    [self.view addSubview:button];
}

-(void)testClick:(UIButton *)btn{
    NSLog(@"点击了--%@",btn);
    //获得按钮文字
    NSString *title=[btn titleForState:UIControlStateNormal];
    NSLog(@"按钮文字--%@",title);
    //获得按钮文字颜色
    UIColor *titleColor=[btn titleColorForState:UIControlStateHighlighted];
    NSLog(@"按钮文字颜色--%@",titleColor);//RGBA
    //获得按钮内部小图片
    UIImage *image=[btn imageForState:UIControlStateNormal];
    NSLog(@"按钮内部小图片--%@",image);
    //获得按钮背景图片
    UIImage *imageBack=[btn backgroundImageForState:UIControlStateNormal];
    NSLog(@"按钮背景图片--%@",imageBack);
    
}


- (IBAction)clickAnim {
    //1. 动画：
    //延迟执行startAnim
    [self performSelector:@selector(startAnim:) withObject:self.images afterDelay:2.1];
    
    //2. 播放音乐：
    [self.player play];
}

/**
 设置帧动画
 @param images 传入的图片数组 */
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
//    [self.mImageView stopAnimating];
}

- (IBAction)changeMusic {
    //切换音乐
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"mySong2.mp3" withExtension:nil];
    AVPlayerItem *playerItem=[[AVPlayerItem alloc]initWithURL:url];
    self.player=[[AVPlayer alloc]initWithPlayerItem:playerItem];
    [self.player play];
}

- (IBAction)translationAnim {
    //方式一
    /*
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    CGRect frame=self.mImageView.frame;
    frame.origin.y-=30;
    self.mImageView.frame=frame;
    [UIView commitAnimations];
     */
    //方式二
    /*
    [UIView animateWithDuration:1.0 animations:^{
        CGRect frame=self.mImageView.frame;
        frame.origin.y-=40;
        self.mImageView.frame=frame;
    }];
     */
    //方式三
    /*
    [UIView animateWithDuration:1.0 animations:^{
        CGRect frame=self.mImageView.frame;
        frame.origin.y-=40;
        self.mImageView.frame=frame;
    } completion:^(BOOL finished){
        //动画完成后执行
        self.mImageView.image=[UIImage imageNamed:@"picTest004"];
    }];
     */
    //方式四
    //options类似于android的动画插值器
//    UIViewAnimationOptionCurveEaseIn 开始比较慢
//    UIViewAnimationCurveEaseOut 结束比较慢
//    UIViewAnimationOptionCurveEaseInOut 开始和结束较慢，中间较快
//    UIViewAnimationCurveLinear 线性/匀速
    
    [UIView animateWithDuration:1.0 delay:3.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect frame=self.mImageView.frame;
        frame.origin.y-=40;
        self.mImageView.frame=frame;
    } completion:^(BOOL finished){
        //动画完成后执行
        self.mImageView.image=[UIImage imageNamed:@"picTest004"];
    }];
    
}
- (IBAction)scralAnim {
    [UIView animateWithDuration:1.0 animations:^{
        CGRect frame=self.mImageView.frame;
        CGSize size=frame.size;
        frame.size=CGSizeMake(size.width/5*4, size.height/5*4);
        self.mImageView.frame=frame;
    }];
}
- (IBAction)alphaAnim {
    [UIView animateWithDuration:1.0 animations:^{
        self.mImageView.alpha*=0.7;
    }];
}
- (IBAction)addBgImg {
    //重新设置尺寸
    CGRect frame=self.mImageView.frame;
    CGSize size=frame.size;
    frame.size=CGSizeMake(size.width,size.width/4 );
    self.mImageView.frame=frame;
    //设置可以被拉伸填充的图片
    UIImage *img=[UIImage imageNamed:@"bg2"];
    CGFloat imgWidth=img.size.width;
    CGFloat imgHeight=img.size.height;
//    方式一
    /*
//    UIImage *resizeImg=[img resizableImageWithCapInsets:UIEdgeInsetsMake(imgHeight*0.5, imgWidth*0.5, imgHeight*0.5-1, imgWidth*0.5-1)];
//    UIImageResizingModeTile 平铺
//    UIImageResizingModeStretch 拉伸
    UIImage *resizeImg=[img resizableImageWithCapInsets:UIEdgeInsetsMake(imgHeight*0.5, imgWidth*0.5, imgHeight*0.5-1, imgWidth*0.5-1) resizingMode:UIImageResizingModeTile];
     */
//    方式二
    //right =imgWidth-left-1;
    //bottom=imgHeight-top-1;
    UIImage *resizeImg=[img stretchableImageWithLeftCapWidth:imgWidth*0.5 topCapHeight:imgHeight*0.5];
    self.mImageView.image=resizeImg;
    
}
- (IBAction)kvcClick:(UIButton *)btn {
    //KVC赋值
    /*
     forKey & forKeyPath
     1.forKeyPath包含了所有forKey的功能
     2.forKeyPath进行内部的点语法，层层访问内部的属性
     3.key值一定要在属性中找到
     4.利用kvc修改类的私有成员变量
     */
//    [btn setValue:[UIColor redColor] forKey:@"backgroundColor"];
    [btn setValue:[UIColor greenColor] forKeyPath:@"backgroundColor"];
    
    
}
- (IBAction)listenerClick:(UIButton *)btn {
    //赋原值
    [btn setValue:[UIColor greenColor] forKey:@"backgroundColor"];
//    添加监听器
    [btn addObserver:self forKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    //修改值
     [btn setValue:[UIColor redColor] forKey:@"backgroundColor"];
    //移除监听
    [btn removeObserver:self forKeyPath:@"backgroundColor"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"--------%@------%@--------%@",keyPath,object,change);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 退出键盘
    //    [self.textFlied endEditing:YES];
    // 辞去第一响应者(退出键盘)
    //    [self.textFlied resignFirstResponder];
    [self.view endEditing:YES];
}

#pragma mark - textFlied监听方法
- (void)tfEditingDidBegin
{
    NSLog(@"开始编辑");
}

- (void)tfEditingDidEnd
{
    NSLog(@"结束编辑");
}

- (void)tfEditingChanged:(UITextField *)tf
{
    NSLog(@"%@",tf.text);
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"开始编辑");
    //hint step2
    if (self.inputHint && self.inputHint.length>0) {
        textField.text=@"";
        textField.textColor=[UIColor redColor];
        self.inputHint=nil;
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"结束编辑");
    //hint step3
    if (textField.text.length==0) {
        self.inputHint=textField.text=[NSString stringWithFormat:@"请输入数字1之外的字符"];
        textField.textColor=[UIColor lightGrayColor];
    }
}

/**
 *  当textField文字改变就会调用这个方法
 *  @param string    用户输入的文字
 *
 *  @return YES:允许用户输入;NO:禁止用户输入
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSLog(@"shouldChangeCharactersInRange--%@",string);
    if ([string isEqualToString:@"1"]) {
        return NO;
    }
    return YES;
}

@end
