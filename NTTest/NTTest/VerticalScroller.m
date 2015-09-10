//
//  VerticalScroller.m
//  NTTest
//
//  Created by Narcis Tabarasi on 09/09/15.
//  Copyright (c) 2015 ChinookBook. All rights reserved.
//

#import "VerticalScroller.h"
#import "ScrollPage.h"
#import "UIView+Clone.h"

@interface VerticalScroller () <UIScrollViewDelegate>
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *pages;
@end

@implementation VerticalScroller

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.scrollView = [UIScrollView new];
        self.scrollView.delegate = self;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.scrollView];
        
        NSDictionary *views = @{@"scrollView":self.scrollView};
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:nil views:views]];
        
        self.pages = [NSMutableArray new];
    }
    return self;
}

- (void)reloadData {
    if (self.animateAppearance) {
        self.animateAppearance = NO;
        self.transform = CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.1 options:0 animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {}];
    }
    [self plotPages];
}

- (void)plotPages {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    for (id subview in self.scrollView.subviews) {
        if ([subview isKindOfClass:[UIView class]]) {
            [(UIView *)subview removeFromSuperview];
        }
    }
    [self.scrollView setContentSize:CGSizeZero];
    [self.pages removeAllObjects];
    
    NSInteger pageCount = [self.dataSource numberOfSectionsInScroller];
    for (NSInteger i = 0; i < pageCount; i++) {
        ScrollPage *page = [[ScrollPage alloc] initWithFrame:CGRectZero];
        page.sectionIndex = i;
        page.numberOfItems = [self.dataSource numberOfItemsInSection:i];
        page.counter = [NSString stringWithFormat:@"%ld",[self.dataSource numberOfItemsInSection:i]];
        [self.pages addObject:page];
    }
    
    ScrollPage *firstPage = [self.pages[0] clone];
    ScrollPage *lastPage = [[self.pages lastObject] clone];
    
    [self.pages insertObject:lastPage atIndex:0];
    [self.pages addObject:firstPage];
    
    CGFloat verticalPosition = 0.0f;
    for (int i = 0; i<self.pages.count; i++) {
        ScrollPage *page = self.pages[i];
        [page setFrame:CGRectMake(0, verticalPosition, self.frame.size.width, self.frame.size.height)];
        [page plot];
        [self.scrollView addSubview:page];
        verticalPosition += self.frame.size.height;
    }
    [self.scrollView setContentSize:CGSizeMake(self.frame.size.width, verticalPosition)];
    [self.scrollView scrollRectToVisible:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height) animated:NO];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    
    CGFloat currentPage = scrollView.contentOffset.y / self.frame.size.height - 1;
    NSLog(@"offset: %.2f -- page: %.2f rounded: %ld",scrollView.contentOffset.y, currentPage, [self getCurrentPageFromOffset:scrollView.contentOffset.y]);
}

-(NSInteger)getCurrentPageFromOffset:(CGFloat)offset {
    CGFloat currentPage = offset / self.frame.size.height - 1;
    NSInteger theoreticalPage = lroundf(currentPage);
    
    
    
    return lroundf(currentPage);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y == 0) {
        [scrollView scrollRectToVisible:CGRectMake(0,scrollView.contentSize.height-2*scrollView.frame.size.height,self.frame.size.width,self.frame.size.height) animated:NO];
    }
    else if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {
        [scrollView scrollRectToVisible:CGRectMake(0,scrollView.frame.size.height,self.frame.size.width,self.frame.size.height) animated:NO];
    } 
}


@end
