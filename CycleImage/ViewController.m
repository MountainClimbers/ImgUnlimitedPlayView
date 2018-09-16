//
//  ViewController.m
//  CycleImage
//
//  Created by qj.huang on 2018/5/24.
//  Copyright © 2018年 qjmac. All rights reserved.
//

#import "ViewController.h"

#import "ImgUnlimitedPlayTwoView.h"

@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *array = @[@"0",@"1",@"2",@"3",@"4",@"4",@"3",@"2",@"1",@"0"];
    ImgUnlimitedPlayTwoView *imgUnlimitedPlayView = [[ImgUnlimitedPlayTwoView alloc] initWithFrame:CGRectMake(50, 100, 300, 150) withImageArr:array];
    imgUnlimitedPlayView.currentPageColor = [UIColor blueColor];
    imgUnlimitedPlayView.block = ^(NSInteger flag) {

        NSLog(@"点击了第%ld张图片",flag + 1);

    };
    
    [self.view addSubview:imgUnlimitedPlayView];
    
    
    //oc UIButton
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 100, 50)];
    [btn setTitle:@"开始线程" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //oc UIButton
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 350, 100, 50)];
    [btn2 setTitle:@"暂停线程" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
