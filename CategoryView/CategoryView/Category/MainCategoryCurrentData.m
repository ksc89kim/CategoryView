//
//  MainCategoryCurrentData.m
//  CategoryView
//
//  Created by kim sunchul on 2018. 12. 30..
//  Copyright © 2018년 tronplay. All rights reserved.
//

#import "MainCategoryCurrentData.h"

@implementation MainCategoryCurrentData

- (void)dealloc {
    [_tabView release];
    [super dealloc];
}

- (void)setCurrentData:(UIScrollView *)pagerScrollView tabController:(TabController *)tabController {
    _offsetX = [pagerScrollView contentOffset].x;
    CGFloat pagerScrollWidth = [pagerScrollView bounds].size.width;
    _index = [pagerScrollView contentOffset].x / [pagerScrollView bounds].size.width;
    self.tabView = (MainCategoryTabButtonView *)[tabController getButtonView:_index];
    _scrollPercent = ((int)_offsetX % (int)pagerScrollWidth) / pagerScrollWidth * 100;
}

- (CGFloat)getTabViewWidth {
    return  [_tabView.viewWidthConstraint constant] * _scrollPercent / 100;
}

-(MainCategoryPagerScrollDirection)getDirection:(CGFloat)beforeOffsetX{
    if (beforeOffsetX > _offsetX) {
        return LeftDirection;
    }
    return RightDirection;
}

@end
