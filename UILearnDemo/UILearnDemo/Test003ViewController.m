//
//  Test003ViewController.m
//  UILearnDemo
//
//  Created by LJY on 2018/3/5.
//  Copyright © 2018年 LJY. All rights reserved.
//

#import "Test003ViewController.h"
#import "LJYShop.h"
#import "LJYShopView.h"
#import "LJYButton.h"

@interface Test003ViewController ()
//购物车
@property (weak, nonatomic) IBOutlet UIView *shopCarView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *delButton;
@property(strong,nonatomic) NSArray *dataArr;

//全局下标
//@property(nonatomic,assign)NSInteger index;

@end

@implementation Test003ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //给下标赋值
//    self.index=0;
//    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
-(void)initData{
    NSArray<NSDictionary *> *dataArr=@[
               @{@"name":@"商品1",@"icon":@"picTest001"},
               @{@"name":@"商品2",@"icon":@"picTest002"},
               @{@"name":@"商品3",@"icon":@"picTest003"},
               @{@"name":@"商品4",@"icon":@"picTest004"},
               @{@"name":@"商品5",@"icon":@"picTest001"},
               @{@"name":@"商品6",@"icon":@"picTest002"}
              ];
    self.dataArr=dataArr;
}
*/


/**
 懒加载
 dataArr的get方法中初始化数据
 */
-(NSArray *)dataArr{
    if (_dataArr==nil) {
        self.dataArr=@[
                       @{@"name":@"商品1",@"icon":@"picTest001"},
                       @{@"name":@"商品2",@"icon":@"picTest002"},
                       @{@"name":@"商品3",@"icon":@"picTest003"},
                       @{@"name":@"商品4",@"icon":@"picTest004"},
                       @{@"name":@"商品5",@"icon":@"picTest001"},
                       @{@"name":@"商品6",@"icon":@"picTest002"}
                       ];
        //字典转模型
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in self.dataArr) {
            LJYShop *shop=[LJYShop shopWithDict:dict];
            [tempArray addObject:shop];
        }
        self.dataArr=tempArray;
    }
    return _dataArr;
}

/**
 添加商品
 */
- (IBAction)add {
    //------------------定义一些常量-------------
    NSInteger allCols=3;//总列数
    NSInteger allRows=2;//总行数
    CGFloat width=80;//商品宽度
    CGFloat height=100;//商品高度
    //水平间距 & 垂直间距
    CGFloat hMargin=(self.shopCarView.frame.size.width-allCols*width)/(allCols-1);
    CGFloat vMargin=(self.shopCarView.frame.size.height-allRows*height)/(allRows-1);
    //设置索引
    NSInteger index=self.shopCarView.subviews.count;
    //商品坐标的x值
    CGFloat x=(hMargin+width)*(index%allCols);
    CGFloat y=(vMargin+height)*(index/allCols);
    
    //-------------------创建商品-------------
    //1.
    /*
    //创建
    UIView *shopView=[[UIView alloc]init];
    //设置frame
    shopView.frame=CGRectMake(x, y, width, height);
    //背景色
    shopView.backgroundColor=[UIColor greenColor];
    //添加商品图片
    UIImageView *iconView=[[UIImageView alloc]init];
    iconView.frame=CGRectMake(0, 0, width, width);
    iconView.backgroundColor=[UIColor blueColor];
    [shopView addSubview:iconView];
    //添加商品标题
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.frame=CGRectMake(0, width, width, height-width);
    titleLabel.backgroundColor=[UIColor yellowColor];
    [shopView addSubview:titleLabel];
    //设置数据
    NSDictionary *dict=self.dataArr[index];
    iconView.image=[UIImage imageNamed:dict[@"icon"]];
    titleLabel.text=dict[@"name"];
    //添加到购物车
    [self.shopCarView addSubview:shopView];
     */
    //2.
    /*
    LJYShop *shop=self.dataArr[index];
    LJYShopView *shopView=[[LJYShopView alloc]init];
    shopView.frame=CGRectMake(x, y, width, height);
//    [shopView setIcon:shop.icon];
//    [shopView setName:shop.name];
    shopView.shop=shop;
    [self.shopCarView addSubview:shopView];
     */
    //3.
    /*
    LJYShopView *shopView=[LJYShopView shopViewWithShop:self.dataArr[index]];
    shopView.frame=CGRectMake(x, y, width, height);
    [self.shopCarView addSubview:shopView];
     */
    //4.
    LJYButton *shopView=[LJYButton shopViewWithShop:self.dataArr[index]];
    shopView.frame=CGRectMake(x, y, width, height);
    [self.shopCarView addSubview:shopView];
    
    //-------------------设置按钮状态-------------
//    if(index==allCols*allRows-1){
//        self.addButton.enabled=NO;
//    }
    self.addButton.enabled=index!=allCols*allRows-1;
    self.delButton.enabled=YES;
    
    //下标增加1
//    self.index+=1;
}

/**
 删除商品
 */
- (IBAction)delete {
    //最后一个商品
    UIView *lastShopView=[self.shopCarView.subviews lastObject];
    [lastShopView removeFromSuperview];
    //设置按钮状态
    self.addButton.enabled=YES;
//    if (self.shopCarView.subviews.count==0) {
//        self.delButton.enabled=NO;
//    }
    self.delButton.enabled=self.shopCarView.subviews.count!=0;
}



@end
