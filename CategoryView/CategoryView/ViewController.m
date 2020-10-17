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

- (void)dealloc {
    [_mainCategoryView release];
    [_scrollView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSMutableArray *cellDatas = [self getCellDatas];
    
    [self setScroll];
    [self setMainCategory:cellDatas];
    
    [self createScrollContentUI:cellDatas];
}

- (void)setMainCategory:(NSMutableArray *)cellDatas{
    [_mainCategoryView setDelegate:self];
    [_mainCategoryView setPagerScollView:_scrollView];
    [[_mainCategoryView getController] addDataArray:cellDatas];
    [_mainCategoryView updateUI];
}

- (void)setScroll {
    [_scrollView setDelegate:self];
}

- (void)createScrollContentUI:(NSMutableArray *)cellDatas{
    CGFloat xOffset = 0;
    
    [_scrollView layoutIfNeeded];
    
    for (int i=0;i<[cellDatas count]; i++) {
        MainCategoryCellData *cellData = [cellDatas objectAtIndex:i];
        
        ScrollContentView *view = [[[ScrollContentView alloc] initWithFrame:CGRectMake(xOffset, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)] autorelease];
        [view.titleLabel setText:[cellData getTitle]];
        [_scrollView addSubview:view];
        
        xOffset += _scrollView.bounds.size.width;
    }
    
    [_scrollView setContentSize:CGSizeMake(xOffset,_scrollView.bounds.size.height)];
}

- (NSMutableArray *)getCellDatas {
    NSMutableArray *cellDatas = [NSMutableArray array];

    for (int i=0;i<7;i++) {
        MainCategoryCellData *cellData = [MainCategoryCellData createCellData:[NSString stringWithFormat:@"%d탭 ########", i+1]];
        [cellDatas addObject:cellData];
    }
    
    return cellDatas;
}

- (void)didSelectMainCategoryTab:(MainCategoryView *)view data:(NSString *)data {
    NSLog(@"tab %@",data);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_mainCategoryView updatePagerScrollView];
}

@end
