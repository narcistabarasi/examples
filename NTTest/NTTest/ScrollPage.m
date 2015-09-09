//
//  ScrollPage.m
//  NTTest
//
//  Created by Narcis Tabarasi on 09/09/15.
//  Copyright (c) 2015 ChinookBook. All rights reserved.
//

#import "ScrollPage.h"

@interface ScrollPage ()
@property (nonatomic, retain) UILabel *label;
@end

@implementation ScrollPage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.backgroundColor = [self generateBGColor];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [self generateBGColor];
    }
    return self;
}


- (UILabel *)label {
    if (_label == nil) {
        self.label = [UILabel new];
        self.label.translatesAutoresizingMaskIntoConstraints = NO;
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        NSDictionary *dict = @{@"label":self.label};
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|" options:0 metrics:nil views:dict]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label]|" options:0 metrics:nil views:dict]];
    }
    return _label;
}

- (void)setCounter:(NSString *)counter {
    _counter = counter;
    self.label.text = _counter;
}


- (UIColor *)generateBGColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    return color;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.counter = [coder decodeObjectForKey:@"counter"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
    [coder encodeObject:self.counter forKey:@"counter"];
    
}

@end
