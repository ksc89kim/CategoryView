//
//  ViewController.h
//  CategoryView
//
//  Created by kim sunchul on 2018. 11. 10..
//  Copyright © 2018년 tronplay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainCategoryView.h"

@interface ViewController : UIViewController <MainCategoryViewDelegate, UIScrollViewDelegate>

@property (retain, nonatomic) IBOutlet MainCategoryView *mainCategoryView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@end

