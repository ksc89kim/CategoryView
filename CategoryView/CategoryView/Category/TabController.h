//
//  TabController.h
//  Mulban
//
//  Created by kim sunchul on 2018. 9. 21..
//  Copyright © 2018년 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TabButtonView.h"

/*
    탭 컨트롤러
    - 버튼을 탭형태로 컨트롤러 함.
    - 커스텀 탭뷰도 가능.
 */
@protocol TabControllerDelegate;
@interface TabController : NSObject {
    BOOL isViews;
}

@property (nonatomic, assign) id <TabControllerDelegate> delegate;
@property (retain, nonatomic) NSMutableArray<TabButtonView *> *buttonViews;
@property (retain, nonatomic) NSMutableArray<UIButton *> *buttons;
@property (assign, nonatomic) BOOL isViews;

- (instancetype)initWithButtons:(NSMutableArray<UIButton *> *)buttons;
- (instancetype)initWithButtonViews:(NSMutableArray<TabButtonView *> *)buttons;

- (void)setTabs:(BOOL)isViews tabs:(NSMutableArray *)tabs;

- (void)selectTabViewButton:(TabButtonView *)sender;
- (void)selectTabButton:(UIButton *)sender;
- (void)selectTabIndex:(NSInteger )index;

- (UIButton *)getButton:(NSInteger)index;
- (TabButtonView *)getButtonView:(NSInteger)index;
- (NSInteger)count;

@end

@protocol TabControllerDelegate <NSObject>
@optional
- (void) touchTab:(TabController *)tabController selectedButtonView:(TabButtonView *)buttonView;
- (void) touchTab:(TabController *)tabController selectedButton:(UIButton *)button;
@end

