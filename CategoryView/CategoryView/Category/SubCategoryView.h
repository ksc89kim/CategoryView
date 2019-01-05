//
//  SubTabView.h
//  Mulban
//
//  Created by kim sunchul on 2018. 10. 14..
//  Copyright © 2018년 Baek. All rights reserved.
//

#import "AutoHeightStackView.h"
#import "TabController.h"
#import "TabButtonView.h"

NS_ASSUME_NONNULL_BEGIN

/*
    서브 카테고리 뷰
    - 카테고리에 해당하는 뷰들을 구성 및 애니메이션을 가지고 있음.
 */
@protocol SubCategoryViewDelegate;
@class ViewTabData;
@interface SubCategoryView : AutoHeightStackView <TabControllerDelegate>{
    TabController *tabController;
    NSMutableArray<TabButtonView *> *tabViews;
    BOOL isViewTabData;
}

@property (nonatomic, assign) id <SubCategoryViewDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIView *view;
@property (retain, nonatomic) NSMutableArray<NSString *> *data;
@property (retain, nonatomic) NSMutableArray<ViewTabData *> *viewTabData;
@property NSInteger maxColumn;
@property (assign, nonatomic) NSInteger selectIndex;

- (void)tabAnimation;
- (ViewTabData *)getCurrentViewTabData;

@end

@protocol SubCategoryViewDelegate <NSObject>
@optional
- (void)didSelectSubCategoryTab:(SubCategoryView *)view data:(NSString *)data;
- (void)didSelectSubCategoryTab:(SubCategoryView *)view index:(NSInteger)index;
- (void)didSelectSubCategoryTab:(SubCategoryView *)view viewTabData:(ViewTabData *)data;
@end

NS_ASSUME_NONNULL_END
