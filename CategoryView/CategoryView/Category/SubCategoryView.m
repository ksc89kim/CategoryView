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
        [self initHeight:_view height:16];
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
        [self initHeight:_view height:16];
        [self setController];
    }
    return self;
}

- (void)setNib{
    _view = [[[NSBundle mainBundle] loadNibNamed:@"SubCategoryView" owner:self options:nil] objectAtIndex:0];
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
    NSInteger count = (_viewTabData.count / _maxColumn);
    count = (_viewTabData.count % _maxColumn == 0) ? count:count+1;
    NSInteger index = 0;
    [tabViews removeAllObjects];
    for (int i=1;i<=count;i++) {
        UIStackView *horizontalStackView = [[[UIStackView alloc] init] autorelease];
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = NO;
        [horizontalStackView setAxis:UILayoutConstraintAxisHorizontal];
        [horizontalStackView setAlignment:UIStackViewAlignmentFill];
        [horizontalStackView setDistribution:UIStackViewDistributionFillEqually];
        [horizontalStackView setSpacing:3];
        [self.stackView addArrangedSubview:horizontalStackView];
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:horizontalStackView
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeHeight
                                                                           multiplier:1
                                                                             constant:39];
        heightConstraint.identifier = AUTOHEIGHTCONSTRAINT;
        heightConstraint.priority = 999;
        [horizontalStackView addConstraint:heightConstraint];
        
        CGFloat blank = _maxColumn;
        if (i == count) {
            blank = (_viewTabData.count % _maxColumn == 0) ? blank : _viewTabData.count % _maxColumn;
        }
        for(int j=1;j<=_maxColumn;j++){
            SubCategoryTabButtonView *tabView =  [[[SubCategoryTabButtonView alloc] init] autorelease];
            if (j > blank) {
                [tabView setBlankHidden:NO];
            } else {
                ViewTabData *viewTabData = (ViewTabData *)[_viewTabData objectAtIndex:index];
                [tabView.titleLabel setText:viewTabData.title];
                [tabViews addObject:tabView];
                index++;
            }
            [horizontalStackView addArrangedSubview:tabView];
            
        }
    }
    [tabController setTabs:YES tabs:tabViews];
    [self refreshAutoHeight:YES];
}

- (void)updateDataUI {
    NSInteger count = (_data.count / _maxColumn);
    count = (_data.count % _maxColumn == 0) ? count:count+1;
    NSInteger index = 0;
    [tabViews removeAllObjects];
    for (int i=1;i<=count;i++) {
        UIStackView *horizontalStackView = [[[UIStackView alloc] init] autorelease];
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = NO;
        [horizontalStackView setAxis:UILayoutConstraintAxisHorizontal];
        [horizontalStackView setAlignment:UIStackViewAlignmentFill];
        [horizontalStackView setDistribution:UIStackViewDistributionFillEqually];
        [horizontalStackView setSpacing:3];
        [self.stackView addArrangedSubview:horizontalStackView];
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:horizontalStackView
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeHeight
                                                                           multiplier:1
                                                                             constant:39];
        heightConstraint.identifier = AUTOHEIGHTCONSTRAINT;
        heightConstraint.priority = 999;
        [horizontalStackView addConstraint:heightConstraint];
        
        CGFloat blank = _maxColumn;
        if (i == count) {
            blank = (_data.count % _maxColumn == 0) ? blank : _data.count % _maxColumn;
        }
        for(int j=1;j<=_maxColumn;j++){
            SubCategoryTabButtonView *tabView =  [[[SubCategoryTabButtonView alloc] init] autorelease];
            if (j > blank) {
                [tabView setBlankHidden:NO];
            } else {
                [tabView.titleLabel setText:[_data objectAtIndex:index]];
                [tabViews addObject:tabView];
                index++;
            }
            [horizontalStackView addArrangedSubview:tabView];
            
        }
    }
    [tabController setTabs:YES tabs:tabViews];
    [self refreshAutoHeight:YES];
}

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

- (ViewTabData *)getCurrentViewTabData {
    if(isViewTabData && [_viewTabData count] > 0) {
        return [_viewTabData objectAtIndex:_selectIndex];
    }
    return nil;
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
