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
    [_view release];
    [_contentView release];
    [_buttonViewWidthConstraint release];
    [_contentViewWidthConstraint release];
    [_scrollView release];
    [_selectBarWidthConstraint release];
    [_selectBarLeftConstraint release];
    [tabController release];
    [_pagerScollView release];
    [_actionButton release];
    [gatherView release];
    [_gatherTitleView release];
    [_gatherTitleLabel release];
    [_topLine release];
    [_shadowImageView release];
    [super dealloc];
}

- (instancetype)init
{
    self = [self initWithFrame:[[[UIApplication sharedApplication] keyWindow] bounds]];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setNib];
        [self setUI];
        [self setEvent];
        [self setController];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setNib];
        [self setUI];
        [self setEvent];
        [self setController];
    }
    return self;
}

- (void)setNib{
    _view = [[[NSBundle mainBundle] loadNibNamed:@"MainCategoryView" owner:self options:nil] objectAtIndex:0];
    [_view setFrame:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
    [_view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:_view];
    [self setConstraint:_view];
}

- (void)setController {
    tabController = [[TabController alloc] init];
    [tabController setDelegate:self];
}

- (void)setUI {
    _maxShowCount = 5;
    
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

- (void)setEvent {
    [_actionButton addTarget:self action:@selector(onGatherView:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setConstraint:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    //xib view autolayout setting
    NSLayoutConstraint *viewWidth =  [NSLayoutConstraint constraintWithItem:view
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1
                                                                   constant:0];
    
    NSLayoutConstraint *viewHeight =  [NSLayoutConstraint constraintWithItem:view
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeHeight
                                                                  multiplier:1
                                                                    constant:0];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:view
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1
                                                                constant:0];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:view
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1
                                                                constant:0];
    
    [self addConstraints:[NSArray arrayWithObjects:viewWidth,viewHeight,centerX,centerY,nil]];
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
                         [_selectBarLeftConstraint setConstant:tabView.frame.origin.x];
                         [_selectBarWidthConstraint setConstant:[tabView.viewWidthConstraint constant]];
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         isAnimation = NO;
                         
                     }];
    [self doDelegate];
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

- (ViewTabData *)getCurrentViewTabData {
    if(isViewTabData && [_viewTabData count] > 0) {
        return [_viewTabData objectAtIndex:_selectIndex];
    }
    return nil;
}

- (NSString *)getCurrentData {
    if (!isViewTabData && [_data count] > 0) {
        return [_data objectAtIndex:_selectIndex];
    }
    return nil;
}


- (void)updateUI {
    [_view layoutIfNeeded];
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
        MainCategoryTabButtonView *tabView = [[[MainCategoryTabButtonView alloc] init] autorelease];
        [tabView.titleLabel setText:[_data objectAtIndex:i]];
        [tabs addObject:tabView];
        [_contentView addSubview:tabView];
        [self setFitTextWidth:tabView];
        contentViewWidth += [tabView.viewWidthConstraint constant];
        
        NSLayoutConstraint *top =  [NSLayoutConstraint constraintWithItem:tabView
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_contentView
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1
                                                                 constant:0];
        
        NSLayoutConstraint *bottom =  [NSLayoutConstraint constraintWithItem:_contentView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:tabView
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1
                                                                    constant:1];
        NSLayoutConstraint *left = nil;
        if (beforeTabView == nil) {
            left = [NSLayoutConstraint constraintWithItem:tabView
                                                attribute:NSLayoutAttributeLeft
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:_contentView
                                                attribute:NSLayoutAttributeLeft
                                               multiplier:1
                                                 constant:0];
            [_selectBarLeftConstraint setConstant:0];
            [_selectBarWidthConstraint setConstant:[tabView.viewWidthConstraint constant]];
        } else {
            left = [NSLayoutConstraint constraintWithItem:tabView
                                                attribute:NSLayoutAttributeLeft
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:beforeTabView
                                                attribute:NSLayoutAttributeRight
                                               multiplier:1
                                                 constant:0];
        }
        beforeTabView = tabView;
        [_contentView addConstraints:[NSArray arrayWithObjects:top,bottom,left, nil]];
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
        MainCategoryTabButtonView *tabView = [[[MainCategoryTabButtonView alloc] init] autorelease];
        ViewTabData *data = (ViewTabData *)[_viewTabData objectAtIndex:i];
        [tabView.titleLabel setText:data.title];
        [tabs addObject:tabView];
        [_contentView addSubview:tabView];
        [self setFitTextWidth:tabView];
        

        contentViewWidth += [tabView.viewWidthConstraint constant];
        
        NSLayoutConstraint *top =  [NSLayoutConstraint constraintWithItem:tabView
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_contentView
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1
                                                                 constant:0];
        
        NSLayoutConstraint *bottom =  [NSLayoutConstraint constraintWithItem:_contentView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:tabView
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1
                                                                    constant:1];
        NSLayoutConstraint *left = nil;
        if (beforeTabView == nil) {
            left = [NSLayoutConstraint constraintWithItem:tabView
                                                attribute:NSLayoutAttributeLeft
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:_contentView
                                                attribute:NSLayoutAttributeLeft
                                               multiplier:1
                                                 constant:0];
            [_selectBarLeftConstraint setConstant:0];
            [_selectBarWidthConstraint setConstant:[tabView.viewWidthConstraint constant]];
        } else {
            left = [NSLayoutConstraint constraintWithItem:tabView
                                                attribute:NSLayoutAttributeLeft
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:beforeTabView
                                                attribute:NSLayoutAttributeRight
                                               multiplier:1
                                                 constant:0];
        }
        beforeTabView = tabView;
        [_contentView addConstraints:[NSArray arrayWithObjects:top,bottom,left, nil]];
    }
    
    [tabController setTabs:YES tabs:tabs];
    [_contentViewWidthConstraint setConstant:contentViewWidth];
    [self checkScrollViewWidth:_viewTabData.count];
}

- (void)checkScrollViewWidth:(NSInteger)dataCount {
    if (dataCount < 1) {
        return;
    }
    
    if (_isFitTextWidth) {
        if ([_contentViewWidthConstraint constant] > _view.bounds.size.width - [_buttonViewWidthConstraint constant]) {
            [self setGatherButtonHidden:NO];
        } else {
            [self setGatherButtonHidden:YES];
            [_view layoutIfNeeded];
            CGFloat buttonWidth = _scrollView.frame.size.width;
            buttonWidth = _scrollView.frame.size.width / dataCount;
            for (MainCategoryTabButtonView *tabView in [tabController buttonViews]) {
                [tabView.viewWidthConstraint setConstant:buttonWidth];
            }
            [_contentViewWidthConstraint setConstant:_scrollView.frame.size.width];
        }
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

- (CGFloat) getStringWidth:(UILabel *)label {
    CGRect rect = [label.attributedText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, label.frame.size.height)
                                                     options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return rect.size.width + 1;
}

- (void)updatePagerScrollView {
    if(isAnimation || _pagerScollView == nil) {
        return;
    }
    if ([self moveSelectBar]) {
        [self updateSelectBarWidth];
    }
    
    if (currentScrollPercent < 1){
        _selectIndex = currentIndex;
        [tabController selectTabIndex:_selectIndex];
        [self moveCenterScrollView:_selectIndex];
        [gatherView setSelectIndex:_selectIndex];
        [self doDelegate];
    }
    
    beforeOffsetX = currentOffsetX;
}

-(MainCategoryPagerScrollDirection) getCurrentDirection {
    if (_pagerScollView == nil) {
        return NoneDirection;
    }
    if (beforeOffsetX > currentIndex) {
        return LeftDirection;
    }
    return RightDirection;
}

- (void) moveCenterScrollView:(NSInteger)index {
    MainCategoryTabButtonView *tabView = (MainCategoryTabButtonView *)[tabController getButtonView:index];
    CGFloat movePositionX = tabView.frame.origin.x + ([tabView.viewWidthConstraint constant]/2) - _scrollView.bounds.size.width/2;
    CGFloat limitPosition = _contentView.bounds.size.width - _scrollView.bounds.size.width;
    movePositionX = (movePositionX < 0) ? 0:movePositionX;
    movePositionX = (movePositionX > limitPosition) ? limitPosition:movePositionX;
    [_scrollView setContentOffset:CGPointMake(movePositionX, _scrollView.contentOffset.y) animated:YES];
}

- (BOOL) moveSelectBar {
    currentOffsetX = [_pagerScollView contentOffset].x;
    CGFloat pagerScrollWidth = [_pagerScollView bounds].size.width;
    currentIndex = [_pagerScollView contentOffset].x / [_pagerScollView bounds].size.width;
    currentTabView = (MainCategoryTabButtonView *)[tabController getButtonView:currentIndex];
    currentScrollPercent = ((int)currentOffsetX % (int)pagerScrollWidth) / pagerScrollWidth * 100;
    CGFloat tabViewPercentWidth = [currentTabView.viewWidthConstraint constant] * currentScrollPercent / 100;
    
    if (currentScrollPercent < 0 || currentTabView == nil || !(currentIndex >= 0 && currentIndex < [tabController count] - 1 )) {
        return false;
    }
    
    switch ([self getCurrentDirection]) {
        case LeftDirection: {
            CGFloat minusPosition = [currentTabView.viewWidthConstraint constant] - tabViewPercentWidth;
            [_selectBarLeftConstraint setConstant:(currentTabView.frame.origin.x + [currentTabView.viewWidthConstraint constant]) - minusPosition];
        }
            break;
        case RightDirection: {
            [_selectBarLeftConstraint setConstant:currentTabView.frame.origin.x + tabViewPercentWidth];
        }
            break;
        default:
            break;
    }
    
    return true;
}

- (void)updateSelectBarWidth {
    MainCategoryTabButtonView *nextTabView = (MainCategoryTabButtonView *)[tabController getButtonView:currentIndex+1];
    if (nextTabView == nil || currentTabView == nil) {
        return;
    }
    
    CGFloat percent = (([nextTabView.viewWidthConstraint constant] -[currentTabView.viewWidthConstraint constant]) * currentScrollPercent / 100);
    [_selectBarWidthConstraint setConstant:[currentTabView.viewWidthConstraint constant] + percent];
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

#pragma mark - TabController Delegate

-(void)touchTab:(TabController *)tabController selectedButtonView:(TabButtonView *)buttonView {
    [self setSelectIndex:[buttonView tag]];
}

#pragma mark - MainCategoryViewDelegate Delegate

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

