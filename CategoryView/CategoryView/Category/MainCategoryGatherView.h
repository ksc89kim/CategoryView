//
//  MainCategoryGatherView.h
//  Mulban
//
//  Created by icenv_89 on 07/11/2018.
//  Copyright © 2018 Baek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoHeightStackView.h"
#import "TabController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MainCategoryGatherViewDelegate;

@interface MainCategoryGatherView : UIView <TabControllerDelegate> {
    TabController *tabController;
    CGFloat originalAllTabViewHeight;
}

@property (retain, nonatomic) IBOutlet UIView *view;
@property (nonatomic, assign) id <MainCategoryGatherViewDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIButton *dimButton;
@property (retain, nonatomic) IBOutlet UIView *allTabView;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *allTabViewHeight;
@property (retain, nonatomic) NSMutableArray<NSString *> *data;

- (void)setSelectIndex:(NSInteger)index;
- (void)openAnimation;
- (void)closeAnimation;

@end

@protocol  MainCategoryGatherViewDelegate <NSObject>

- (void)didSelectTab:(MainCategoryGatherView *)view index:(NSInteger)index;
- (void)touchGatherViewDimLayer;

@end

NS_ASSUME_NONNULL_END
