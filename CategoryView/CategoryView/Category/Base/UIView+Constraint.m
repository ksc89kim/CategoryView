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
    [[self.widthAnchor constraintEqualToAnchor:view.widthAnchor constant:0] setActive:YES];
    [[self.heightAnchor constraintEqualToAnchor:view.heightAnchor constant:0] setActive:YES];
    [[self.centerXAnchor constraintEqualToAnchor:view.centerXAnchor constant:0] setActive:YES];
    [[self.centerYAnchor constraintEqualToAnchor:view.centerYAnchor constant:0] setActive:YES];
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
