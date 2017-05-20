//
//  KCTextTabsView.h
//  KCTextTabs
//
//  Created by Krzysztof Czarnota on 20.05.2017.
//  Copyright © 2017 czarny. All rights reserved.
//

#import <UIKit/UIKit.h>



IB_DESIGNABLE

@interface KCTextTabsView : UIView

@property(nonatomic, assign) IBInspectable UIColor *textColor;
@property(nonatomic, strong) IBInspectable UIColor *borderColor;
@property(nonatomic, strong) IBInspectable UIFont *normalFont;
@property(nonatomic, strong) IBInspectable UIFont *selectedFont;

@property(nonatomic, strong) IBInspectable NSString *tabTitle1;
@property(nonatomic, strong) IBInspectable NSString *tabTitle2;
@property(nonatomic, strong) IBInspectable NSString *tabTitle3;
@property(nonatomic, strong) IBInspectable NSString *tabTitle4;

@end
