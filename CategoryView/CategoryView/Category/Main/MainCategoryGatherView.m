//
//  MainCategoryGatherView.m
//  Mulban
//
//  Created by icenv_89 on 07/11/2018.
//  Copyright © 2018 Baek. All rights reserved.
//

#import "MainCategoryGatherView.h"
#import "MainCategoryGatherTabButtonView.h"

#define HORIZONAL_COUNT 3
#define TABVIEW_HEIGHT 36

@interface MainCategoryGatherView()

- (void)setViewHeight;
- (void)removeAllHorizontalStackView;
- (void)createAllHorizontalView;
- (UIStackView *)createBlankHorizontalView:(NSMutableArray <id<MainCategoryData>>*)dataArray;
- (UIStackView *)createHorizontalStackView:(NSMutableArray <id<MainCategoryData>>*)dataArray;
- (MainCategoryGatherTabButtonView * )createTabView:(NSString *)title;
- (BOOL)isCreateHorizontalStackView:(NSInteger)index;
- (NSInteger)getViewHeight;

@end

@implementation MainCategoryGatherView

- (void)dealloc {
    [_dimButton release];
    [tabController release];
    [_mainStackView release];
    [_viewHeightConstraint release];
    [_viewBottomConstraint release];
    [_viewTopConstraint release];
    [tabViewArray release];
    [super dealloc];
}

- (void)setController {
    [super setController];
    
    tabController = [[TabController alloc] init];
    [tabController setDelegate:self];
    
    tabViewArray = [[NSMutableArray alloc] init];
}

- (void)setUI {
    [super setUI];
}

- (void)setEvent{
    [super setEvent];
    [_dimButton addTarget:self action:@selector(onDim:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelectIndex:(NSInteger)index {
    [tabController selectTabIndex:index];
}

-(void)updateUI {
    [tabViewArray removeAllObjects];
    [self removeAllHorizontalStackView];
    [self createAllHorizontalView];
    [self setViewHeight];
    [tabController setTabs:YES tabs:tabViewArray];
}

- (void)setViewHeight {
    [_viewHeightConstraint setConstant:[self getViewHeight]];
    beforeViewHeight = [_viewHeightConstraint constant];
}

- (void)removeAllHorizontalStackView {
    for (UIView *subView in [_mainStackView arrangedSubviews]) {
        [subView removeFromSuperview];
    }
}

- (void)createAllHorizontalView {
    NSMutableArray<id<MainCategoryData>> *horizontalDataArray = [NSMutableArray array];
    
    for (int i=0; i<[_controller count]; i++) {
        id<MainCategoryData> data = [_controller dataAtIndex:i];
        [horizontalDataArray addObject:data];
        
        if ([self isCreateHorizontalStackView:i+1]) {
            UIStackView *horizontalStackView = [self createHorizontalStackView:horizontalDataArray];
            [_mainStackView addArrangedSubview:horizontalStackView];
            [horizontalDataArray removeAllObjects];
        }
    }
    
    UIStackView *horizontalStackView = [self createBlankHorizontalView:horizontalDataArray];
    [_mainStackView addArrangedSubview:horizontalStackView];
}

- (UIStackView *)createBlankHorizontalView:(NSMutableArray <id<MainCategoryData>>*)dataArray {
    UIStackView *horizontalStackView = [self createHorizontalStackView:dataArray];
    NSInteger remainCount = HORIZONAL_COUNT - dataArray.count;
    if (remainCount == 0) {
        return horizontalStackView;
    }
    
    for (int i=0;i<remainCount;i++) {
        [horizontalStackView addArrangedSubview:[[[UIView alloc] init] autorelease]];
    }
    
    return horizontalStackView;
}

- (UIStackView *)createHorizontalStackView:(NSMutableArray <id<MainCategoryData>>*)dataArray{
    UIStackView *horizontalStackView = [[[UIStackView alloc] init] autorelease];
    horizontalStackView.axis = UILayoutConstraintAxisHorizontal;
    horizontalStackView.distribution = UIStackViewDistributionFillEqually;
    horizontalStackView.spacing = 6;
    
    for (int i=0;i<dataArray.count;i++) {
        MainCategoryGatherTabButtonView *tabView = [self createTabView:[[dataArray objectAtIndex:i] getTitle]];
        [tabViewArray addObject:tabView];
        [horizontalStackView addArrangedSubview:tabView];
    }
    
    return horizontalStackView;
}

- (MainCategoryGatherTabButtonView * )createTabView:(NSString *)title {
    MainCategoryGatherTabButtonView *tabView =  [[[MainCategoryGatherTabButtonView alloc] init] autorelease];
    [tabView.titleLabel setText:title];
    return tabView;
}

- (BOOL)isCreateHorizontalStackView:(NSInteger)index{
    return (index % HORIZONAL_COUNT == 0) && index > 0;
}

- (NSInteger)getViewHeight {
    NSInteger mainStackViewHeight = _mainStackView.arrangedSubviews.count * (TABVIEW_HEIGHT + _mainStackView.spacing);
    return mainStackViewHeight + _viewTopConstraint.constant + _viewBottomConstraint.constant;
}

#pragma mark - Event Function

- (void)onDim:(UIButton *)button {
   [self setHidden:YES];
    if ([_delegate respondsToSelector:@selector(touchGatherViewDimLayer)]) {
        [_delegate touchGatherViewDimLayer];
    }
}

- (void)touchTab:(TabController *)tabController selectedButtonView:(TabButtonView *)buttonView {
    [self setHidden:YES];
    if ([_delegate respondsToSelector:@selector(didSelectTab:index:)]) {
        [_delegate didSelectTab:self index:[buttonView tag]];
    }
}

#pragma mark - Animation Function

- (void)openAnimation {
    [self setHidden:NO];
    [_viewHeightConstraint setConstant:0];
    [self layoutIfNeeded];

    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^(void) {
                         [_viewHeightConstraint setConstant:beforeViewHeight];
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                     }];

}

- (void)closeAnimation {
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^(void) {
                         [_viewHeightConstraint setConstant:0];
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         [self setHidden:YES];
                     }];
}

@end
