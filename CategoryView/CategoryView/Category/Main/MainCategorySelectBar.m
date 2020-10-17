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

@interface MainCategorySelectBar()

- (BOOL)isMove:(MainCategoryCurrentData *)data count:(NSInteger)count;
- (NSLayoutConstraint *) findViewWidthConstraint;
- (NSLayoutConstraint *) findViewLeftConstraint;

@end

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

- (BOOL)move:(CGFloat)beforeOffsetX data:(MainCategoryCurrentData *)data count:(NSInteger)count {
    if ([self isMove:data count:count]) {
        CGRect cellFrame = [data getCellFrame];
        CGFloat cellPercentWidth = [data getPercentCellWidth];

        switch ([data getDirection:beforeOffsetX]) {
            case LeftDirection: {
              CGFloat minusPosition = cellFrame.size.width - cellPercentWidth;
              [_viewLeftConstraint setConstant:(cellFrame.origin.x + cellFrame.size.width) - minusPosition];
            }
                break;
            case RightDirection: {
                [_viewLeftConstraint setConstant:cellFrame.origin.x + cellPercentWidth];
            }
            break;
            default:
                break;
        }
        return true;
    }
    return false;
}

- (void)updateWidth:(CGRect)nextCellFrame data:(MainCategoryCurrentData *)data {
    if (CGRectEqualToRect(nextCellFrame, CGRectZero) || CGRectEqualToRect([data getCellFrame], CGRectZero)) {
        return;
    }
    
    CGFloat percent = ((nextCellFrame.size.width - [data getCellFrame].size.width) * data.scrollPercent / 100);
    [_viewWidthConstraint setConstant:[data getCellFrame].size.width + percent];
}

- (BOOL)isMove:(MainCategoryCurrentData *)data count:(NSInteger)count {
    if (data.scrollPercent < 0 || CGRectEqualToRect([data getCellFrame], CGRectZero) || !(data.index >= 0 && data.index < count - 1 )) {
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
