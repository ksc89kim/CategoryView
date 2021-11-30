//
//  MainCategoryCellSize.m
//  CategoryView
//
//  Created by kim sunchul on 2020/05/26.
//  Copyright © 2020 tronplay. All rights reserved.
//

#import "MainCategoryCellSize.h"

@implementation MainCategoryCellSize

- (instancetype)init {
    self = [super init];
    if (self) {
        cellHeight = 42;
        newImageSize = 15;
        cellPadding = 20;
        stackViewPadding = 4;
    }
    return self;
}

- (CGSize)getSize:(BOOL)isNew title:(NSString *)title {
    return CGSizeMake([self getWidth:isNew title:title], cellHeight);
}

- (CGFloat)getWidth:(BOOL)isNew title:(nonnull NSString *)title{
    UIFont *boldFont = [UIFont boldSystemFontOfSize:14];
    NSDictionary *attributed = @{ NSFontAttributeName:boldFont };
  
    NSAttributedString *attributedString = [[[NSAttributedString alloc] initWithString:title attributes:attributed] autorelease];
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, cellHeight)
                                                     options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGFloat cellWidth = rect.size.width + cellPadding + 1;
    cellWidth += (isNew) ? newImageSize + stackViewPadding : 0;
    return cellWidth;
}

@end
