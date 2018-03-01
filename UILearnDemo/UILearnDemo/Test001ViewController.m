//
//  TestViewController.m
//  01_HelloWorld
//
//  Created by LJY on 2018/2/26.
//  Copyright © 2018年 LJY. All rights reserved.
//

#import "Test001ViewController.h"

@interface Test001ViewController ()

/*
 
 */

//由于系统中已经有强指针指向了，所以我们自己引用时使用weak即可
@property (nonatomic,weak)IBOutlet UILabel *label_1;

@property (weak, nonatomic) IBOutlet UIView *btnParent;

@property (weak, nonatomic) IBOutlet UISwitch *switchView;

@property (weak, nonatomic) UILabel *lb;
@property (weak, nonatomic) IBOutlet UITextField *num1TextField;
@property (weak, nonatomic) IBOutlet UITextField *num2TextField;
@property (weak, nonatomic) IBOutlet UILabel *numSumLabel;

@end

@implementation Test001ViewController

//点击红按钮
-(IBAction) clickRedButton{
    self.label_1.textColor=[UIColor redColor];
    self.label_1.text=@"文字变红色了";
    self.label_1.backgroundColor=[UIColor greenColor];
    self.label_1.textAlignment=NSTextAlignmentCenter;
    self.label_1.font=[UIFont systemFontOfSize:10.0f];
    //从parent中删除自己
    [self.switchView removeFromSuperview];
    //添加子view
    if (self.lb==nil) {
        //创建label对象
        UILabel *lb=[[UILabel alloc]init];
        //设置背景色
        lb.backgroundColor=[UIColor yellowColor];
        //设置frame
        lb.frame=CGRectMake(50, 0, 80, 50);
        //设置文字
        lb.text=@"abcdefghig";
        //文字居中
        lb.textAlignment=NSTextAlignmentCenter;
        //文字大小
        lb.font=[UIFont systemFontOfSize:20.f];
        lb.font=[UIFont boldSystemFontOfSize:20.f];
        lb.font=[UIFont italicSystemFontOfSize:20.f];
        //文字颜色
        lb.textColor=[UIColor whiteColor];
        //文字阴影
        lb.shadowColor=[UIColor blackColor];
        lb.shadowOffset=CGSizeMake(3, 3);
        //设置行数(0时自动换行)
        lb.numberOfLines=1;
        //显示模式
        lb.lineBreakMode=NSLineBreakByTruncatingHead;
        //添加到控制器的view中
        [self.btnParent addSubview:lb];
        self.lb=lb;
    }else{
        //修改frame
        CGRect frame=self.lb.frame;
        frame.origin.x-=20;
        frame.origin.y-=20;
        self.lb.frame=frame;
    }
    
}

//点击绿按钮
-(IBAction) clickGreenButton{
    self.label_1.textColor=[UIColor greenColor];
    self.label_1.text=@"文字变绿色了";
    self.label_1.backgroundColor=[UIColor blueColor];
    self.label_1.textAlignment=NSTextAlignmentRight;
    self.label_1.font=[UIFont systemFontOfSize:20.0f];
    //修改bounds
    self.lb.bounds=CGRectMake(0, 0, 100, 100);
}

//点击蓝按钮
-(IBAction) clickBlueButton{
    self.label_1.textColor=[UIColor blueColor];
    self.label_1.text=@"文字变蓝色了";
    self.label_1.backgroundColor=[UIColor redColor];
    self.label_1.textAlignment=NSTextAlignmentLeft;
    self.label_1.font=[UIFont systemFontOfSize:30.0f];
    //修改center
    self.lb.center=CGPointMake(self.btnParent.frame.size.width*0.5, self.btnParent.frame.size.height*0.5);
    //修改frame
    CGRect frame=self.lb.frame;
    frame.size.width-=20;
    frame.size.height-=20;
    self.lb.frame=frame;
}
- (IBAction)clickSum {
    //取值
    NSString *num1String=self.num1TextField.text;
    NSString *num2String=self.num2TextField.text;
    //判断
    if(num1String.length==0){
        [self showAlert:@"请输入第1个数"];
        return;
    }
    if (num2String.length==0) {
        [self showAlert:@"请输入第2个数"];
        return;
    }
    //string转int
    NSInteger num1=[num1String integerValue];
    NSInteger num2=[num2String integerValue];
    //相加
    NSInteger result=num1+num2;
    //显示
    self.numSumLabel.text=[NSString stringWithFormat:@"%zd",result];
}

/** 提示alert */
-(void)showAlert:(NSString *)info{
    //创建alert
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"输入有误" message:info delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    //显示alert
    [alertView show];
}




@end
