//
//  SplashViewController.m
//  Orange
//
//  Created by 14/12/25.
//  All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *imageIphone4Array;

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

/**
 *  点击进入按钮
 */
@property (nonatomic, strong) UIButton *gotoButton;

@end

@implementation SplashViewController


- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initViews];
}

- (void)initViews
{
    self.imageArray = @[
                    @"splash_new_ipnone_1.png",
                    @"splash_new_ipnone_2.png",
                    @"splash_new_ipnone_3.png"
                    ];
    
    self.imageIphone4Array = @[
                           @"splash_new_1.png",
                           @"splash_new_2.png",
                           @"splash_new_3.png"
                           ];
    
    [self.view addSubview:self.mainScrollView];
    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.gotoButton];

    self.pageControl.hidden    = NO;
    self.gotoButton.hidden     = YES;
    
    for (int i = 0; i < self.imageArray.count; i++)
    {
        CXImageView *imageView = [[CXImageView alloc] init];
        imageView.frame = CGRectMake(SCREEN_WIDTH * i , 0 , SCREEN_WIDTH, SCREEN_HEIGHT);
        imageView.image = [UIImage imageWithName:TARGET_IPHONE_4?self.imageIphone4Array[i]:self.imageArray[i]];
        imageView.userInteractionEnabled = YES;
        [self.mainScrollView addSubview:imageView];
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    self.pageControl.currentPage = index;
    if (self.pageControl.currentPage == self.imageArray.count - 1)
    {
       self.pageControl.hidden   = NO;
       self.gotoButton.hidden    = NO;
    }
    else
    {
        self.pageControl.hidden   = NO;
        self.gotoButton.hidden    = YES;

    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

#pragma mark -- Uitility
- (void)pageTurning:(UIPageControl *)sender
{
    self.pageControl.currentPage = self.mainScrollView.contentOffset.x / self.mainScrollView.frame.size.width;
    [UIView animateWithDuration:0 animations:^{
        self.mainScrollView.contentOffset = CGPointMake(self.pageControl.currentPage * self.mainScrollView.frame.size.width, 0);
    }];
}

//立即体验
- (void)dismissButtonClickAction:(id)sender
{
    if (self.block)
    {
        self.block(nil);
    }
}

#pragma mark -- setter getter
-(UIScrollView *)mainScrollView
{
    if (_mainScrollView==nil)
    {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.imageArray.count, SCREEN_HEIGHT);
        _mainScrollView.contentOffset = CGPointMake(0, 0);
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.maximumZoomScale = 2;
        _mainScrollView.minimumZoomScale = 1;
        _mainScrollView.bounces = NO;
        _mainScrollView.delegate = self;
        _mainScrollView.backgroundColor = [UIColor clearColor];
    }
    
    return _mainScrollView;
}

-(UIPageControl *)pageControl
{
    if (_pageControl==nil)
    {
        _pageControl = [[UIPageControl alloc] init];
        if (TARGET_IPHONE_4)
        {
            _pageControl.center = CGPointMake(self.view.center.x, SCREEN_HEIGHT - 55);
        }
        else
        {
            _pageControl.center = CGPointMake(self.view.center.x, SCREEN_HEIGHT - 105);
        }
        _pageControl.numberOfPages = self.imageArray.count;
        _pageControl.currentPageIndicatorTintColor = COLOR_BLUE_NORMAL;
        _pageControl.pageIndicatorTintColor = COLOR_SILDER_BACKGROUN;
        [_pageControl addTarget:self action:@selector(pageTurning:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _pageControl;
}

-(UIButton *)gotoButton
{
    if (_gotoButton == nil)
    {
        _gotoButton = [[UIButton alloc]init];
        if (TARGET_IPHONE_4)
        {
            _gotoButton.frame = CGRectMake(83, SCREEN_HEIGHT - 140, SCREEN_WIDTH - 166, 45);
        }
        else
        {
            _gotoButton.frame = CGRectMake(83, SCREEN_HEIGHT - 220, SCREEN_WIDTH - 166, 45);
        }
        _gotoButton.titleLabel.font = FONT(15);
        [_gotoButton setTitleColor:COLOR_TITLE forState:UIControlStateNormal];
        [_gotoButton setTitleColor:COLOR_CONTENT forState:UIControlStateHighlighted];
        [_gotoButton setTitle:@"立即体验" forState:UIControlStateNormal];
        [_gotoButton addTarget:self action:@selector(dismissButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        _gotoButton.layer.masksToBounds=YES;
        _gotoButton.layer.cornerRadius= 3;
        _gotoButton.layer.borderColor=COLOR_CONTENT_ASSITANT.CGColor;
        _gotoButton.layer.borderWidth=1;
    }
    
    return _gotoButton;
}

@end
