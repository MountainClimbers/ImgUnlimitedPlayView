//
//  ImgUnlimitedPlayTwoView.m
//  CycleView
//
//  Created by 雷神 on 2018/5/24.
//  Copyright © 2018年 雷神. All rights reserved.
//

#import "ImgUnlimitedPlayTwoView.h"
@interface ImgUnlimitedPlayTwoView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollVi;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end
@implementation ImgUnlimitedPlayTwoView

- (instancetype)initWithFrame:(CGRect)frame withImageArr:(NSArray *)imageArr{
    
    if (self = [super initWithFrame:frame]) {
        _imageArray = [NSMutableArray arrayWithArray:imageArr];
        [self setUpView];
        
    }
    
    return self;
}

- (void)setUpView {
    
    _scrollVi = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
    _scrollVi.pagingEnabled = YES;
    _scrollVi.showsVerticalScrollIndicator = NO;
    _scrollVi.showsHorizontalScrollIndicator = NO;
    _scrollVi.delegate = self;
    [_scrollVi setContentSize:CGSizeMake(900, 150)];
    [self addSubview:_scrollVi];

    for (NSInteger i= 0; i < 3; i++) {
 
        UIButton *imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(300 * i, 0, 300, 150)];
        [imgBtn addTarget:self action:@selector(imgBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [imgBtn setImage:[UIImage imageNamed:_imageArray.lastObject] forState:UIControlStateNormal];

        } else {
            [imgBtn setImage:[UIImage imageNamed:_imageArray[i]] forState:UIControlStateNormal];

        }
        [_scrollVi addSubview:imgBtn];
    }
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(25, 120, 250, 30);
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.numberOfPages = _imageArray.count;
    [self addSubview:_pageControl];

    [self starTimer];
    
}

- (void)starTimer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timeFunction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimer {
        [_timer invalidate];
        _timer = nil;
}

- (void)timeFunction {
    _flag++;
    if (_flag == _imageArray.count) {
        _flag = 0;
    }
    /*
     到下一页去了
     */
    [_scrollVi setContentOffset:CGPointMake(2 * 300, 0) animated:YES];

    
}

- (void)imgBtnTap:(UIButton *)btn {
    if (_block) {
        _block(_flag);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self starTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {


}


@end
