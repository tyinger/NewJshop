//
//  FYTXGEView.m
//  FYTXGuide
//
//  Created by tiger on 15/6/10.
//  Copyright (c) 2015年 tiger. All rights reserved.
//

#import "FYTXGEView.h"
#import "FYTXGERecordModel.h"



@interface FYTXGEView()<UIScrollViewDelegate>
@property(nonatomic, strong)UIScrollView                *scrollView;
@property(nonatomic, strong)UIPageControl               *pageControl;

@property(nonatomic, assign)CGFloat                     maxcontentSizeWidth;


@property(nonatomic, assign)BOOL            flag;           //判断最后一页 flag   限制只发一次

@end

@implementation FYTXGEView

- (void)dealloc{
    NSLog(@"%s", __FUNCTION__);
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initScrollView];
        [self initPageControl];
    }
    return self;
}




-(void) initScrollView
{
    self.scrollView = [[UIScrollView alloc] init];
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    UIView *pview = self;
    UIScrollView *sview = _scrollView;
    
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:sview attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:pview attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:sview attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:pview attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];

    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:sview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:pview attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];

    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:sview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:pview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    [pview addConstraint:leading];
    [pview addConstraint:trailing];
    [pview addConstraint:top];
    [pview addConstraint:bottom];    
}

-(void) initPageControl
{
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];
    
    UIView *pview = self;
    UIPageControl *sview = _pageControl;
        
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:sview attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:pview attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:sview attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:pview attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    
    NSLayoutConstraint *h = [NSLayoutConstraint constraintWithItem:sview attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:sview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:pview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    [pview addConstraint:leading];
    [pview addConstraint:trailing];
    [pview addConstraint:h];
    [pview addConstraint:bottom];
    
}



/**
 *  设置 _scrollView 图片
 *
 *  @param images
 */
-(void) loadImageWithArray:(NSArray *)images
{
    
    if (images.count <= 0) {
        return;
    }
    
    
    _pageControl.numberOfPages = images.count;
    float w = [UIScreen mainScreen].bounds.size.width;
    float h = [UIScreen mainScreen].bounds.size.height;
    
    //多出一页
    _scrollView.contentSize = CGSizeMake(w*images.count+w, h);
    _maxcontentSizeWidth = w*(images.count-1);  //限制最后一页
    
    for (int i=0; i<images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[images objectAtIndex:i]];
//        imageView.frame = CGRectMake(i*w, 0, imageView.frame.size.width, imageView.frame.size.height);
        imageView.frame = CGRectMake(i*w, 0, w, h);
        
        [_scrollView addSubview:imageView];
        
        if (2==i) {
            UIButton *whiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [whiteButton setFrame: CGRectMake(i*w, h/2.0, w, h/2)];
            [whiteButton addTarget:self action:@selector(scrollBeyondAction) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:whiteButton];
            
        }
    }
}
















#pragma mark scrollView delegate


/**
 *  禁止第一页右划
 *
 *  @param scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //超过最后一页回调
    if (scrollView.contentOffset.x > _maxcontentSizeWidth ) {
        [scrollView setContentOffset:CGPointMake(_maxcontentSizeWidth, scrollView.contentOffset.y) animated:NO];        
        
        [self scrollBeyondAction];
        
        return;
    }
    
    
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
    
}



/**
 *  计算分页  同时更新 _pageControl的页码
 *
 *  @param scrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{    
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
}












#pragma mark 业务逻辑 (目前暂时没时间挪出去 先改成这样，友盟放到 其它地方

/**
 *  滑动到最后一页的时候新加一个 uiviewController
 */
-(void) scrollBeyondAction
{
    /**
     *  限制只发一次
     */
    if (!_flag) {
        _flag = YES;
        [FYTXGERecordModel saveOpenFlag];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"JLShopGuideFinishGoToMain" object:nil];
    }
}




















@end











