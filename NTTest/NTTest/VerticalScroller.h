//
//  VerticalScroller.h
//  NTTest
//
//  Created by Narcis Tabarasi on 09/09/15.
//  Copyright (c) 2015 ChinookBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VerticalScrollerDataSource <NSObject>
- (NSInteger)numberOfSectionsInScroller;
@end


@interface VerticalScroller : UIView
@property (nonatomic) id <VerticalScrollerDataSource> dataSource;
- (void)reloadData;
@end
