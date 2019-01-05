//
//  TabButtonView.h
//  Mulban
//
//  Created by kim sunchul on 2018. 9. 25..
//  Copyright © 2018년 Baek. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
    탭 컨트롤러
    - 커스텀 탭뷰를 만들려면 해당 클래스를 상속 받아야함.
 */
@interface TabButtonView : UIView

@property (retain, nonatomic) IBOutlet UIButton *actionButton;

- (void)setTabSelected:(BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
