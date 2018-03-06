//
//  LJYShopView.m
//  UILearnDemo
//
//  Created by LJY on 2018/3/6.
//  Copyright © 2018年 LJY. All rights reserved.
//

#import "LJYShopView.h"
#import "LJYShop.h"
@interface LJYShopView()

/**
 图片控件
 */
@property (nonatomic,weak) UIImageView *iconView;

/**
 标题控件
 */
@property (nonatomic,weak) UILabel *titleLabel;

@end

@implementation LJYShopView


/**
 初始化子控件
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createSonView];
    }
    return self;
}

/**
 布局子控件
 */
-(void)layoutSubviews{
    //一定要调用super
    [super layoutSubviews];
    //获取当前控件尺寸
    CGFloat width=self.frame.size.width;
    CGFloat height=self.frame.size.height;
    //设置子控件尺寸
    self.iconView.frame=CGRectMake(0, 0, width, width);
    self.titleLabel.frame=CGRectMake(0, width, width, height-width);
}

-(void)setIcon:(NSString *)icon{
    self.iconView.image=[UIImage imageNamed:icon];
}

-(void)setName:(NSString *)name{
    self.titleLabel.text=name;
}


/**
  set方法，只要外边传数据就会调用
 */
-(void)setShop:(LJYShop *)shop{
    _shop=shop;
    self.iconView.image=[UIImage imageNamed:shop.icon];
    self.titleLabel.text=shop.name;
}

-(instancetype)initWithShop:(LJYShop *)shop{
    if (self=[super init]) {
        [self createSonView];
        self.shop=shop;
    }
    return self;
}

+(instancetype)shopViewWithShop:(LJYShop *)shop{
    return [[self alloc]initWithShop:shop];
}


/**
 创建子控件
 */
-(void)createSonView{
    UIImageView *iconView=[[UIImageView alloc]init];
    iconView.backgroundColor=[UIColor blueColor];
    [self addSubview:iconView];
    self.iconView=iconView;
    
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.backgroundColor=[UIColor yellowColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;//居中
    [self addSubview:titleLabel];
    self.titleLabel=titleLabel;
}


@end
