//
//  CustomXibView.h
//  CategoryView
//
//  Created by kim sunchul on 2018. 12. 30..
//  Copyright © 2018년 tronplay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Constraint.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomXibView : UIView {
    UIView *view;
}

@property (retain, nonatomic) IBOutlet UIView *view;

- (void)setUI;
- (void)setController;
- (void)setEvent;

@end

NS_ASSUME_NONNULL_END
