//
//  LJYShop.h
//  UILearnDemo
//
//  Created by LJY on 2018/3/6.
//  Copyright © 2018年 LJY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJYShop : NSObject


/**
 商品图片名
 */
@property (nonatomic,copy) NSString *icon;

/**
 商品名称
 */
@property (nonatomic,copy) NSString *name;


/**
提供构造方法
 */
-(instancetype) initWithIcon:(NSString *)icon name:(NSString *)name;
+(instancetype) shopWithIcon:(NSString *)icon name:(NSString *)name;

-(instancetype) initWithDict:(NSDictionary *)dict;
+(instancetype) shopWithDict:(NSDictionary *)dict;

@end
