//
//  MainCategoryView.m
//  TestTabView
//
//  Created by kim sunchul on 2018. 11. 3..
//  Copyright © 2018년 kim sunchul. All rights reserved.
//

#import "MainCategoryView.h"
#import "ViewTabData.h"

@implementation MainCategoryView

- (void)dealloc {
    [_data release];
    [_viewTabData release];
    [_contentView release];
    [_buttonViewWidthConstraint release];
    [_contentViewWidthConstraint release];
    [_scrollView release];
    [tabController release];
    [_pagerScollView release];
    [_actionButton release];
    [gatherView release];
    [_gatherTitleView release];
    [_gatherTitleLabel release];
    [_topLine release];
    [_shadowImageView release];
    [_selectBar release];
    [currentData release];
    [super dealloc];
}

#pragma mark - Set Function

- (void)setController {
    [super setController];
    tabController = [[TabController alloc] init];
    [tabController setDelegate:self];
    
    if (currentData == nil) {
        currentData = [[MainCategoryCurrentData alloc] init];
    }
}

- (void)setUI {
    [super setUI];
    _maxShowCount = 5;
    [self setGatherUI];
}

- (void)setEvent {
    [super setEvent];
    [_actionButton addTarget:self action:@selector(onGatherView:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setGatherUI {
    gatherView = [[MainCategoryGatherView alloc] init];
    [gatherView setDelegate:self];
    gatherView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:gatherView];

    NSLayoutConstraint *top =  [NSLayoutConstraint constraintWithItem:gatherView
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1
                                                             constant:0];
    
    NSLayoutConstraint *leading =  [NSLayoutConstraint constraintWithItem:gatherView
                                                                attribute:NSLayoutAttributeLeading
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1
                                                                 constant:0];
    
    NSLayoutConstraint *trailing =  [NSLayoutConstraint constraintWithItem:gatherView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1
                                                                  constant:0];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    CGFloat height = 0;
    if (window.bounds.size.height == 0) {
        height = CGFLOAT_MAX;
    } else {
        height = window.bounds.size.height;
    }
    
    NSLayoutConstraint *heightConstraint =  [NSLayoutConstraint constraintWithItem:gatherView
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeHeight
                                                                        multiplier:1
                                                                          constant:height];
    [gatherView addConstraint:heightConstraint];
    [self addConstraints:[NSArray arrayWithObjects:top,leading,trailing,nil]];
    [gatherView setHidden:YES];
}

- (void)setSelectIndex:(NSInteger)index {
    if(isViewTabData && [_viewTabData count] < 1) {
        return;
    } else if (!isViewTabData && [_data count] < 1) {
        return;
    }

    [self layoutIfNeeded];
    isAnimation = YES;
    _selectIndex = index;
    [gatherView setSelectIndex:_selectIndex];
    MainCategoryTabButtonView *tabView = (MainCategoryTabButtonView *)[tabController getButtonView:_selectIndex];
    [tabController selectTabIndex:_selectIndex];
    
    if (_pagerScollView != nil) {
        [_pagerScollView setContentOffset:CGPointMake([_pagerScollView bounds].size.width * _selectIndex, _pagerScollView.contentOffset.y) animated:YES];
    }
    [self moveCenterScrollView:_selectIndex];
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^(void) {
                         [_selectBar setWidthWithLeft:[tabView.viewWidthConstraint constant] left:tabView.frame.origin.x];
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         isAnimation = NO;
                         
                     }];
    [self doDelegate];
}

- (void)setGatherButtonHidden:(BOOL)hidden {
    [_actionButton setHidden:hidden];
    if (hidden) {
        [_buttonViewWidthConstraint setConstant:0];
    } else {
        [_buttonViewWidthConstraint setConstant:42];
    }
    
}

- (void)setData:(NSMutableArray<NSString *> *)data {
    [_data release];
    _data = data;
    [_data retain];
    isViewTabData = NO;
    [self setGatherViewData];
    [self updateUI];
}

- (void)setViewTabData:(NSMutableArray<ViewTabData *> *)viewTabData {
    [_viewTabData release];
    _viewTabData = viewTabData;
    [_viewTabData retain];
    isViewTabData = YES;
    [self setGatherViewData];
    [self updateUI];
}

-( void)setGatherViewData {
    if (isViewTabData) {
        NSMutableArray<NSString *> *data = [[[NSMutableArray alloc] init] autorelease];
        for (ViewTabData *tabData in _viewTabData) {
            [data addObject:[tabData title]];
        }
        [gatherView setData:data];
    } else {
        [gatherView setData:_data];
    }
}

- (void)setFitTextWidth:(MainCategoryTabButtonView *)tabView {
    CGFloat buttonWidth = _scrollView.bounds.size.width;
    if (_isFitTextWidth) {
        CGFloat labelWidth = [self getStringWidth:tabView.titleLabel] + 24;
        [tabView.viewWidthConstraint setConstant:labelWidth];
    } else {
        CGFloat buttonCount = _scrollView.bounds.size.width;
        if (isViewTabData) {
            buttonCount = (_viewTabData.count >= _maxShowCount) ? _maxShowCount:_viewTabData.count;
        } else {
            buttonCount = (_data.count >= _maxShowCount) ? _maxShowCount:_data.count;
        }
        buttonWidth = _scrollView.bounds.size.width / buttonCount;
        [tabView.viewWidthConstraint setConstant:buttonWidth];
    }
}

#pragma mark - Get Function

- (ViewTabData *)getSelectViewTabData {
    if(isViewTabData && [_viewTabData count] > 0) {
        return [_viewTabData objectAtIndex:_selectIndex];
    }
    return nil;
}

- (NSString *)getSelectData {
    if (!isViewTabData && [_data count] > 0) {
        return [_data objectAtIndex:_selectIndex];
    }
    return nil;
}

- (CGFloat) getStringWidth:(UILabel *)label {
    CGRect rect = [label.attributedText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, label.frame.size.height)
                                                     options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return rect.size.width + 1;
}


#pragma mark - Update Function

- (void)updateUI {
    [view layoutIfNeeded];
    [_scrollView layoutIfNeeded];
    
    for (UIView *view in [tabController buttonViews]) {
        [view removeFromSuperview];
    }
    
    if (isViewTabData) {
        [self updateViewTabDataUI];
    } else {
        [self updateDataUI];
    }
    
    [self layoutIfNeeded];
}

- (void)updateDataUI {
    NSMutableArray *tabs = [[[NSMutableArray alloc] init] autorelease];
    MainCategoryTabButtonView *beforeTabView = nil;
    CGFloat contentViewWidth = 0;
    
    for (int i=0;i<[_data count];i++) {
        NSString *data = [_data objectAtIndex:i];
        MainCategoryTabButtonView *tabView =  [self createMainCategoryTabButtonView:data isNew:NO];
        [tabs addObject:tabView];
        [_contentView addSubview:tabView];
        
        contentViewWidth += [tabView.viewWidthConstraint constant];
        [self addContentViewConstraints:tabView beforeTabView:beforeTabView];
        beforeTabView = tabView;
    }
    
    [tabController setTabs:YES tabs:tabs];
    [_contentViewWidthConstraint setConstant:contentViewWidth];
    [self checkScrollViewWidth:_data.count];
}

- (void)updateViewTabDataUI {
    NSMutableArray *tabs = [[[NSMutableArray alloc] init] autorelease];
    MainCategoryTabButtonView *beforeTabView = nil;
    CGFloat contentViewWidth = 0;
    
    for (int i=0;i<[_viewTabData count];i++) {
        ViewTabData *data = [_viewTabData objectAtIndex:i];
        MainCategoryTabButtonView *tabView =  [self createMainCategoryTabButtonView:[data title] isNew:[data isNew]];
        [tabs addObject:tabView];
        [_contentView addSubview:tabView];
        
        contentViewWidth += [tabView.viewWidthConstraint constant];
        [self addContentViewConstraints:tabView beforeTabView:beforeTabView];
        beforeTabView = tabView;
    }
    
    [tabController setTabs:YES tabs:tabs];
    [_contentViewWidthConstraint setConstant:contentViewWidth];
    [self checkScrollViewWidth:_viewTabData.count];
}

- (void)updatePagerScrollView {
    if(isAnimation || _pagerScollView == nil) {
        return;
    }
    
    [currentData setCurrentData:_pagerScollView tabController:tabController];
    if ([_selectBar move:beforeOffsetX data:currentData tabCount:[tabController count]]) {
        MainCategoryTabButtonView *nextTabView = (MainCategoryTabButtonView *)[tabController getButtonView:currentData.index+1];
        [_selectBar updateWidth:nextTabView data:currentData];
    }
    
    if (currentData.scrollPercent < 1){
        _selectIndex = currentData.index;
        [tabController selectTabIndex:_selectIndex];
        [self moveCenterScrollView:_selectIndex];
        [gatherView setSelectIndex:_selectIndex];
        [self doDelegate];
    }
    
    beforeOffsetX = currentData.offsetX;
}

#pragma mark - Create Function

- (MainCategoryTabButtonView *)createMainCategoryTabButtonView:(NSString *)title isNew:(BOOL)isNew {
    MainCategoryTabButtonView *tabView = [[[MainCategoryTabButtonView alloc] init] autorelease];
    [tabView.titleLabel setText:title];
    if (isNew) {
        [tabView.imageView setHidden:NO];
        [tabView.viewWidthConstraint setConstant:[tabView.viewWidthConstraint constant] + 20];
    } else {
        [tabView.imageView setHidden:YES];
    }
    [self setFitTextWidth:tabView];
    return tabView;
}

#pragma mark - Add Function

- (void)addContentViewConstraints:(MainCategoryTabButtonView *)currentTabView beforeTabView:(MainCategoryTabButtonView *)beforeTabView{
    NSLayoutConstraint *top =  [NSLayoutConstraint constraintWithItem:currentTabView
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_contentView
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1
                                                             constant:0];
    
    NSLayoutConstraint *bottom =  [NSLayoutConstraint constraintWithItem:_contentView
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:currentTabView
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1
                                                                constant:1];
    NSLayoutConstraint *left = nil;
    if (beforeTabView == nil) {
        left = [NSLayoutConstraint constraintWithItem:currentTabView
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:_contentView
                                            attribute:NSLayoutAttributeLeft
                                           multiplier:1
                                             constant:0];
        
        [_selectBar setWidthWithLeft:[currentTabView.viewWidthConstraint constant] left:0];
    } else {
        left = [NSLayoutConstraint constraintWithItem:currentTabView
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:beforeTabView
                                            attribute:NSLayoutAttributeRight
                                           multiplier:1
                                             constant:0];
    }
    [_contentView addConstraints:[NSArray arrayWithObjects:top,bottom,left, nil]];
}

#pragma mark - Check Function

- (void)checkScrollViewWidth:(NSInteger)dataCount {
    if (dataCount < 1) {
        return;
    }
    
    if (_isFitTextWidth) {
        if ([_contentViewWidthConstraint constant] > view.bounds.size.width - [_buttonViewWidthConstraint constant]) {
            [self setGatherButtonHidden:NO];
        } else {
            [self setGatherButtonHidden:YES];
            [view layoutIfNeeded];
            CGFloat buttonWidth = _scrollView.frame.size.width;
            buttonWidth = _scrollView.frame.size.width / dataCount;
            for (MainCategoryTabButtonView *tabView in [tabController buttonViews]) {
                [tabView.viewWidthConstraint setConstant:buttonWidth];
            }
            [_contentViewWidthConstraint setConstant:_scrollView.frame.size.width];
        }
    }
}

#pragma mark - Etc Function

- (void) moveCenterScrollView:(NSInteger)index {
    MainCategoryTabButtonView *tabView = (MainCategoryTabButtonView *)[tabController getButtonView:index];
    CGFloat movePositionX = tabView.frame.origin.x + ([tabView.viewWidthConstraint constant]/2) - _scrollView.bounds.size.width/2;
    CGFloat limitPosition = _contentView.bounds.size.width - _scrollView.bounds.size.width;
    movePositionX = (movePositionX < 0) ? 0:movePositionX;
    movePositionX = (movePositionX > limitPosition) ? limitPosition:movePositionX;
    [_scrollView setContentOffset:CGPointMake(movePositionX, _scrollView.contentOffset.y) animated:YES];
}

- (void)doDelegate {
    if ([_delegate respondsToSelector:@selector(didSelectMainCategoryTab:data:)]) {
        [_delegate didSelectMainCategoryTab:self data:[_data objectAtIndex:_selectIndex]];
    }
    
    if ([_delegate respondsToSelector:@selector(didSelectMainCategoryTab:viewTabData:)]) {
        [_delegate didSelectMainCategoryTab:self viewTabData:[_viewTabData objectAtIndex:_selectIndex]];
    }
    
    if ([_delegate respondsToSelector:@selector(didSelectMainCategoryTab:index:)]) {
        [_delegate didSelectMainCategoryTab:self index:_selectIndex];
    }
}


- (void)startScrollAnimation {
    CGFloat tailOffsetW = _contentView.bounds.size.width - _scrollView.bounds.size.width;
    if (tailOffsetW > 50) {
        tailOffsetW = 50;
    }
    
    [_scrollView setContentOffset:CGPointMake(tailOffsetW, 0)];
    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^(void) {
                         [_scrollView setContentOffset:CGPointMake(0, 0)];
                     }
                     completion:nil];
}

#pragma mark - GatherView Function

- (void)onGatherView:(UIButton *)button {
    if (button.isSelected) {
        [self closeGatherView:YES];
    } else {
        [self openGatherView:YES];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint viewPoint = [gatherView convertPoint:point fromView:self];
    
    if (self.clipsToBounds) {
        return nil;
    } else if (self.hidden) {
        return nil;
    } else if (self.alpha == 0) {
        return nil;
    }
    
    if ([gatherView pointInside:viewPoint withEvent:event] ) {
        return [gatherView hitTest:viewPoint withEvent:event];
    }
    
    return [super hitTest:point withEvent:event];
}

- (void)openGatherView:(BOOL)isAnimation{
    [_actionButton setSelected:YES];
    [_gatherTitleView setHidden:NO];
    if (isAnimation) {
        [gatherView openAnimation];
    } else {
        [gatherView setHidden:NO];
    }
}

- (void)closeGatherView:(BOOL)isAnimation {
    [_actionButton setSelected:NO];
    [_gatherTitleView setHidden:YES];
    if (isAnimation) {
        [gatherView closeAnimation];
    } else {
        [gatherView setHidden:YES];
    }
}

#pragma mark - TabControllerDelegate

-(void)touchTab:(TabController *)tabController selectedButtonView:(TabButtonView *)buttonView {
    [self setSelectIndex:[buttonView tag]];
}

#pragma mark - MainCategoryGatherViewDelegate

- (void)touchGatherViewDimLayer {
    [_actionButton setSelected:NO];
    [_gatherTitleView setHidden:YES];
}

- (void)didSelectTab:(MainCategoryGatherView *)view index:(NSInteger)index {
    [_actionButton setSelected:NO];
    [_gatherTitleView setHidden:YES];
    [self setSelectIndex:index];
}

@end

