//
//  AutoHeightLabel.m
//  Mulban
//
//  Created by icenv_89 on 22/10/2018.
//  Copyright © 2018 Baek. All rights reserved.
//

#import "AutoHeightLabel.h"

@implementation AutoHeightLabel

@synthesize viewHeightConstraint;

- (void)dealloc {
    [self.viewHeightConstraint release];
    [super dealloc];
}

- (instancetype)init
{
    self = [self initWithFrame:[[[UIApplication sharedApplication] keyWindow] bounds]];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setHeight];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setHeight];
    }
    return self;
}

#pragma mark - Set Funtion

- (void) setHeight {
    self.viewHeightConstraint = [self findViewHeightConstraint];
    _baseHeight = [self.viewHeightConstraint constant];
}

#pragma mark - Find Funtion

- (NSLayoutConstraint *) findViewHeightConstraint {
    return [self findViewConstraint:self identifier:AUTOHEIGHTLABELCONSTRAINT];
}

@end
