//
//  MainCategoryGatherView.m
//  Mulban
//
//  Created by icenv_89 on 07/11/2018.
//  Copyright © 2018 Baek. All rights reserved.
//

#import "MainCategoryGatherView.h"
#import "MainCategoryGatherTabButtonView.h"

@implementation MainCategoryGatherView

- (void)dealloc {
    [_dimButton release];
    [_allTabView release];
    [tabController release];
    [_allTabViewHeight release];
    [super dealloc];
}

#pragma mark - Set Function

- (void)setController {
    [super setController];
    tabController = [[TabController alloc] init];
    [tabController setDelegate:self];
}

- (void)setUI {
    [super setUI];
}

- (void)setEvent{
    [super setEvent];
    [_dimButton addTarget:self action:@selector(onDim:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setData:(NSMutableArray<NSString *> *)data {
    [_data release];
    _data = data;
    [_data retain];
    [self updateUI];
}

- (void)setSelectIndex:(NSInteger)index {
    [tabController selectTabIndex:index];
}

#pragma mark - Update Function

-(void)updateUI {
    [self layoutIfNeeded];
    
    for (UIView *subView in [_allTabView subviews]) {
        [subView removeFromSuperview];
    }
    
    NSInteger index = 0;
    CGFloat padding = 6;
    NSInteger maxColumn = 3;
    CGFloat height = 39;
    CGFloat x = 0;
    CGFloat y = 13;
    CGFloat width = [self.view bounds].size.width / maxColumn - (padding * (maxColumn-1));
    NSInteger count = (_data.count / maxColumn);
    count = (_data.count % maxColumn == 0) ? count:count+1;
    NSMutableArray *tabs = [[[NSMutableArray alloc] init] autorelease];
    for (int i=1;i<=count;i++) {
        CGFloat blank = maxColumn;
        if (i == count) {
            blank = (_data.count % maxColumn == 0) ? blank : _data.count % maxColumn;
        }
        for(int j=1;j<=maxColumn;j++){
            if (j <= blank) {
                x = (width * (j-1) + padding * (j-1))+ 13;
                MainCategoryGatherTabButtonView *tabView =  [[[MainCategoryGatherTabButtonView alloc] initWithFrame:CGRectMake(x, y, width, height)] autorelease];
                [tabView.titleLabel setText:[_data objectAtIndex:index]];
                [tabs addObject:tabView];
                [_allTabView addSubview:tabView];
                index++;
            }
        }
        if (count == i) {
            y += height;
        } else {
            y += height + padding;
        }
    }
    [_allTabViewHeight setConstant:y+13];
    originalAllTabViewHeight = [_allTabViewHeight constant];
    [self layoutIfNeeded];
    [tabController setTabs:YES tabs:tabs];
}

#pragma mark - Event Function

- (void)onDim:(UIButton *)button {
   [self setHidden:YES];
    if ([_delegate respondsToSelector:@selector(touchGatherViewDimLayer)]) {
        [_delegate touchGatherViewDimLayer];
    }
}

- (void)touchTab:(TabController *)tabController selectedButtonView:(TabButtonView *)buttonView {
    [self setHidden:YES];
    if ([_delegate respondsToSelector:@selector(didSelectTab:index:)]) {
        [_delegate didSelectTab:self index:[buttonView tag]];
    }
}

#pragma mark - Animation Function

- (void)openAnimation {
    [self setHidden:NO];
    [_allTabViewHeight setConstant:0];
    [self layoutIfNeeded];

    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^(void) {
                         [_allTabViewHeight setConstant:originalAllTabViewHeight];
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                     }];

}

- (void)closeAnimation {
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^(void) {
                         [_allTabViewHeight setConstant:0];
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         [self setHidden:YES];
                     }];
}

@end
