//
//  MainCategoryView.h
//  TestTabView
//
//  Created by kim sunchul on 2018. 11. 3..
//  Copyright © 2018년 kim sunchul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainCategoryGatherView.h"
#import "MainCategorySelectBar.h"
#import "MainCategoryCurrentData.h"
#import "MainCategoryCollectionViewCell.h"
#import "MainCategoryCellController.h"

NS_ASSUME_NONNULL_BEGIN

/*
    메인 카테고리 뷰
    - 카테고리에 해당하는 뷰들을 구성 및 스크롤 애니메이션을 가지고 있음.
    - 오른쪽 버튼 모아보기 버튼이 있으며, 모아보기 클래스를 통제함.
 */
@protocol MainCategoryViewDelegate;
@interface MainCategoryView : CustomXibView <MainCategoryGatherViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    CGFloat beforeOffsetX;
    BOOL isAnimation;
    MainCategoryCurrentData *currentData;
    MainCategoryGatherView *gatherView;
    MainCategoryCellController *controller;
}

@property (assign,nonatomic) id <MainCategoryViewDelegate> delegate;
@property (retain, nonatomic) IBOutlet UICollectionView *collectionView;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *buttonViewWidthConstraint;
@property (retain, nonatomic) IBOutlet UIScrollView *selectScrollView;
@property (retain, nonatomic) IBOutlet MainCategorySelectBar *selectBar;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;
@property (retain, nonatomic) UIScrollView *pagerScollView;
@property (assign, nonatomic) NSInteger selectIndex;
@property (retain, nonatomic) IBOutlet UIButton *actionButton;
@property (retain, nonatomic) IBOutlet UIView *gatherTitleView;
@property (retain, nonatomic) IBOutlet UILabel *gatherTitleLabel;
@property (retain, nonatomic) IBOutlet UIView *topLine;
@property (retain, nonatomic) IBOutlet UIImageView *shadowImageView;


- (void)setGatherButtonHidden:(BOOL)hidden;
- (id<MainCategoryController>)getController;
- (id<MainCategoryData>)getSelectedData;

- (void)updatePagerScrollView;
- (void)startScrollAnimation;
- (void)openGatherView:(BOOL)isAnimation;
- (void)closeGatherView:(BOOL)isAnimation;
- (void)updateUI;

@end

@protocol MainCategoryViewDelegate <NSObject>
@optional
- (void)didSelectMainCategoryTab:(MainCategoryView *)view data:(id<MainCategoryData>)data;
- (void)didSelectMainCategoryTab:(MainCategoryView *)view index:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
