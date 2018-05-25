//
//  ImgUnlimitedPlayTwoView.m
//  CycleView
//
//  Created by 雷神 on 2018/5/24.
//  Copyright © 2018年 雷神. All rights reserved.
//

#import "ImgUnlimitedPlayTwoView.h"

static const CGFloat kWidth = 300.0;
static const CGFloat kHeight = 150.0;

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
    
    _scrollVi = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _scrollVi.pagingEnabled = YES;
    _scrollVi.showsVerticalScrollIndicator = NO;
    _scrollVi.showsHorizontalScrollIndicator = NO;
    _scrollVi.delegate = self;
    [_scrollVi setContentSize:CGSizeMake(900, kHeight)];
    [self addSubview:_scrollVi];

    for (NSInteger i= 0; i < 3; i++) {
 
        UIButton *imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth * i, 0, kWidth, kHeight)];
        imgBtn.tag = i;
        if (imgBtn.tag == 1) {
            [imgBtn addTarget:self action:@selector(imgBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        }

        [_scrollVi addSubview:imgBtn];
    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(25, 120, 250, 30)];
    _pageControl.numberOfPages = _imageArray.count;
    _pageControl.currentPageIndicatorTintColor = _currentPageColor != nil ? _currentPageColor : [UIColor redColor];
    _pageControl.pageIndicatorTintColor = _pageColor != nil ? _pageColor : [UIColor whiteColor];
    [self addSubview:_pageControl];

    /*
     0 1 2 3 4
     
     4 0 1 中间显示的是第一张
     0 1 2
     1 2 3
     3 4 0
     */
    _flag = 0;
    [self refreshData:_flag];
   
    [self starTimer];
   
}

#pragma mark - timer
- (void)starTimer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeFunction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
}

//设置pageControl的CurrentPageColor
- (void)setCurrentPageColor:(UIColor *)currentPageColor {
    _currentPageColor = currentPageColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageColor;
}
//设置pageControl的pageColor
- (void)setPageColor:(UIColor *)pageColor {
    _pageColor = pageColor;
    self.pageControl.pageIndicatorTintColor = pageColor;
}

- (void)timeFunction {
    
    [_scrollVi setContentOffset:CGPointMake(2 * kWidth, 0) animated:YES];
    
}

- (void)stopTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
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

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {//自动检测scrollView是否滑动结束
    //滑动结束惯性
    if (scrollView.contentOffset.x == 2 * kWidth) {
        _flag = _flag + 1;
    } else if (scrollView.contentOffset.x == 0 * kWidth) {
        _flag = _flag - 1;
    }
  
    if (_flag < 0) {
        _flag = (-1 * _flag) % (_imageArray.count);
        _flag = _imageArray.count - _flag;
    } else {
        _flag = _flag % (_imageArray.count);
    }
    _pageControl.currentPage = _flag;
    [self refreshData:_flag];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {//手动滑动结束

    //滑动结束惯性
    if (scrollView.contentOffset.x == 2 * kWidth) {
        _flag = _flag + 1;
    } else if (scrollView.contentOffset.x == 0 * kWidth) {
        _flag = _flag - 1;
    }
 
    if (_flag < 0) {
        _flag = (-1 * _flag) % (_imageArray.count);
        _flag = _imageArray.count - _flag;
    } else {
        _flag = _flag % (_imageArray.count);
    }
    _pageControl.currentPage = _flag;
    [self refreshData:_flag];

}

- (void)refreshData:(NSInteger)flag {
  
    if (flag == 0) {
        NSInteger i = 0;
        for (UIView *view in _scrollVi.subviews) {
            UIButton *imgBtn = (UIButton *)view;
            
            if (imgBtn.tag == 0) {
                [imgBtn setImage:[UIImage imageNamed:_imageArray.lastObject] forState:UIControlStateNormal];
            } else if(imgBtn.tag == 1) {
                [imgBtn setImage:[UIImage imageNamed:_imageArray[flag]] forState:UIControlStateNormal];
                
            } else {
                [imgBtn setImage:[UIImage imageNamed:_imageArray[flag+1]] forState:UIControlStateNormal];
            }
            
            i++;
        }
    _scrollVi.contentOffset = CGPointMake(kWidth * 1, 0);
    }
    else if (flag == _imageArray.count - 1 ){
        NSInteger i = 0;
        for (UIView *view in _scrollVi.subviews) {
            UIButton *imgBtn = (UIButton *)view;
            
            if (imgBtn.tag == 0) {
                [imgBtn setImage:[UIImage imageNamed:_imageArray[flag-1]] forState:UIControlStateNormal];
            } else if(imgBtn.tag == 1) {
                [imgBtn setImage:[UIImage imageNamed:_imageArray[flag]] forState:UIControlStateNormal];
                
            } else {
                [imgBtn setImage:[UIImage imageNamed:_imageArray.firstObject] forState:UIControlStateNormal];
            }
            
            i++;
        }
        _scrollVi.contentOffset = CGPointMake(kWidth * 1, 0);
    }
    else if (flag > 0 && flag < _imageArray.count - 1){
        NSInteger i = 0;
        for (UIView *view in _scrollVi.subviews) {
            UIButton *imgBtn = (UIButton *)view;
            
            if (imgBtn.tag == 0) {
                [imgBtn setImage:[UIImage imageNamed:_imageArray[flag-1]] forState:UIControlStateNormal];
            } else if(imgBtn.tag == 1) {
                [imgBtn setImage:[UIImage imageNamed:_imageArray[flag]] forState:UIControlStateNormal];
                
            } else {
                [imgBtn setImage:[UIImage imageNamed:_imageArray[flag+1]] forState:UIControlStateNormal];
            }
            
            i++;
        }
        _scrollVi.contentOffset = CGPointMake(kWidth * 1, 0);
    } else {
        
    }
    
    
    
}

@end
