//
//  ImgUnlimitedPlayView.m
//  CycleImage
//
//  Created by qj.huang on 2018/5/24.
//  Copyright © 2018年 qjmac. All rights reserved.
//

#import "ImgUnlimitedPlayView.h"

@interface ImgUnlimitedPlayView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollVi;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSUInteger flag;
@property (nonatomic, strong) NSArray *imageArr;

@end

@implementation ImgUnlimitedPlayView

- (instancetype)initWithFrame:(CGRect)frame withImageArr:(NSArray *)imageArr{
    
    if (self = [super initWithFrame:frame]) {
        _imageArray = [NSMutableArray arrayWithArray:imageArr];
        _imageArr = imageArr;
        [self setUpView];
    }
    
    return self;
}

- (void)setUpView {
    _scrollVi = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 100, 300, 150)];
    _scrollVi.pagingEnabled = YES;
    _scrollVi.showsVerticalScrollIndicator = NO;
    _scrollVi.showsHorizontalScrollIndicator = NO;
    _scrollVi.delegate = self;
    
    [self addSubview:_scrollVi];

    [_imageArray insertObject:self.imageArr.lastObject atIndex:0];
    [_imageArray insertObject:self.imageArr.firstObject atIndex:_imageArray.count];
    [_scrollVi setContentSize:CGSizeMake(300 * _imageArray.count, 150)];
    
    NSUInteger i = 0;
    for (NSString *img in _imageArray) {
        
        UIImageView *imgVi = [[UIImageView alloc] initWithFrame:CGRectMake(300 * i, 0, 300, 150)];
        imgVi.tag = i;
        imgVi.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [imgVi addGestureRecognizer:tap];
        imgVi.image = [UIImage imageNamed:img];
        [_scrollVi addSubview:imgVi];
        
        i++;
    }
 
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(45, 250 - 30, 300 - 50, 30)];
    _pageControl.backgroundColor = [UIColor orangeColor];
    _pageControl.numberOfPages = _imageArr.count;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [_pageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
    
    _flag = 1;
    [_scrollVi setContentOffset:CGPointMake(300 * _flag, 0) animated:NO];
    _pageControl.currentPage = _flag;
    
    [self starTimer];
}

- (void)pageControlClick:(id)sender {
//    NSLog(@"%@")
}

- (void)tapGesture:(UITapGestureRecognizer *)tap {
    UIImageView *imageVi = (UIImageView *)tap.view;
    if (imageVi.tag == 0) {
        if (_block) {
            _block(_imageArr.count - 1);
        }
    } else if (imageVi.tag == _imageArray.count - 1) {
        if (_block) {
            _block(1);
        }
    } else {
        if (_block) {
            _block(imageVi.tag);
        }
    }
}

- (void)timeFunction {
    _flag++;
    if (_flag == _imageArray.count - 1) {
        _flag = 1;
        [_scrollVi setContentOffset:CGPointMake(300, 0) animated:NO];
        _pageControl.currentPage = 1;
    } else {
        [_scrollVi setContentOffset:CGPointMake(_flag * 300, 0) animated:YES];
        _pageControl.currentPage = _flag;

    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];

}

- (void)starTimer {
    if (!_myTimer) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeFunction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_myTimer forMode:NSRunLoopCommonModes];
    }
    
}

- (void)stopTimer {
    if (_myTimer)
    {
        [_myTimer invalidate];
        _myTimer = nil;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self starTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == 0) {
        [scrollView setContentOffset:CGPointMake(300 * (_imageArray.count - 1), 0) animated:NO];
        _pageControl.currentPage = _imageArr.count - 1;
        [_pageControl updateCurrentPageDisplay];
    } else if (scrollView.contentOffset.x == 300 * (_imageArray.count - 1)) {
        [scrollView setContentOffset:CGPointMake(300, 0) animated:NO];
        _pageControl.currentPage = 1;
    } else {
        _flag = (NSUInteger)(scrollView.contentOffset.x / 300);
        _pageControl.currentPage = _flag;
    }
}

@end
