//
//  UIView+Constraint.m
//  CategoryView
//
//  Created by kim sunchul on 2018. 12. 30..
//  Copyright © 2018년 tronplay. All rights reserved.
//

#import "UIView+Constraint.h"

@implementation UIView (Constraint)

- (void)setConstraint:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.leftAnchor constraintEqualToAnchor:view.leftAnchor constant:0] setActive:YES];
    [[self.rightAnchor constraintEqualToAnchor:view.rightAnchor constant:0] setActive:YES];
    [[self.topAnchor constraintEqualToAnchor:view.topAnchor constant:0] setActive:YES];
    [[self.bottomAnchor constraintEqualToAnchor:view.bottomAnchor constant:0] setActive:YES];
}

- (NSLayoutConstraint *) findViewConstraint:(UIView *)view identifier:(NSString *)identifier{
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
