//
//  UIView+Constraint.h
//  CategoryView
//
//  Created by kim sunchul on 2018. 12. 30..
//  Copyright © 2018년 tronplay. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Constraint)

- (void)setConstraint:(UIView *)view;
- (NSLayoutConstraint *) findViewConstraint:(UIView *)view identifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
