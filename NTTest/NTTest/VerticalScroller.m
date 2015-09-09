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
    [self plotPages];
}

- (void)plotPages {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    NSLog(@"Size: %@", NSStringFromCGRect(self.frame));
    
    NSInteger pageCount = [self.dataSource numberOfSectionsInScroller];
    
    for (int i = 0; i < pageCount; i++) {
        ScrollPage *page = [[ScrollPage alloc] initWithFrame:CGRectZero];
        page.counter = [NSString stringWithFormat:@"%d",i];
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
        [self.scrollView addSubview:page];
        verticalPosition += self.frame.size.height;
    }
    [self.scrollView setContentSize:CGSizeMake(self.frame.size.width, verticalPosition)];
    [self.scrollView scrollRectToVisible:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height) animated:NO];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%f",scrollView.contentOffset.y);

    if (scrollView.contentOffset.y == 0) {
        [scrollView scrollRectToVisible:CGRectMake(0,scrollView.contentSize.height-2*scrollView.frame.size.height,self.frame.size.width,self.frame.size.height) animated:NO];
    }
    else if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {
        // user is scrolling to the right from image 4 to image 1
        // reposition offset to show image 1 that is on the left in the scroll view
        [scrollView scrollRectToVisible:CGRectMake(0,scrollView.frame.size.height,self.frame.size.width,self.frame.size.height) animated:NO];
    } 
}


@end
