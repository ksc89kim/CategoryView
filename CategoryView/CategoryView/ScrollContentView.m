//
//  ScrollContentView.m
//  CategoryView
//
//  Created by kim sunchul on 2018. 11. 10..
//  Copyright © 2018년 tronplay. All rights reserved.
//

#import "ScrollContentView.h"

@implementation ScrollContentView


- (void)dealloc {
    [_view release];
    [_titleLabel release];
    [_subCategoryView release];
    [super dealloc];
}

- (instancetype)init
{
    self = [self initWithFrame:[[[UIApplication sharedApplication] keyWindow] bounds]];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setNib];
        [self setUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setNib];
        [self setUI];
    }
    return self;
}

- (void)setNib{
    _view = [[[NSBundle mainBundle] loadNibNamed:@"ScrollContentView" owner:self options:nil] objectAtIndex:0];
    [_view setFrame:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
    [_view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:_view];
}

- (void)setUI {
    NSMutableArray *subData = [NSMutableArray arrayWithObjects:@"제1서브탭",@"제2서브탭",@"제3서브탭",@"제4서브탭", nil];
    
    [_subCategoryView setDelegate:self];
    [_subCategoryView setMaxColumn:4];
    [_subCategoryView setData:subData];
}

- (void)didSelectSubCategoryTab:(SubCategoryView *)view data:(NSString *)data {
    NSLog(@"sub tab %@",data);
}

@end
