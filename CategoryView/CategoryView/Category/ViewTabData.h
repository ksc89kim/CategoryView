//
//  ViewTabData.h
//  CategoryView
//
//  Created by kim sunchul on 2018. 11. 10..
//  Copyright © 2018년 tronplay. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef ViewTabData_h
#define ViewTabData_h

/*
    카테고리 데이터
 */
@interface ViewTabData : NSObject
@property (retain, nonatomic) NSString *title;
@property (assign) BOOL isNew;

@end

#endif /* ViewTabData_h */
