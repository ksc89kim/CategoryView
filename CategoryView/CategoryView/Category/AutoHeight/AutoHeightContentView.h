//
//  AutoHeightContentView.h
//  Mulban
//
//  Created by kim sunchul on 2018. 9. 25..
//  Copyright © 2018년 Baek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoHeightLabel.h"

#define AUTOHEIGHTCONSTRAINT @"autoHeightConstraint"

NS_ASSUME_NONNULL_BEGIN

/*
    자동 높이 조절 컨텐츠 뷰
    - 해당 뷰 높이를 조절하면 이 컨텐츠뷰와 연관된 뷰들이 같이 높이 조절이 됨.
    - AutoHeightStackView와 같이 사용해야함.
    - Xib 사용시 AutoLayOut으로 높이를 설정시 identifier를 AUTOHEIGHTCONSTRAINT으로 설정해야함
    - 상속하여 사용하고, initBaseHeight을 반드시 설정해야함.
 */

@interface AutoHeightContentView : UIView {
    NSLayoutConstraint *viewHeightConstraint;
    NSMutableArray<AutoHeightLabel *> *autoHeightLabels;
}

@property (retain, nonatomic) NSLayoutConstraint *viewHeightConstraint; //height 설정

// xib view 높이 설정
- (void)initHeight:(UIView *)xibView;
- (void)initHeight:(UIView *)xibView height:(CGFloat)height;
- (void)setConstraint:(UIView *)view;
- (void)setConstraint:(UIView *)view height:(CGFloat)height;
- (void)setConstraintHeight:(CGFloat)height;

// 높이 반환
- (CGFloat) getContentViewHeight;

- (NSLayoutConstraint *) findViewHeightConstraint:(UIView *)view identifier:(NSString *)identifier;

// 라벨 높이 자동 조절
- (void)addAutoLabel:(AutoHeightLabel *)label;
- (void)setLabelWithHeight:(AutoHeightLabel *)label;
- (void)refreshAutoLabels;

- (CGFloat)getStringHeight:(UILabel *)label;

@end

NS_ASSUME_NONNULL_END
