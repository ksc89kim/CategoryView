//
//  MainCategoryGatherView.h
//  Mulban
//
//  Created by icenv_89 on 07/11/2018.
//  Copyright © 2018 Baek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoHeightStackView.h"
#import "TabController.h"
#import "CustomXibView.h"
#import "MainCategoryController.h"

NS_ASSUME_NONNULL_BEGIN

/*
    메인카테고리의 모아보기 뷰
    - 메인 카테고리에 있는 탭 버튼들을 한번에 모아볼수 있게 만듬.
 */
@protocol MainCategoryGatherViewDelegate;

@interface MainCategoryGatherView : CustomXibView <TabControllerDelegate> {
    TabController *tabController;
    NSMutableArray *tabViewArray;
    CGFloat beforeViewHeight;
}

@property (assign, nonatomic) id <MainCategoryController> controller;
@property (nonatomic, assign) id <MainCategoryGatherViewDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIButton *dimButton;
@property (retain, nonatomic) IBOutlet UIStackView *mainStackView;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *viewHeightConstraint;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *viewBottomConstraint;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *viewTopConstraint;

- (void)setSelectIndex:(NSInteger)index;
- (void)openAnimation;
- (void)closeAnimation;
- (void)updateUI;

@end

@protocol  MainCategoryGatherViewDelegate <NSObject>

- (void)didSelectTab:(MainCategoryGatherView *)view index:(NSInteger)index;
- (void)touchGatherViewDimLayer;

@end

NS_ASSUME_NONNULL_END
