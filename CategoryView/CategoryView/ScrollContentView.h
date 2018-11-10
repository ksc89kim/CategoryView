//
//  ScrollContentView.h
//  CategoryView
//
//  Created by kim sunchul on 2018. 11. 10..
//  Copyright © 2018년 tronplay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubCategoryView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScrollContentView : UIView <SubCategoryViewDelegate>

@property (retain, nonatomic) IBOutlet UIView *view;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet SubCategoryView *subCategoryView;

@end

NS_ASSUME_NONNULL_END
