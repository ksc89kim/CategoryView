//
//  MainCategoryCollectionViewCell.m
//  CategoryView
//
//  Created by kim sunchul on 2020/05/21.
//  Copyright © 2020 tronplay. All rights reserved.
//

#import "MainCategoryCollectionViewCell.h"

@interface MainCategoryCollectionViewCell()

- (void)updateUI;

@end

@implementation MainCategoryCollectionViewCell

- (void)dealloc {
    [_titleLabel release];
    [_cellData release];
    [_imageNew release];
    [super dealloc];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellData:(MainCategoryCellData *)cellData {
    [_cellData release];
    _cellData = cellData;
    [_cellData retain];
    
    [self updateUI];
}

- (void)updateUI {
    _titleLabel.text = [_cellData getTitle];
    _imageNew.hidden = !_cellData.isNew;
}

@end
