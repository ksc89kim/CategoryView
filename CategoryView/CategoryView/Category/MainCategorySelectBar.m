//
//  MainCategorySelectBar.m
//  CategoryView
//
//  Created by kim sunchul on 2018. 12. 8..
//  Copyright © 2018년 tronplay. All rights reserved.
//

#import "MainCategorySelectBar.h"

#define MAIN_SELECTBAR_WIDTH_CONSTRAINT @"mainSelectbarWidthConstraint"
#define MAIN_SELECTBAR_LEFT_CONSTRAINT @"mainSelectbarLeftConstraint"

@implementation MainCategorySelectBar

- (void)dealloc {
    [super dealloc];
}

- (void)setUI {
    [super setUI];
    
    self.viewWidthConstraint = [self findViewWidthConstraint];
    if(self.viewWidthConstraint == nil) {
        self.viewWidthConstraint = [self.widthAnchor constraintEqualToConstant:0];
        [self.viewWidthConstraint setActive:YES];
        self.viewWidthConstraint.identifier = MAIN_SELECTBAR_WIDTH_CONSTRAINT;
    }
    
    self.viewLeftConstraint = [self findViewLeftConstraint];
}


- (void)setController {
    [super setController];
}

- (void)setEvent {
    [super setEvent];
}

- (void)setWidthWithLeft:(CGFloat)width left:(CGFloat)left {
    if (self.viewWidthConstraint != nil) {
        [self.viewWidthConstraint setConstant:width];
    }
    if (self.viewLeftConstraint != nil) {
        [self.viewLeftConstraint setConstant:left];
    }
}

- (BOOL)move:(CGFloat)beforeOffsetX data:(MainCategoryCurrentData *)data tabCount:(NSInteger)tabCount {
    if ([self isMove:data tabCount:tabCount]) {
        CGFloat tabViewPercentWidth = [data getTabViewWidth];
        CGFloat currentTabViewWidth = [data.tabView.viewWidthConstraint constant];
        CGFloat currentTabViewX = data.tabView.frame.origin.x;
        
        switch ([data getDirection:beforeOffsetX]) {
            case LeftDirection: {
                CGFloat minusPosition = currentTabViewWidth - tabViewPercentWidth;
                [_viewLeftConstraint setConstant:(currentTabViewX + currentTabViewWidth) - minusPosition];
            }
                break;
            case RightDirection: {
                [_viewLeftConstraint setConstant:currentTabViewX + tabViewPercentWidth];
            }
            break;
            default:
                break;
        }
        return true;
    }
    return false;
}

- (void)updateWidth:(MainCategoryTabButtonView *)nextTabView data:(MainCategoryCurrentData *)data {
    if (nextTabView == nil || data.tabView == nil) {
        return;
    }
    
    CGFloat percent = (([nextTabView.viewWidthConstraint constant] -[data.tabView.viewWidthConstraint constant]) * data.scrollPercent / 100);
    [_viewWidthConstraint setConstant:[data.tabView.viewWidthConstraint constant] + percent];
}

- (BOOL)isMove:(MainCategoryCurrentData *)data tabCount:(NSInteger)tabCount {
    if (data.scrollPercent < 0 || data.tabView == nil || !(data.index >= 0 && data.index < tabCount - 1 )) {
        return false;
    }
    return true;
}

#pragma mark - Find Funtion
- (NSLayoutConstraint *) findViewWidthConstraint {
    return [self findViewConstraint:self identifier:MAIN_SELECTBAR_WIDTH_CONSTRAINT];
}

- (NSLayoutConstraint *) findViewLeftConstraint {
    return [self findViewConstraint:[self superview] identifier:MAIN_SELECTBAR_LEFT_CONSTRAINT];
}


@end
