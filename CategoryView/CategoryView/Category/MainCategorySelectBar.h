//
//  MainCategorySelectBar.h
//  CategoryView
//
//  Created by kim sunchul on 2018. 12. 8..
//  Copyright © 2018년 tronplay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomXibView.h"
#import "MainCategoryCurrentData.h"

NS_ASSUME_NONNULL_BEGIN

/*
    메인카테고리 셀렉트 바
    - 메인 카테고리 하단에 있는 셀렉트바를 표현함.
 */
@interface MainCategorySelectBar : CustomXibView

@property (retain, nonatomic) NSLayoutConstraint *viewWidthConstraint; //width 설정
@property (retain, nonatomic) NSLayoutConstraint *viewLeftConstraint; //left 설정

- (void)setWidthWithLeft:(CGFloat)width left:(CGFloat)left;
- (BOOL)move:(CGFloat)beforeOffsetX data:(MainCategoryCurrentData *)data tabCount:(NSInteger)tabCount;
- (void)updateWidth:(MainCategoryTabButtonView *)nextTabView data:(MainCategoryCurrentData *)data;
- (BOOL)isMove:(MainCategoryCurrentData *)data tabCount:(NSInteger)tabCount;

@end

NS_ASSUME_NONNULL_END
