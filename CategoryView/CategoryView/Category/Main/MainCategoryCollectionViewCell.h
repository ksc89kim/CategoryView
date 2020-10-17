//
//  MainCategoryCollectionViewCell.h
//  CategoryView
//
//  Created by kim sunchul on 2020/05/21.
//  Copyright © 2020 tronplay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainCategoryCellData.h"

#define MAIN_CATEGORY_IDENTIFIER @"MAIN_CATEGORY_CELL"


NS_ASSUME_NONNULL_BEGIN

@interface MainCategoryCollectionViewCell : UICollectionViewCell

@property (retain, nonatomic) MainCategoryCellData *cellData;
@property (retain, nonatomic) IBOutlet UIImageView *imageNew;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
