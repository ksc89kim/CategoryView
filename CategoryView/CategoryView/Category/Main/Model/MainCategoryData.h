//
//  MainCategoryData.h
//  CategoryView
//
//  Created by kim sunchul on 2020/05/26.
//  Copyright © 2020 tronplay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MainCategoryData <NSObject>

- (void)setTitle:(NSString *)title;
- (NSString *)getTitle;

@end

NS_ASSUME_NONNULL_END
