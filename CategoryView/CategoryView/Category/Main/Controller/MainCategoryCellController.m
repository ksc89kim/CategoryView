//
//  MainCategoryCellController.m
//  CategoryView
//
//  Created by kim sunchul on 2020/05/26.
//  Copyright © 2020 tronplay. All rights reserved.
//

#import "MainCategoryCellController.h"

@implementation MainCategoryCellController

- (void)dealloc {
    [cellDatas release];
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        cellDatas = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSInteger)count {
    return cellDatas.count;
}

-(void)addData:(id<MainCategoryData>)data {
    [cellDatas addObject:data];
}

-(void)addDataArray:(NSMutableArray<id<MainCategoryData>> *)array {
    [cellDatas addObjectsFromArray:array];
}

-(void)addDataForTitle:(NSString *)title {
    [cellDatas addObject:[MainCategoryCellData createCellData:title]];
}

-(void)addDataForTitle:(NSString *)title withIsNew:(BOOL)isNew {
    [cellDatas addObject:[MainCategoryCellData createCellData:title withIsNew:isNew]];
}

-(void)setIsNew:(BOOL)isNew atIndex:(NSInteger)index {
    for (int i=0; i < cellDatas.count; i ++) {
        [[cellDatas objectAtIndex:i] setIsNew:index==i];
    }
}

-(id<MainCategoryData>)dataAtIndex:(NSInteger)index {
    return [cellDatas objectAtIndex:index];
}

-(CGSize)sizeAtIndex:(NSInteger)index {
  return [[cellDatas objectAtIndex:index] getCellSize];
}

-(CGRect)rectAtIndex:(NSInteger)index {
  CGFloat x = 0;
  for (int i=0; i < cellDatas.count; i ++) {
      CGSize size = [self sizeAtIndex:index];
      if (index == i) {
        return CGRectMake(x, 0, size.width, size.height);
      }
      x += size.width;
  }

  return CGRectZero;
}


@end
