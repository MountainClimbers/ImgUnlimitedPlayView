//
//  ImgUnlimitedPlayView.h
//  CycleImage
//
//  Created by qj.huang on 2018/5/24.
//  Copyright © 2018年 qjmac. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 3 1 2 3 1
 3 1 2 3
 1 2 3 1
 timer
 pageController
 封装,接口 点的颜色 图片资源 点击事件
 */

typedef void(^ImgUnlimitedPlayViewBlock)(NSInteger flag);

@interface ImgUnlimitedPlayView : UIView

@property (nonatomic, strong) UIColor *pageColor;
@property (nonatomic, copy) ImgUnlimitedPlayViewBlock block;

- (instancetype)initWithFrame:(CGRect)frame withImageArr:(NSArray *)imageArr;

@end
