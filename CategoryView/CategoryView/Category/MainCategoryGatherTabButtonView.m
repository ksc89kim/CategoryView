//
//  MainCategoryGatherTabButtonView.m
//  Mulban
//
//  Created by icenv_89 on 08/11/2018.
//  Copyright © 2018 Baek. All rights reserved.
//

#import "MainCategoryGatherTabButtonView.h"

@implementation MainCategoryGatherTabButtonView


- (void)dealloc {
    [_view release];
    [_titleLabel release];
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
    _view = [[[NSBundle mainBundle] loadNibNamed:@"MainCategoryGatherTabButtonView" owner:self options:nil] objectAtIndex:0];
    [_view setFrame:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
    [_view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:_view];
    [self setDefaultView];
}

- (void)setUI {
    [self.layer setCornerRadius:7];
    [self.layer setBorderWidth:1];
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
    ;
    [self.layer setBorderColor:[[UIColor colorWithRed:235/255 green:235/255 blue:235/255 alpha:1] CGColor]];
    [_titleLabel setTextColor:[UIColor colorWithRed:35/255 green:25/255 blue:22/255 alpha:1] ];
    UIFont *font = [UIFont systemFontOfSize:[_titleLabel.font pointSize]];
    [_titleLabel setFont:font];
}

- (void) setSelectedView {
    [self.layer setBorderColor:[[UIColor colorWithRed:232/255 green:68/255 blue:24/255 alpha:1] CGColor]];
    [_titleLabel setTextColor:[UIColor colorWithRed:232/255 green:68/255 blue:24/255 alpha:1]];
    UIFont *font = [UIFont boldSystemFontOfSize:[_titleLabel.font pointSize]];
    [_titleLabel setFont:font];
}



@end