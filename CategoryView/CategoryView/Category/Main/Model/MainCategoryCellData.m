//
//  MainCategoryCellData.m
//  CategoryView
//
//  Created by kim sunchul on 2020/05/26.
//  Copyright © 2020 tronplay. All rights reserved.
//

#import "MainCategoryCellData.h"

@implementation MainCategoryCellData

- (void)dealloc {
    [size release];
    [cellTitle release];
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        size = [[MainCategoryCellSize alloc] init];
        _isNew = false;
    }
    return self;
}

+ (MainCategoryCellData *)createCellData:(NSString *)title {
    return [MainCategoryCellData createCellData:title withIsNew:false];
}

+ (MainCategoryCellData *)createCellData:(NSString *)title withIsNew:(BOOL)isNew {
    MainCategoryCellData *data = [[[MainCategoryCellData alloc] init] autorelease];
    [data setTitle:title];
    data.isNew = isNew;
    return data;
}

- (void)setTitle:(NSString *)title {
    [cellTitle release];
    cellTitle = title;
    [cellTitle retain];
}

- (NSString *)getTitle {
    return cellTitle;
}

- (CGSize)getCellSize {
    return [size getSize:_isNew title:[self getTitle]];
}

@end
