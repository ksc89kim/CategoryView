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
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
      [self initData];
    }
    return self;
}

- (void)initData {
    cellFrame = CGRectZero;
}

#pragma mark - Set Function

- (void)setCurrentData:(UIScrollView *)pagerScrollView controller:(id<MainCategoryController>)controller {
    _offsetX = [pagerScrollView contentOffset].x;
    CGFloat pagerScrollWidth = [pagerScrollView bounds].size.width;
    _index = [pagerScrollView contentOffset].x / [pagerScrollView bounds].size.width;
    cellFrame = [controller rectAtIndex:_index];
    _scrollPercent = ((int)_offsetX % (int)pagerScrollWidth) / pagerScrollWidth * 100;
}

#pragma mark - Get Function

- (CGFloat)getPercentCellWidth {
    return cellFrame.size.width * _scrollPercent / 100;
}

- (CGRect)getCellFrame {
    return cellFrame;
}

-(MainCategoryPagerScrollDirection)getDirection:(CGFloat)beforeOffsetX{
    if (beforeOffsetX > _offsetX) {
        return LeftDirection;
    }
    return RightDirection;
}

@end
