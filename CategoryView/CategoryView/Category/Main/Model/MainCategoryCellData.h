//
//  MainCategoryCellData.h
//  CategoryView
//
//  Created by kim sunchul on 2020/05/26.
//  Copyright © 2020 tronplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MainCategoryCellSize.h"
#import "MainCategoryData.h"

NS_ASSUME_NONNULL_BEGIN

#define MAIN_CATEGORY_IDENTIFIER @"MAIN_CATEGORY_CELL"

@interface MainCategoryCellData : NSObject <MainCategoryData> {
    MainCategoryCellSize *size;
    NSString *cellTitle;
}

@property BOOL isNew;

+ (MainCategoryCellData *)createCellData:(NSString *)title;
+ (MainCategoryCellData *)createCellData:(NSString *)title withIsNew:(BOOL)isNew;
- (CGSize)getCellSize;

@end

NS_ASSUME_NONNULL_END
