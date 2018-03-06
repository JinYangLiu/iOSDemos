//
//  LJYShopView.h
//  UILearnDemo
//
//  Created by LJY on 2018/3/6.
//  Copyright © 2018年 LJY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJYShop;

@interface LJYShopView : UIView

/**
 提供接口方法
  */
-(void)setIcon:(NSString *)icon;
-(void)setName:(NSString *)name;

/**
 商品模型
 */
@property(nonatomic,strong)LJYShop *shop;

//构造方法
-(instancetype)initWithShop:(LJYShop *)shop;
+(instancetype)shopViewWithShop:(LJYShop *)shop;

@end
