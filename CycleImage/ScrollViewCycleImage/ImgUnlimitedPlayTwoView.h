//
//  ImgUnlimitedPlayTwoView.h
//  CycleView
//
//  Created by 雷神 on 2018/5/24.
//  Copyright © 2018年 雷神. All rights reserved.
//
/*
 1测试点:
 图片滑动是否有动画效果
 图片个数是否正确
 图片滑动顺序是否正确
 指示点个数是否正确
 指示点滑动顺序是否正确
 图片点击的是不是那一张
 
 2效果:
 图片滑动要有动画效果
 用三张图片表示所有图片并可手动向左右循环滚动
 可以自动向右滚动
 有指示点
 可以点击图片
 
 3原理:
 
 图片滑动要有动画效果原理:
 手动滑动自带动画效果
 自动滑动 有动画的设置contentOffset到右边按钮
 
 用三张图片表示所有图片并可手动向左右循环滚动原理:
 contentSize放三个按钮
 contentOffset始终设置为显示中间按钮
 设置代表数组的哪一张图片的flag值,默认为0
 scrollView左右滑动结束后利用contentOffset处于左右方向,设置flag++ 还是flag-- (scrollViewDidEndDecelerating)
 利用flag的值计算出0 - imageArray.count-1中的一张,算出flag
 利用flag 配置flag左右按钮图片
 无动画的设置contentOffset为中间那张
 
 可以自动向右滚动原理:
 加NSTimer
 监听NSTimer事件,有动画的设置contentOffset到右边按钮
 scrollView左右滑动结束后利用contentOffset处于左右方向,设置flag++ 还是flag-- (scrollViewDidEndScrollingAnimation)
 利用flag的值计算出0 - imageArray.count-1中的一张,算出flag
 利用flag 配置flag左右按钮图片
 无动画的设置contentOffset为中间那张
 
 指示点原理
 _pageControl.currentPage = _flag;
 
 可以点击图片原理
 只给中间button加点击事件,用block把_flag传出去
 */
#import <UIKit/UIKit.h>

typedef void(^Block)(NSInteger flag);

@interface ImgUnlimitedPlayTwoView : UIView

- (instancetype)initWithFrame:(CGRect)frame withImageArr:(NSArray *)imageArr;
@property (nonatomic, copy) Block block;
@property (nonatomic, strong) UIColor *currentPageColor;
@property (nonatomic, strong) UIColor *pageColor;

@end
