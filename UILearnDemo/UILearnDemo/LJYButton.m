//
//  LJYButton.m
//  UILearnDemo
//
//  Created by LJY on 2018/3/6.
//  Copyright © 2018年 LJY. All rights reserved.
//

#import "LJYButton.h"
#import "LJYShop.h"

@implementation LJYButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //文本居中
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        //改变图片内容模式
        self.imageView.contentMode=UIViewContentModeCenter;
        self.imageView.contentMode=UIViewContentModeScaleAspectFill;
    }
    return self;
}

//方式一
/*
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, 70, 70);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 70, 70, 30);
}
 */
//方式二
-(void)layoutSubviews{
    [super layoutSubviews];
    //获取当前控件尺寸
    CGFloat width=self.frame.size.width;
    CGFloat height=self.frame.size.height;
    //设置子控件尺寸
    self.imageView.frame=CGRectMake(0, 0, width, width);
    self.titleLabel.frame=CGRectMake(0, width, width, height-width);
    //设置内边距
    //
    //        self.contentEdgeInsets=UIEdgeInsetsMake(-20, 0, 0, 0);
//    self.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 0);
//    self.titleEdgeInsets=UIEdgeInsetsMake(0, 40, 0, 0);

}

/**
 set方法，只要外边传数据就会调用
 */
-(void)setShop:(LJYShop *)shop{
    _shop=shop;
    //self.imageView.image=[UIImage imageNamed:shop.icon];
    //self.titleLabel.text=shop.name;
    [self setImage:[UIImage imageNamed:shop.icon] forState:UIControlStateNormal];
    [self setTitle:shop.name forState:UIControlStateNormal];
}

-(instancetype)initWithShop:(LJYShop *)shop{
    if (self=[super init]) {
        self.shop=shop;
    }
    return self;
}

+(instancetype)shopViewWithShop:(LJYShop *)shop{
    return [[self alloc]initWithShop:shop];
}

@end
