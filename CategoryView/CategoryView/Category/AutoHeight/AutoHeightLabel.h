//
//  AutoHeightLabel.h
//  Mulban
//
//  Created by icenv_89 on 22/10/2018.
//  Copyright © 2018 Baek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Constraint.h"

#define AUTOHEIGHTLABELCONSTRAINT @"autoHeightLabelConstraint"

NS_ASSUME_NONNULL_BEGIN

@interface AutoHeightLabel : UILabel {
    NSLayoutConstraint *viewHeightConstraint;
}

@property (retain, nonatomic) NSLayoutConstraint *viewHeightConstraint;
@property (assign, nonatomic) CGFloat baseHeight;

@end

NS_ASSUME_NONNULL_END
