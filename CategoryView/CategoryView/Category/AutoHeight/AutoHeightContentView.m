//
//  AutoHeightContentView.m
//  Mulban
//
//  Created by kim sunchul on 2018. 9. 25..
//  Copyright © 2018년 Baek. All rights reserved.
//

#import "AutoHeightContentView.h"

@implementation AutoHeightContentView

@synthesize viewHeightConstraint;

- (void)dealloc {
    [self.viewHeightConstraint release];
    [autoHeightLabels release];
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
        [self setAutoHeightLabels];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setAutoHeightLabels];
    }
    return self;
}

- (void)initHeight:(UIView *)xibView {
    [self setConstraint:xibView];
}

- (void)initHeight:(UIView *)xibView height:(CGFloat)height {
    [self setConstraint:xibView height:height];
}

#pragma mark - Set Funtion

- (void) setAutoHeightLabels {
    autoHeightLabels = [[NSMutableArray alloc] init];
}


- (void)setConstraint:(UIView *)view height:(CGFloat)height {
    [self setConstraint:view];
    
    self.viewHeightConstraint = [self findViewHeightConstraint];
    if(self.viewHeightConstraint == nil) {
        self.viewHeightConstraint =  [self.heightAnchor constraintEqualToConstant:0];
        self.viewHeightConstraint.identifier = AUTOHEIGHTCONSTRAINT;
        self.viewHeightConstraint.priority = 750;
        [self.viewHeightConstraint setActive:true];
    }
    
    [self setConstraintHeight:height];
}

- (void)setConstraintHeight:(CGFloat)height {
    [self.viewHeightConstraint setConstant:height];
}

#pragma mark - Get Funtion
- (CGFloat) getContentViewHeight{
    [self refreshAutoLabels];
    if (![self isHidden]) {
        return [self.viewHeightConstraint constant];
    }
    return 0;
}

#pragma mark - AutoLabel Function

- (void)addAutoLabel:(AutoHeightLabel *)label {
    [autoHeightLabels addObject:label];
}

- (void) refreshAutoLabels {
    if (![self isHidden]) {
        for (AutoHeightLabel *label in autoHeightLabels) {
            [self setLabelWithHeight:label];
        }
    }
}

- (void)setLabelWithHeight:(AutoHeightLabel *)label{
    CGFloat willHeight = [self getStringHeight:label];
    CGFloat finalHeight = 0;
    finalHeight =  [self.viewHeightConstraint constant] - [label.viewHeightConstraint constant] + willHeight;
    [self setConstraintHeight:finalHeight];
    [label.viewHeightConstraint setConstant:willHeight];
}

- (CGFloat)getStringHeight:(UILabel *)label {
    CGRect rect = [label.attributedText boundingRectWithSize:CGSizeMake(floor(label.frame.size.width), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return floor(rect.size.height) + 3;
}

#pragma mark - Find Funtion

- (NSLayoutConstraint *) findViewHeightConstraint {
    return [self findViewConstraint:self identifier:AUTOHEIGHTCONSTRAINT];
}

@end
