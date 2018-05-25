//
//  ImgUnlimitedPlayTwoView.h
//  CycleView
//
//  Created by 雷神 on 2018/5/24.
//  Copyright © 2018年 雷神. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 _flag = 0
 
 _flag--
 if _flag< 0
 _flag = imageArr.count - 1
 qian _flag--
 */
typedef void(^Block)(NSInteger flag);

@interface ImgUnlimitedPlayTwoView : UIView
- (instancetype)initWithFrame:(CGRect)frame withImageArr:(NSArray *)imageArr;
@property (nonatomic, copy) Block block;
@end
