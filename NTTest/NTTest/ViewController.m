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
    self.scroller.animateAppearance = YES;
    self.scroller.dataSource = self;
    self.scroller.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scroller];
    
    NSMutableDictionary *views = [NSMutableDictionary new];
    views[@"scroller"] = self.scroller;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[scroller]-50-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[scroller]-80-|" options:0 metrics:nil views:views]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.scroller reloadData];
}

- (NSInteger)numberOfSectionsInScroller {
    return 2;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 4;
        case 1: return 5;
        default: return 0;
    }
}

-(NSString *)titleForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0: return @"S0 R0";
                case 1: return @"S0 R1";
                case 2: return @"S0 R2";
                case 3: return @"S0 R3";
                default: return @"";
            }
            break;
        }
        case 1:
        {
            switch (indexPath.row) {
                case 0: return @"S1 R0";
                case 1: return @"S1 R1";
                case 2: return @"S1 R2";
                case 3: return @"S1 R3";
                case 4: return @"S1 R4";
                default: return @"";
            }
            break;
            break;
        }
        default:
            return @"";
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
