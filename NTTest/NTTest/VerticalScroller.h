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
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (NSString *)titleForItemAtIndexPath:(NSIndexPath *)indexPath;
- (id)viewControllerForIndexPath:(NSIndexPath *)indexPath;
@end


@interface VerticalScroller : UIView
@property (nonatomic) id <VerticalScrollerDataSource> dataSource;
@property (nonatomic) BOOL animateAppearance;
- (void)reloadData;
@end
