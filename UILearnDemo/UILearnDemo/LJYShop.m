//
//  LJYShop.m
//  UILearnDemo
//
//  Created by LJY on 2018/3/6.
//  Copyright © 2018年 LJY. All rights reserved.
//

#import "LJYShop.h"

@implementation LJYShop

-(instancetype)initWithIcon:(NSString *)icon name:(NSString *)name{
    if (self=[super init]) {
        self.icon=icon;
        self.name=name;
    }
    return self;
}

+(instancetype)shopWithIcon:(NSString *)icon name:(NSString *)name{
    return [[self alloc]initWithIcon:icon name:name];
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
//        self.icon=dict[@"icon"];
//        self.name=dict[@"name"];
        //仅适用于简单的模型类，有嵌套的无法解析成功
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)shopWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
