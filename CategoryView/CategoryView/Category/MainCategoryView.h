//
//  MainCategoryView.h
//  TestTabView
//
//  Created by kim sunchul on 2018. 11. 3..
//  Copyright © 2018년 kim sunchul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabController.h"
#import "MainCategoryGatherView.h"
#import "MainCategorySelectBar.h"
#import "MainCategoryCurrentData.h"

NS_ASSUME_NONNULL_BEGIN

@class ViewTabData;
@protocol MainCategoryViewDelegate;
@interface MainCategoryView : CustomXibView <TabControllerDelegate, MainCategoryGatherViewDelegate> {
    TabController *tabController;
    CGFloat beforeOffsetX;
    BOOL isAnimation;
    BOOL isViewTabData;
    MainCategoryCurrentData *currentData;
    MainCategoryGatherView *gatherView;
}

@property (retain, nonatomic) NSMutableArray<NSString *> *data;
@property (retain, nonatomic) NSMutableArray<ViewTabData *> *viewTabData;
@property (assign,nonatomic) id <MainCategoryViewDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *buttonViewWidthConstraint;
@property (retain, nonatomic) IBOutlet MainCategorySelectBar *selectBar;
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
- (ViewTabData *)getSelectViewTabData;
- (NSString *)getSelectData;
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
