//
//  MainCategoryTabButtonView.h
//  TestTabView
//
//  Created by kim sunchul on 2018. 11. 3..
//  Copyright © 2018년 kim sunchul. All rights reserved.
//

#import "TabButtonView.h"
#import "UIView+Constraint.h"

NS_ASSUME_NONNULL_BEGIN

/*
    메인카테고리의 탭 버튼 뷰
 */

@interface MainCategoryTabButtonView : TabButtonView

@property (retain, nonatomic) IBOutlet UIView *view;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) NSLayoutConstraint *viewWidthConstraint;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

- (void)setTabSelected:(BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
