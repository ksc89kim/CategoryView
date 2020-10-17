//
//  MainCategoryCellSize.h
//  CategoryView
//
//  Created by kim sunchul on 2020/05/26.
//  Copyright © 2020 tronplay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellSize.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainCategoryCellSize : NSObject <CellSize> {
    CGFloat cellHeight;
    CGFloat cellPadding;
    CGFloat stackViewPadding;
    CGFloat newImageSize;
}

@end

NS_ASSUME_NONNULL_END
