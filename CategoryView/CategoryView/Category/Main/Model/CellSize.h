//
//  CellSize.h
//  CategoryView
//
//  Created by kim sunchul on 2020/05/26.
//  Copyright © 2020 tronplay. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CellSize <NSObject>

- (CGSize)getSize:(BOOL)isNew title:(NSString *)title;
- (CGFloat)getWidth:(BOOL)isNew title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
