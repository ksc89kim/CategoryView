//
//  MainCategorySelectBar.m
//  CategoryView
//
//  Created by kim sunchul on 2018. 12. 8..
//  Copyright © 2018년 tronplay. All rights reserved.
//

#import "MainCategorySelectBar.h"

@implementation MainCategorySelectBar

- (void)dealloc {
    [_view release];
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
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setup];
}

- (void)setup {
    [self setNib];
    [self setUI];
}

- (void)setNib{
    _view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
    [_view setFrame:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
    [_view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:_view];
}

- (void)setUI{
    
}

@end
