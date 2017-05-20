//
//  KCTextTabsView.h
//  KCTextTabs
//
//  Created by Krzysztof Czarnota on 20.05.2017.
//  Copyright © 2017 czarny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KCTextTabsView;

@protocol KCTextTabsViewDelegate <NSObject>

- (void)textTabsView:(KCTextTabsView *)view didSelectTabAtIndex:(NSInteger)index;

@end



IB_DESIGNABLE

@interface KCTextTabsView : UIView

@property(nonatomic, assign) IBInspectable UIColor *textColor;
@property(nonatomic, strong) IBInspectable UIColor *borderColor;
@property(nonatomic, strong) IBInspectable UIFont *normalFont;
@property(nonatomic, strong) IBInspectable UIFont *selectedFont;

@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, weak) id<KCTextTabsViewDelegate> delegate;

- (void)addButton:(NSString *)title;

@end
