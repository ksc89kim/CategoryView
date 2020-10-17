//
//  MainCategoryView.m
//  TestTabView
//
//  Created by kim sunchul on 2018. 11. 3..
//  Copyright © 2018년 kim sunchul. All rights reserved.
//

#import "MainCategoryView.h"

@interface MainCategoryView()

- (void)registerCell;
- (void)setCollection;
- (void)setGatherButtonHidden:(BOOL)hidden;
- (void)moveCenterScrollView;
- (void)moveCenterScrollView:(CGRect)rect;
- (void)doDelegate;

@end

@implementation MainCategoryView

- (void)dealloc {
    [controller release];
    [_buttonViewWidthConstraint release];
    [_topLine release];
    [_shadowImageView release];
    [_collectionView release];
    [currentData release];
    [_selectBar release];
    [_contentViewWidthConstraint release];
    [_selectScrollView release];
    [super dealloc];
}

#pragma mark - Set Function

- (void)setController {
    [super setController];
    
    if (controller == nil) {
        controller = [[MainCategoryCellController alloc] init];
        [gatherView setController:controller];
    }
    
    if (currentData == nil) {
        currentData = [[MainCategoryCurrentData alloc] init];
    }
    
    [self registerCell];
    [self setCollection];
}

- (void)setUI {
    [super setUI];
    [self setGatherUI];
}

- (void)setEvent {
    [super setEvent];
    [_actionButton addTarget:self action:@selector(onGatherView:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)registerCell {
    UINib *nib = [UINib nibWithNibName:@"MainCategoryCollectionViewCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:MAIN_CATEGORY_IDENTIFIER];
}

- (void)setCollection {
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
}

- (void)setGatherUI {
    gatherView = [[MainCategoryGatherView alloc] init];
    [gatherView setDelegate:self];
    
    gatherView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:gatherView];
    
    [[gatherView.topAnchor constraintEqualToAnchor:self.bottomAnchor constant:0] setActive:YES];
    [[gatherView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0] setActive:YES];
    [[gatherView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0] setActive:YES];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    CGFloat height = 0;
    if (window.bounds.size.height == 0) {
        height = CGFLOAT_MAX;
    } else {
        height = window.bounds.size.height;
    }
    
    [[gatherView.heightAnchor constraintEqualToConstant:height] setActive:YES];
    [gatherView setHidden:YES];
}

- (void)setSelectIndex:(NSInteger)index {
    if ([controller count] < 1) {
        return;
    }
    
    isAnimation = YES;
    _selectIndex = index;
    [gatherView setSelectIndex:_selectIndex];

    if (_pagerScollView != nil) {
        [_pagerScollView setContentOffset:CGPointMake([_pagerScollView bounds].size.width * _selectIndex, _pagerScollView.contentOffset.y) animated:YES];
    }
    CGRect cellRect = [controller rectAtIndex:_selectIndex];
    [self moveCenterScrollView:cellRect];
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^(void) {
        [_selectBar setWidthWithLeft:cellRect.size.width left:cellRect.origin.x];
        [self layoutIfNeeded];
    }
                     completion:^(BOOL finished) {
        isAnimation = NO;
        
    }];
    [self doDelegate];
}

- (void)setGatherButtonHidden:(BOOL)hidden {
    [_actionButton setHidden:hidden];
    if (hidden) {
        [_buttonViewWidthConstraint setConstant:0];
    } else {
        [_buttonViewWidthConstraint setConstant:42];
    }
}

#pragma mark - Get Function

- (id<MainCategoryData>)getSelectedData {
    return [controller dataAtIndex:_selectIndex];
}

- (id<MainCategoryController>)getController {
    return controller;
}

#pragma mark - Update Function

- (void)updateUI {
    [view layoutIfNeeded];
    [gatherView updateUI];
    [_collectionView reloadData];
    [_collectionView performBatchUpdates:^{
    } completion:^(BOOL finished) {
      [_contentViewWidthConstraint setConstant:_collectionView.contentSize.width];
    }];

}

- (void)updatePagerScrollView {
    if(isAnimation || _pagerScollView == nil) {
        return;
    }

    [currentData setCurrentData:_pagerScollView controller:controller];
    if ([_selectBar move:beforeOffsetX data:currentData count:[controller count]]) {
        CGRect cellRect = [controller rectAtIndex:currentData.index+1];
        [_selectBar updateWidth:cellRect data:currentData];
    }

    if (currentData.scrollPercent < 1){
        _selectIndex = currentData.index;
        [self moveCenterScrollView];
        [gatherView setSelectIndex:_selectIndex];
        [self doDelegate];
    }
    
    beforeOffsetX = currentData.offsetX;
}

#pragma mark - Etc Function

- (void) moveCenterScrollView {
    CGRect cellRect = [controller rectAtIndex:_selectIndex];
    [self moveCenterScrollView:cellRect];
}

- (void) moveCenterScrollView:(CGRect)rect {
    CGFloat movePositionX = rect.origin.x + (rect.size.width/2) - _selectScrollView.bounds.size.width/2;
    CGFloat limitPosition = _contentViewWidthConstraint.constant - _selectScrollView.bounds.size.width;
    movePositionX = (movePositionX < 0) ? 0:movePositionX;
    movePositionX = (movePositionX > limitPosition) ? limitPosition:movePositionX;
    [_collectionView setContentOffset:CGPointMake(movePositionX, _collectionView.contentOffset.y) animated:YES];
}

- (void)doDelegate {
    if ([_delegate respondsToSelector:@selector(didSelectMainCategoryTab:data:)]) {
        [_delegate didSelectMainCategoryTab:self data:[controller dataAtIndex:_selectIndex]];
    }
    
    if ([_delegate respondsToSelector:@selector(didSelectMainCategoryTab:index:)]) {
        [_delegate didSelectMainCategoryTab:self index:_selectIndex];
    }
}


- (void)startScrollAnimation {
    CGFloat tailOffsetW = _collectionView.contentSize.width - _collectionView.bounds.size.width;
    if (tailOffsetW > 50) {
        tailOffsetW = 50;
    }

    [_collectionView setContentOffset:CGPointMake(tailOffsetW, 0)];
    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^(void) {
                         [_collectionView setContentOffset:CGPointMake(0, 0)];
                     }
                     completion:nil];
}

#pragma mark - GatherView Function

- (void)onGatherView:(UIButton *)button {
    if (button.isSelected) {
        [self closeGatherView:YES];
    } else {
        [self openGatherView:YES];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint viewPoint = [gatherView convertPoint:point fromView:self];
    
    if (self.clipsToBounds) {
        return nil;
    } else if (self.hidden) {
        return nil;
    } else if (self.alpha == 0) {
        return nil;
    }
    
    if ([gatherView pointInside:viewPoint withEvent:event] ) {
        return [gatherView hitTest:viewPoint withEvent:event];
    }
    
    return [super hitTest:point withEvent:event];
}

- (void)openGatherView:(BOOL)isAnimation{
    [_actionButton setSelected:YES];
    [_gatherTitleView setHidden:NO];
    if (isAnimation) {
        [gatherView openAnimation];
    } else {
        [gatherView setHidden:NO];
    }
}

- (void)closeGatherView:(BOOL)isAnimation {
    [_actionButton setSelected:NO];
    [_gatherTitleView setHidden:YES];
    if (isAnimation) {
        [gatherView closeAnimation];
    } else {
        [gatherView setHidden:YES];
    }
}

#pragma mark - TabControllerDelegate

-(void)touchTab:(TabController *)tabController selectedButtonView:(TabButtonView *)buttonView {
    [self setSelectIndex:[buttonView tag]];
}

#pragma mark - MainCategoryGatherViewDelegate

- (void)touchGatherViewDimLayer {
    [_actionButton setSelected:NO];
    [_gatherTitleView setHidden:YES];
}

- (void)didSelectTab:(MainCategoryGatherView *)view index:(NSInteger)index {
    [_actionButton setSelected:NO];
    [_gatherTitleView setHidden:YES];
    [self setSelectIndex:index];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [controller count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MAIN_CATEGORY_IDENTIFIER forIndexPath:indexPath];
    [cell setCellData:[controller dataAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self setSelectIndex:indexPath.item];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [controller sizeAtIndex:indexPath.item];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_selectScrollView setContentOffset:scrollView.contentOffset];
}

@end

