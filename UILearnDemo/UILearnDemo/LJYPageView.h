//
//  LJYPageView.h
//  UILearnDemo
//
//  Created by LJY on 2018/3/7.
//  Copyright © 2018年 LJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJYPageView : UIView

//图片数组的setter/getter
@property(nonatomic,strong)NSArray *imageNames;
//提供类方法，方便创建
+(instancetype)pageView;

@end
