//
//  MainCategoryView.h
//  TestTabView
//
//  Created by kim sunchul on 2018. 11. 3..
//  Copyright © 2018년 kim sunchul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabController.h"
#import "MainCategoryTabButtonView.h"
#import "MainCategoryGatherView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MainCategoryPagerScrollDirection) {
    NoneDirection,
    LeftDirection,
    RightDirection
};

@class ViewTabData;
@protocol MainCategoryViewDelegate;
@interface MainCategoryView : UIView <TabControllerDelegate, MainCategoryGatherViewDelegate> {
    TabController *tabController;
    CGFloat beforeOffsetX;
    BOOL isAnimation;
    CGFloat currentOffsetX;
    NSInteger currentIndex;
    CGFloat currentScrollPercent;
    MainCategoryTabButtonView *currentTabView;
    BOOL isViewTabData;
    MainCategoryGatherView *gatherView;
}

@property (retain, nonatomic) IBOutlet UIView *view;
@property (retain, nonatomic) NSMutableArray<NSString *> *data;
@property (retain, nonatomic) NSMutableArray<ViewTabData *> *viewTabData;
@property (nonatomic, assign) id <MainCategoryViewDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *buttonViewWidthConstraint;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *selectBarWidthConstraint;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *selectBarLeftConstraint;
@property (retain, nonatomic) UIScrollView *pagerScollView;
@property (assign, nonatomic) BOOL isFitTextWidth;
@property (assign, nonatomic) NSInteger maxShowCount;
@property (assign, nonatomic) NSInteger selectIndex;
@property (retain, nonatomic) IBOutlet UIButton *actionButton;
@property (retain, nonatomic) IBOutlet UIView *gatherTitleView;
@property (retain, nonatomic) IBOutlet UILabel *gatherTitleLabel;
@property (retain, nonatomic) IBOutlet UIView *topLine;
@property (retain, nonatomic) IBOutlet UIImageView *shadowImageView;

- (void)setGatherButtonHidden:(BOOL)hidden;
- (void)updatePagerScrollView;
- (void)startScrollAnimation;
- (ViewTabData *)getCurrentViewTabData;
- (NSString *)getCurrentData;
- (void)openGatherView:(BOOL)isAnimation;
- (void)closeGatherView:(BOOL)isAnimation;

@end

@protocol MainCategoryViewDelegate <NSObject>

@optional
- (void)didSelectMainCategoryTab:(MainCategoryView *)view data:(NSString *)data;
- (void)didSelectMainCategoryTab:(MainCategoryView *)view viewTabData:(ViewTabData *)data;
- (void)didSelectMainCategoryTab:(MainCategoryView *)view index:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
