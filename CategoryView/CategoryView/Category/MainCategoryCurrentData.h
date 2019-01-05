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

/*
    메인카테고리의 현재 데이터
    - 메인 카테고리가 가지고 있는 현재에 관련된 데이터를 표현함.
 */

// 스크롤의 방향
typedef NS_ENUM(NSUInteger, MainCategoryPagerScrollDirection) {
    NoneDirection,
    LeftDirection,
    RightDirection
};

@interface MainCategoryCurrentData : NSObject

@property (assign, nonatomic) CGFloat offsetX; // 스크롤 offset
@property (assign, nonatomic) NSInteger index; // 스크롤 인덱스
@property (assign, nonatomic) CGFloat scrollPercent; //페이저 스크롤 이동에 대한 퍼센트
@property (retain, nonatomic) MainCategoryTabButtonView *tabView;

- (void)setCurrentData:(UIScrollView *)pagerScrollView tabController:(TabController *)tabController;
- (CGFloat)getTabViewWidth;
- (MainCategoryPagerScrollDirection)getDirection:(CGFloat)beforeOffsetX;

@end

NS_ASSUME_NONNULL_END
