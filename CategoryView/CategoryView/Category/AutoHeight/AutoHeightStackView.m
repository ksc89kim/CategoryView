//
//  AutoHeightStackView.m
//  Mulban
//
//  Created by kim sunchul on 2018. 9. 25..
//  Copyright © 2018년 Baek. All rights reserved.
//

#import "AutoHeightStackView.h"

@implementation AutoHeightStackView

@synthesize stackView,baseHeight;

- (void)dealloc {
    [stackView release];
    [super dealloc];
}

- (void)initHeight:(UIView *)xibView {
    [super initHeight:xibView];
    [self setBaseHeight:[self.viewHeightConstraint constant]];
    [self refreshAutoHeight:YES];
}

- (void)initHeight:(UIView *)xibView height:(CGFloat)height {
    [self setBaseHeight:height];
    [super initHeight:xibView height:height];
    [self refreshAutoHeight:YES];
}

#pragma mark - Set Function
- (void)setBaseHeightWithConstraint:(CGFloat)height {
    [self setBaseHeight:height];
    [self setConstraintHeight:height];
}


- (void)setLabelWithHeight:(AutoHeightLabel *)label {
    CGFloat willHeight = [self getStringHeight:label];
    CGFloat finalHeight = 0;
    finalHeight =  [self.viewHeightConstraint constant] - label.baseHeight + willHeight;
    [self setConstraintHeight:finalHeight];
    [label.viewHeightConstraint setConstant:willHeight];
}

#pragma mark - Get Function

- (CGFloat) getAutoHeightWithRefresh:(BOOL)isStackViewRefresh {
    CGFloat autoHeight = [self getAutoHeight:isStackViewRefresh];
    [self setConstraintHeight:autoHeight];
    CGFloat finalHeight = [self getContentViewHeight];
    return finalHeight;
}

- (CGFloat) getAutoHeight:(BOOL)isStackViewRefresh {
    CGFloat totalHeight = 0;
    
    for (int i=0;i<[[stackView arrangedSubviews] count];i++) {
        UIView *view = [[stackView arrangedSubviews]  objectAtIndex:i];
        if ([view isKindOfClass:[AutoHeightStackView class]]) {
            if (isStackViewRefresh) {
                CGFloat height = [(AutoHeightStackView *)view getAutoHeightWithRefresh:isStackViewRefresh];
                totalHeight += [self getHeightWithSpacing:[view isHidden] height:height index:i];
            } else {
                totalHeight += [self getHeightWithSpacing:(AutoHeightStackView *)view index:i];
            }
        } else if ([view isKindOfClass:[AutoHeightContentView class]]){
            totalHeight += [self getHeightWithSpacing:(AutoHeightStackView *)view index:i];
        } else {
             NSLayoutConstraint *height = [self findViewConstraint:view identifier:AUTOHEIGHTCONSTRAINT];
            if (height != nil) {
                totalHeight += [self getHeightWithSpacing:[view isHidden] height:[height constant] index:i];
            } else {
                totalHeight += [self getHeightWithSpacing:[view isHidden] height:view.frame.size.height index:i];
            }
        }
    }
   
    return totalHeight + baseHeight;
}

- (CGFloat)getHeightWithSpacing:(AutoHeightContentView *)view index:(NSInteger)index {
    CGFloat height = [view getContentViewHeight];
    return [self getHeightWithSpacing:[view isHidden] height:height index:index];
}

- (CGFloat)getHeightWithSpacing:(BOOL)isHidden height:(CGFloat)height index:(NSInteger)index {
    if (isHidden) {
        return 0;
    }
    return height + [self getSpacing:index];
}

- (CGFloat)getSpacing:(NSInteger)index {
    NSInteger count = [[stackView arrangedSubviews] count];
    if (count == 1) {
        return 0;
    }
    return (index < ( count - 1)) ? [stackView spacing] : 0;
}

#pragma mark - ETC Function

- (void)addContentView:(AutoHeightContentView *)view atIndex:(NSInteger)index{
    CGFloat height = [self calHeight:view.viewHeightConstraint.constant];
    [stackView insertArrangedSubview:view atIndex:index];
    [self setConstraintHeight:height];
}

- (void)addContentView:(AutoHeightContentView *)view {
    CGFloat height = [self calHeight:view.viewHeightConstraint.constant];
    [stackView addArrangedSubview:view];
    [self setConstraintHeight:height];
}

- (void)removeAllContentView {
    for (AutoHeightContentView *view in [stackView arrangedSubviews]) {
         [stackView removeArrangedSubview:view];
         [view removeFromSuperview];
    }
    [self setConstraintHeight:baseHeight];
}

- (void)removeContentView:(AutoHeightContentView *)view {
    NSInteger count = [[stackView arrangedSubviews] count];
    CGFloat height = viewHeightConstraint.constant-view.viewHeightConstraint.constant;
    CGFloat spaceHeight = [self getSpacing:count];
    [self setConstraintHeight:height-spaceHeight];
    [stackView removeArrangedSubview:view];
    [view removeFromSuperview];
}

- (CGFloat)calHeight:(CGFloat)viewHeight {
    NSInteger count = [[stackView arrangedSubviews] count];
    CGFloat height = viewHeightConstraint.constant+viewHeight;
    CGFloat spaceHeight = [self getSpacing:count];
    return height+spaceHeight;
}

- (AutoHeightContentView *)objectAtIndex:(NSInteger)index {
    return [[self.stackView arrangedSubviews] objectAtIndex:index];
}

- (void) refreshAutoHeight:(BOOL)isStackViewRefresh {
    CGFloat autoHeight = [self getAutoHeight:isStackViewRefresh];
    [self setConstraintHeight:autoHeight];
    [self refreshAutoLabels];
}

@end
