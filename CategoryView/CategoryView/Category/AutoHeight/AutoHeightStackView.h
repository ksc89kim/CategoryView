//
//  AutoHeightStackView.h
//  Mulban
//
//  Created by kim sunchul on 2018. 9. 25..
//  Copyright © 2018년 Baek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoHeightContentView.h"

NS_ASSUME_NONNULL_BEGIN

/*
    자동 높이 조절 스택 뷰
    - 자동 높이 컨텐츠 뷰를 이용하여 높이 조절
    - 스택 뷰에 들어가는 컨텐츠 뷰의 Autolayout 높이 우선순위들은 999로 설정해야함.
    - Xib 사용시 AutoLayOut으로 높이를 설정시 identifier를 AUTOHEIGHTCONSTRAINT으로 설정해야함
    - 상속하여 사용하고, initBaseHeight을 반드시 설정해야함.
 */
@interface AutoHeightStackView : AutoHeightContentView {
    CGFloat baseHeight; //스택뷰 높이를 제외한 나머지 뷰 높이를 설정
    UIStackView *stackView;
}

@property (retain,nonatomic) IBOutlet UIStackView *stackView;
@property (assign, nonatomic) CGFloat baseHeight;

- (void)setBaseHeightWithConstraint:(CGFloat)height;

- (void)addContentView:(AutoHeightContentView *)view atIndex:(NSInteger)index;
- (void)addContentView:(AutoHeightContentView *)view;
- (void)removeContentView:(AutoHeightContentView *)view;
- (void)removeAllContentView;
- (void)refreshAutoHeight:(BOOL)isStackViewRefresh;
- (AutoHeightContentView *)objectAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
