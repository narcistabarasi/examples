//
//  ViewController.m
//  NTTest
//
//  Created by Narcis Tabarasi on 09/09/15.
//  Copyright (c) 2015 ChinookBook. All rights reserved.
//

#import "ViewController.h"
#import "VerticalScroller.h"

@interface ViewController () <VerticalScrollerDataSource>
@property (nonatomic, retain) VerticalScroller *scroller;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scroller = [VerticalScroller new];
    self.scroller.dataSource = self;
    self.scroller.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scroller];
    
    NSMutableDictionary *views = [NSMutableDictionary new];
    views[@"scroller"] = self.scroller;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-50-[scroller]-50-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[scroller]-50-|" options:0 metrics:nil views:views]];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.scroller reloadData];
}

- (NSInteger)numberOfSectionsInScroller {
    return 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
