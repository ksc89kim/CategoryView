//
//  MainCategoryTabButtonView.m
//  TestTabView
//
//  Created by kim sunchul on 2018. 11. 3..
//  Copyright © 2018년 kim sunchul. All rights reserved.
//

#import "MainCategoryTabButtonView.h"

@implementation MainCategoryTabButtonView


- (void)dealloc {
    [_view release];
    [_titleLabel release];
    [_imageView release];
    [super dealloc];
}

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
    [self setConstraint:_view];
}

- (void)setUI {
    [self setDefaultView];
}

- (void)setConstraint:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *viewWidth =  [NSLayoutConstraint constraintWithItem:view
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1
                                                                   constant:0];
    
    
    NSLayoutConstraint *viewHeight =  [NSLayoutConstraint constraintWithItem:view
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeHeight
                                                                  multiplier:1
                                                                    constant:0];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:view
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1
                                                                constant:0];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:view
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1
                                                                constant:0];
    
    [self addConstraints:[NSArray arrayWithObjects:viewWidth,viewHeight,centerX,centerY,nil]];
    
    _viewWidthConstraint = [self findViewWidthConstraint];
    if(_viewWidthConstraint == nil) {
        _viewWidthConstraint =  [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1
                                                                   constant:100];
        _viewWidthConstraint.identifier = @"mainCategoryWidthConstraint";
        [self addConstraint:_viewWidthConstraint];
    }
}

- (void)setTabSelected:(BOOL)isSelected {
    [super setTabSelected:isSelected];
    if (isSelected) {
        [self setSelectedView];
    } else {
        [self setDefaultView];
    }
}

- (NSLayoutConstraint *) findViewConstraint:(UIView *)view identifier:(NSString *)identifier{
    NSLayoutConstraint *findConstraint = nil;
    for(NSLayoutConstraint *cons in view.constraints)   {
        if ([cons.identifier isEqualToString:identifier]) {
            findConstraint = cons;
            break;
        }
    }
    return findConstraint;
}

- (NSLayoutConstraint *) findViewWidthConstraint {
    return [self findViewConstraint:self identifier:@"mainCategoryWidthConstraint"];
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

@end
