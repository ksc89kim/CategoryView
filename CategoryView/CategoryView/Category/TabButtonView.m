//
//  TabButtonView.m
//  Mulban
//
//  Created by kim sunchul on 2018. 9. 25..
//  Copyright © 2018년 Baek. All rights reserved.
//

#import "TabButtonView.h"

@implementation TabButtonView

- (void)dealloc {
    [_actionButton release];
    [super dealloc];
}

#pragma mark - Set Function

- (void)setTabSelected:(BOOL)isSelected {
    [_actionButton setSelected:isSelected];
}

@end
