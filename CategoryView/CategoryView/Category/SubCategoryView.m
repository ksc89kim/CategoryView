//
//  SubTabView.m
//  Mulban
//
//  Created by kim sunchul on 2018. 10. 14..
//  Copyright © 2018년 Baek. All rights reserved.
//

#import "SubCategoryView.h"
#import "SubCategoryTabButtonView.h"
#import "ViewTabData.h"

@implementation SubCategoryView

- (void)dealloc {
    [tabController release];
    [tabViews release];
    [_view release];
    [super dealloc];
}

#pragma mark - Init Function

- (instancetype)init {
    self = [self initWithFrame:[[[UIApplication sharedApplication] keyWindow] bounds]];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

#pragma mark - Xib Function

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setup];
}

#pragma mark - Set Function

- (void)setup {
    [self setNib];
    [self initHeight:_view height:16];
    [self setUI];
    [self setController];
}

- (void)setNib{
    _view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
    [_view setFrame:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
    [_view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:_view];
}

- (void)setUI {
    _maxColumn = 4;
}

- (void)setController {
    tabController = [[TabController alloc] init];
    [tabController setDelegate:self];
    tabViews = [[NSMutableArray alloc] init];
}

- (void)setData:(NSMutableArray<NSString *> *)data {
    [_data release];
    _data = data;
    [_data retain];
    isViewTabData = NO;
    [self updateUI];
}

- (void)setViewTabData:(NSMutableArray<ViewTabData *> *)viewTabData {
    [_viewTabData release];
    _viewTabData = viewTabData;
    [_viewTabData retain];
    isViewTabData = YES;
    [self updateUI];
}

- (void)setSelectIndex:(NSInteger)index {
    if(isViewTabData && [_viewTabData count] < 1) {
        return;
    } else if (!isViewTabData && [_data count] < 1) {
        return;
    }
    
    _selectIndex = index;
    [tabController selectTabIndex:_selectIndex];
    [self doDelegate];
}

#pragma mark - Update Function

- (void)updateUI {
    for (UIView *view in [self.stackView arrangedSubviews]) {
        [self.stackView removeArrangedSubview:view];
        [view removeFromSuperview];
    }
    
    if (isViewTabData) {
        [self updateViewDataUI];
    } else {
        [self updateDataUI];
    }
   
}

- (void)updateViewDataUI {
    NSInteger count = [self getDataCount:_viewTabData.count];
    NSInteger index = 0;
    [tabViews removeAllObjects];
    
    for (int i=1;i<=count;i++) {
        UIStackView *rowStackView =  [self createRowStackView];
        [self.stackView addArrangedSubview:rowStackView];
        
        CGFloat blankIndex = [self getCalBlankIndex:i maxCount:count dataCount:_viewTabData.count];
        for(int j=1;j<=_maxColumn;j++){
            BOOL isBlank = (j > blankIndex);
            ViewTabData *viewTabData = [_viewTabData objectAtIndex:index];
            SubCategoryTabButtonView *tabView = [self createSubCategoryTabView:isBlank title:viewTabData.title];
            index += (isBlank) ? 0:1;
            [rowStackView addArrangedSubview:tabView];
        }
    }
    [tabController setTabs:YES tabs:tabViews];
    [self refreshAutoHeight:YES];
}

- (void)updateDataUI {
    NSInteger count = [self getDataCount:_data.count];
    NSInteger index = 0;
    [tabViews removeAllObjects];
    
    for (int i=1;i<=count;i++) {
        UIStackView *rowStackView =  [self createRowStackView];
        [self.stackView addArrangedSubview:rowStackView];
        
        CGFloat blankIndex = [self getCalBlankIndex:i maxCount:count dataCount:_data.count];
        for(int j=1;j<=_maxColumn;j++){
            BOOL isBlank = (j > blankIndex);
            SubCategoryTabButtonView *tabView = [self createSubCategoryTabView:isBlank title:[_data objectAtIndex:index]];
            index += (isBlank) ? 0:1;
            [rowStackView addArrangedSubview:tabView];
        }
    }
    [tabController setTabs:YES tabs:tabViews];
    [self refreshAutoHeight:YES];
}

#pragma mark - Create Function

- (UIStackView *)createRowStackView {
    UIStackView *rowStackView = [[[UIStackView alloc] init] autorelease];
    rowStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [rowStackView setAxis:UILayoutConstraintAxisHorizontal];
    [rowStackView setAlignment:UIStackViewAlignmentFill];
    [rowStackView setDistribution:UIStackViewDistributionFillEqually];
    [rowStackView setSpacing:3];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:rowStackView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:1
                                                                         constant:39];
    heightConstraint.identifier = AUTOHEIGHTCONSTRAINT;
    heightConstraint.priority = 999;
    [rowStackView addConstraint:heightConstraint];
    return rowStackView;
}

- (SubCategoryTabButtonView *)createSubCategoryTabView:(BOOL)isHidden title:(NSString *)title {
    SubCategoryTabButtonView *tabView =  [[[SubCategoryTabButtonView alloc] init] autorelease];
    if (isHidden) {
        [tabView setBlankHidden:NO];
    } else {
        [tabView.titleLabel setText:title];
        [tabViews addObject:tabView];
    }
    return tabView;
}

#pragma mark - Get Function

- (NSInteger)getDataCount:(NSInteger)dataCount {
    NSInteger count = (dataCount / _maxColumn);
    count = (dataCount % _maxColumn == 0) ? count:count+1;
    return count;
}

- (CGFloat)getCalBlankIndex:(NSInteger)index maxCount:(NSInteger)maxCount dataCount:(NSInteger)dataCount{
    CGFloat blankIndex = _maxColumn;
    if (index == maxCount) {
        blankIndex = (dataCount % _maxColumn == 0) ? blankIndex : dataCount % _maxColumn;
    }
    return blankIndex;
}

- (ViewTabData *)getCurrentViewTabData {
    if(isViewTabData && [_viewTabData count] > 0) {
        return [_viewTabData objectAtIndex:_selectIndex];
    }
    return nil;
}

#pragma mark - Etc Function

- (void)tabAnimation {
    CGFloat viewWidth = self.frame.size.width;
    CGFloat rowDelay = 0.0;
    for (UIStackView *horizontalStackView in [self.stackView arrangedSubviews]) {
        CGFloat columnDelay = rowDelay ;
        for (UIView *view in [horizontalStackView arrangedSubviews]) {
            CGRect tabViewFrame = view.frame;
            [view setFrame:CGRectMake(tabViewFrame.origin.x+viewWidth, tabViewFrame.origin.y, tabViewFrame.size.width, tabViewFrame.size.height)];
            [UIView animateWithDuration:0.5
                                  delay:columnDelay
                                options: UIViewAnimationOptionCurveEaseOut
                             animations:^(void) {
                                 [view setFrame:tabViewFrame];
                             }
                             completion:nil];
            columnDelay += 0.1;
        }
        rowDelay += 0.1;
    }
}

- (void)touchTab:(TabController *)tabController selectedButtonView:(TabButtonView *)buttonView {
    _selectIndex = buttonView.tag;
    [self doDelegate];
}

- (void)doDelegate {
    if ([_delegate respondsToSelector:@selector(didSelectSubCategoryTab:data:)]) {
        [_delegate didSelectSubCategoryTab:self data:[_data objectAtIndex:_selectIndex]];
    }
    
    if ([_delegate respondsToSelector:@selector(didSelectSubCategoryTab:index:)]) {
        [_delegate didSelectSubCategoryTab:self index:_selectIndex];
    }
    
    if ([_delegate respondsToSelector:@selector(didSelectSubCategoryTab:viewTabData:)]) {
        [_delegate didSelectSubCategoryTab:self viewTabData:[_viewTabData objectAtIndex:_selectIndex]];
    }
}

@end
