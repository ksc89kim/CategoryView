//
//  ViewController.m
//  CategoryView
//
//  Created by kim sunchul on 2018. 11. 10..
//  Copyright © 2018년 tronplay. All rights reserved.
//

#import "ViewController.h"
#import "ScrollContentView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *mainData = [NSMutableArray arrayWithObjects:@"제1탭",@"제2탭",@"제3탭",@"제4탭",@"제5탭",@"제6탭",@"제7탭", nil];
    NSMutableArray *subData = [NSMutableArray arrayWithObjects:@"제1서브탭",@"제2서브탭",@"제3서브탭",@"제4서브탭", nil];

    CGFloat x = 0;
    [_scrollView layoutIfNeeded];
    for (int i=0;i<[mainData count]; i++) {
        ScrollContentView *view = [[[ScrollContentView alloc] initWithFrame:CGRectMake(x, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)] autorelease];
        [_scrollView addSubview:view];
        [view.titleLabel setText:[mainData objectAtIndex:i]];
        x += _scrollView.bounds.size.width;
    }
    [_scrollView setContentSize:CGSizeMake(x,_scrollView.bounds.size.height)];
    [_scrollView setDelegate:self];
    
    [_mainCategoryView setDelegate:self];
    [_mainCategoryView setIsFitTextWidth:YES];
    [_mainCategoryView setPagerScollView:_scrollView];
    [_mainCategoryView setData:mainData];
    
    [_subCategoryView setDelegate:self];
    [_subCategoryView setMaxColumn:4];
    [_subCategoryView setData:subData];
}

- (void)dealloc {
    [_mainCategoryView release];
    [_subCategoryView release];
    [_scrollView release];
    [super dealloc];
}

- (void)didSelectMainCategoryTab:(MainCategoryView *)view data:(NSString *)data {
    
}

- (void)didSelectSubCategoryTab:(SubCategoryView *)view data:(NSString *)data {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_mainCategoryView updatePagerScrollView];
}

@end
