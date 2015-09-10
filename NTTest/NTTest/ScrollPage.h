//
//  ScrollPage.h
//  NTTest
//
//  Created by Narcis Tabarasi on 09/09/15.
//  Copyright (c) 2015 ChinookBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollPage : UIView
@property (nonatomic) NSInteger sectionIndex;
@property (nonatomic) NSInteger numberOfItems;
@property (nonatomic, retain) NSString *counter;
@property (nonatomic, retain) NSMutableArray *indexPaths;
- (void)plot;
@end
