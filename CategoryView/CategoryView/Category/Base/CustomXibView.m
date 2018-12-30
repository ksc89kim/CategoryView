//
//  CustomXibView.m
//  CategoryView
//
//  Created by kim sunchul on 2018. 12. 30..
//  Copyright © 2018년 tronplay. All rights reserved.
//

#import "CustomXibView.h"

@implementation CustomXibView

@synthesize view = _view;

- (void)dealloc {
    [view release];
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
    [self setConstraint:view];
    [self setUI];
    [self setController];
    [self setEvent];
}

- (void)setNib{
    view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
    [view setFrame:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:view];
}

- (void)setUI {
}

- (void)setController {
}

- (void)setEvent {
    
}


@end
