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
    [self setConstraintHeight:height];
}

- (void)setConstraint:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    //xib view autolayout setting
    NSLayoutConstraint *viewWidth =  [NSLayoutConstraint constraintWithItem:view
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1
                                                                   constant:0];
    
    
    NSLayoutConstraint *viewHeight =  [NSLayoutConstraint constraintWithItem:view
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeHeight
                                                                  multiplier:1
                                                                    constant:0];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:view
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1
                                                                constant:0];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:view
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1
                                                                constant:0];
    
    [self addConstraints:[NSArray arrayWithObjects:viewWidth,viewHeight,centerX,centerY,nil]];

    self.viewHeightConstraint = [self findViewHeightConstraint];
    if(self.viewHeightConstraint == nil) {
        self.viewHeightConstraint =  [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1
                                                                   constant:0];
        self.viewHeightConstraint.identifier = AUTOHEIGHTCONSTRAINT;
        self.viewHeightConstraint.priority = 999;
        [self addConstraint:self.viewHeightConstraint];
    }
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
    return [self findViewHeightConstraint:self identifier:AUTOHEIGHTCONSTRAINT];
}

- (NSLayoutConstraint *) findViewHeightConstraint:(UIView *)view identifier:(NSString *)identifier{
    NSLayoutConstraint *findConstraint = nil;
    for(NSLayoutConstraint *cons in view.constraints)   {
        if ([cons.identifier isEqualToString:identifier]) {
            findConstraint = cons;
            break;
        }
    }
    return findConstraint;
}


@end
