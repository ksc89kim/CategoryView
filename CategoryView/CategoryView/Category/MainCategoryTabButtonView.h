//
//  MainCategoryTabButtonView.h
//  TestTabView
//
//  Created by kim sunchul on 2018. 11. 3..
//  Copyright © 2018년 kim sunchul. All rights reserved.
//

#import "TabButtonView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainCategoryTabButtonView : TabButtonView

@property (retain, nonatomic) IBOutlet UIView *view;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) NSLayoutConstraint *viewWidthConstraint;

- (void)setTabSelected:(BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
