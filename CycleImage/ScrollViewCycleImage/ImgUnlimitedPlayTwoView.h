//
//  ImgUnlimitedPlayTwoView.h
//  CycleView
//
//  Created by 雷神 on 2018/5/24.
//  Copyright © 2018年 雷神. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Block)(NSInteger flag);

@interface ImgUnlimitedPlayTwoView : UIView

- (instancetype)initWithFrame:(CGRect)frame withImageArr:(NSArray *)imageArr;
@property (nonatomic, copy) Block block;
@property (nonatomic, strong) UIColor *currentPageColor;
@property (nonatomic, strong) UIColor *pageColor;

@end
