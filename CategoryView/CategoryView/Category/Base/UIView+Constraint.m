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
