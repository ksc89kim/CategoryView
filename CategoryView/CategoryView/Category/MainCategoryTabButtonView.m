//
//  MainCategoryTabButtonView.m
//  TestTabView
//
//  Created by kim sunchul on 2018. 11. 3..
//  Copyright © 2018년 kim sunchul. All rights reserved.
//

#import "MainCategoryTabButtonView.h"

#define MAIN_CATEGORY_WIDTH_CONSTRAINT @"mainCategoryWidthConstraint"

@implementation MainCategoryTabButtonView

- (void)dealloc {
    [_view release];
    [_titleLabel release];
    [_imageView release];
    [super dealloc];
}

#pragma mark - Init Function

- (instancetype)init {
    self = [self initWithFrame:[[[UIApplication sharedApplication] keyWindow] bounds]];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

#pragma mark - Xib Function

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setup];
}

#pragma mark - Set Function

- (void)setup {
    [self setNib];
    [self setConstraint:_view];
    
    _viewWidthConstraint = [self findViewWidthConstraint];
    if(_viewWidthConstraint == nil) {
        _viewWidthConstraint =  [NSLayoutConstraint constraintWithItem:self
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:1
                                                              constant:100];
        _viewWidthConstraint.identifier = MAIN_CATEGORY_WIDTH_CONSTRAINT;
        [self addConstraint:_viewWidthConstraint];
    }
    
    [self setUI];
}

- (void)setNib{
    _view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
    [_view setFrame:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
    [_view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:_view];
}

- (void)setUI {
    [self setDefaultView];
}

- (void)setTabSelected:(BOOL)isSelected {
    [super setTabSelected:isSelected];
    if (isSelected) {
        [self setSelectedView];
    } else {
        [self setDefaultView];
    }
}

- (void) setDefaultView {
    [_titleLabel setTextColor:UIColor.blackColor];
    UIFont *font = [UIFont systemFontOfSize:[_titleLabel.font pointSize]];
    [_titleLabel setFont:font];
}

- (void) setSelectedView {
    [_titleLabel setTextColor:[UIColor colorWithRed:232/255 green:68/255 blue:24/255 alpha:1]];
    UIFont *font = [UIFont boldSystemFontOfSize:[_titleLabel.font pointSize]];
    [_titleLabel setFont:font];
}

#pragma mark - Find Function

- (NSLayoutConstraint *) findViewWidthConstraint {
    return [self findViewConstraint:self identifier:MAIN_CATEGORY_WIDTH_CONSTRAINT];
}

@end
