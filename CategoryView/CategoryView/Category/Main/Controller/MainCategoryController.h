//
//  MainCategoryController.h
//  CategoryView
//
//  Created by kim sunchul on 2020/05/26.
//  Copyright © 2020 tronplay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainCategoryData.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MainCategoryController <NSObject>

-(NSInteger)count;
-(void)addData:(id<MainCategoryData>)data;
-(void)addDataArray:(NSMutableArray<id<MainCategoryData>> *)array;
-(void)setIsNew:(BOOL)isNew atIndex:(NSInteger)index;
-(id<MainCategoryData>)dataAtIndex:(NSInteger)index;
-(CGSize)sizeAtIndex:(NSInteger)index;
-(CGRect)rectAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
