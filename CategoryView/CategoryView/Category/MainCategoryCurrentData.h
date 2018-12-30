//
//  MainCategoryCurrentData.h
//  CategoryView
//
//  Created by kim sunchul on 2018. 12. 30..
//  Copyright © 2018년 tronplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainCategoryTabButtonView.h"
#import "TabController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MainCategoryPagerScrollDirection) {
    NoneDirection,
    LeftDirection,
    RightDirection
};

@interface MainCategoryCurrentData : NSObject

@property (assign, nonatomic) CGFloat offsetX;
@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) CGFloat scrollPercent;
@property (retain, nonatomic) MainCategoryTabButtonView *tabView;

- (void)setCurrentData:(UIScrollView *)pagerScrollView tabController:(TabController *)tabController;
- (CGFloat)getTabViewWidth;
- (MainCategoryPagerScrollDirection)getDirection:(CGFloat)beforeOffsetX;

@end

NS_ASSUME_NONNULL_END
