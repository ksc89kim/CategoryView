//
//  MainCategoryGatherTabButtonView.h
//  Mulban
//
//  Created by icenv_89 on 08/11/2018.
//  Copyright © 2018 Baek. All rights reserved.
//

#import "TabButtonView.h"

NS_ASSUME_NONNULL_BEGIN

/*
    메인카테고리의 모아보기 탭 뷰
 */
@interface MainCategoryGatherTabButtonView : TabButtonView

@property (retain, nonatomic) IBOutlet UIView *view;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
