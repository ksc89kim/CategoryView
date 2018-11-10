//
//  SubCategoryButtonView.m
//  Mulban
//
//  Created by kim sunchul on 2018. 10. 14..
//  Copyright © 2018년 Baek. All rights reserved.
//

#import "SubCategoryTabButtonView.h"

@implementation SubCategoryTabButtonView

- (void)dealloc {
    [_view release];
    [_titleLabel release];
    [_blankImageView release];
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
    _view = [[[NSBundle mainBundle] loadNibNamed:@"SubCategoryTabButtonView" owner:self options:nil] objectAtIndex:0];
    [_view setFrame:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
    [_view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:_view];
    [self setDefaultView];
}

- (void)setUI {
    [self setBlankHidden:YES];
}

- (void)setBlankHidden:(BOOL)isHidden {
    if (isHidden) {
        [_view.layer setCornerRadius:7];
        [_view.layer setBorderWidth:1];
        [_view.layer setBorderColor:[[UIColor colorWithRed:235/255 green:235/255 blue:235/255 alpha:1] CGColor]];
        [_view.layer setBackgroundColor:[UIColor.whiteColor CGColor]];
    } else {
        [_view.layer setCornerRadius:0];
        [_view.layer setBorderWidth:0];
        [_view.layer setBackgroundColor:[UIColor.clearColor CGColor]];
    }
    [_titleLabel setHidden:!isHidden];
    [_blankImageView setHidden:isHidden];
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
    [_titleLabel setTextColor:[UIColor colorWithRed:135/255 green:135/255 blue:135/255 alpha:1]];
    UIFont *font = [UIFont systemFontOfSize:[_titleLabel.font pointSize]];
    [_titleLabel setFont:font];
}

- (void) setSelectedView {
    [_titleLabel setTextColor:[UIColor colorWithRed:62/255 green:62/255 blue:62/255 alpha:1]];
    UIFont *font = [UIFont boldSystemFontOfSize:[_titleLabel.font pointSize]];
    [_titleLabel setFont:font];
}

@end
