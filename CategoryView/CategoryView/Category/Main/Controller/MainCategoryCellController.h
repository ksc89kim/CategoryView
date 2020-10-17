//
//  MainCategoryCellController.h
//  CategoryView
//
//  Created by kim sunchul on 2020/05/26.
//  Copyright © 2020 tronplay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainCategoryController.h"
#import "MainCategoryCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainCategoryCellController : NSObject <MainCategoryController> {
    NSMutableArray<MainCategoryCellData *> *cellDatas;
}

-(void)addDataForTitle:(NSString *)title;
-(void)addDataForTitle:(NSString *)title withIsNew:(BOOL)isNew;

@end

NS_ASSUME_NONNULL_END
