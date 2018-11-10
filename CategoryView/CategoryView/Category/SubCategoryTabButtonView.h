//
//  SubCategoryButtonView.h
//  Mulban
//
//  Created by kim sunchul on 2018. 10. 14..
//  Copyright © 2018년 Baek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabButtonView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubCategoryTabButtonView : TabButtonView

@property (retain, nonatomic) IBOutlet UIView *view;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UIImageView *blankImageView;

- (void)setBlankHidden:(BOOL)isHidden;

@end

NS_ASSUME_NONNULL_END
