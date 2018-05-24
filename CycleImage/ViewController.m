//
//  ViewController.m
//  CycleImage
//
//  Created by qj.huang on 2018/5/24.
//  Copyright © 2018年 qjmac. All rights reserved.
//

#import "ViewController.h"
#import "ImgUnlimitedPlayView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *array = @[@"0",@"1",@"2",@"3",@"4"];
    ImgUnlimitedPlayView *imgUnlimitedPlayView = [[ImgUnlimitedPlayView alloc] initWithFrame:CGRectMake(50, 100, 300, 150) withImageArr:array];
    
    imgUnlimitedPlayView.block = ^(NSInteger flag) {
        
        NSLog(@"点击了第%ld张图片",flag + 1);
      
    };
    
    [self.view addSubview:imgUnlimitedPlayView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
