//
//  KCTextTabsView.m
//  KCTextTabs
//
//  Created by Krzysztof Czarnota on 20.05.2017.
//  Copyright © 2017 czarny. All rights reserved.
//

#import "KCTextTabsView.h"



@interface KCTextTabsView () {
    UIView *_selectionBar;
    UIView *_topSeparator;
    UIView *_bottomSeparator;

    UIButton *_button1;
    UIButton *_button2;
    UIButton *_button3;
    UIButton *_button4;

    UIButton *_selectedButton;
}

@end



@implementation KCTextTabsView

- (void)setBorderColor:(UIColor *)borderColor {
    self->_borderColor = borderColor;
    self->_topSeparator.backgroundColor = borderColor;
    self->_bottomSeparator.backgroundColor = borderColor;
}


- (void)setTabTitle1:(NSString *)tabTitle1 {
    self->_tabTitle1 = tabTitle1;

    [self->_button1 removeFromSuperview];
    self->_button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self initButton:self->_button1 withCatpion:tabTitle1];
}


- (void)setTabTitle2:(NSString *)tabTitle2 {
    self->_tabTitle2 = tabTitle2;

    [self->_button2 removeFromSuperview];
    self->_button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self initButton:self->_button2 withCatpion:tabTitle2];
}


- (void)setTabTitle3:(NSString *)tabTitle3 {
    self->_tabTitle3 = tabTitle3;

    [self->_button3 removeFromSuperview];
    self->_button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self initButton:self->_button3 withCatpion:tabTitle3];
}



- (void)setTabTitle4:(NSString *)tabTitle4 {
    self->_tabTitle4 = tabTitle4;

    [self->_button4 removeFromSuperview];
    self->_button4 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self initButton:self->_button4 withCatpion:tabTitle4];
}



- (void)initButton:(UIButton *)button withCatpion:(NSString *)title {
    button.titleLabel.font = self.normalFont;
    button.titleLabel.textColor = self.textColor;
    button.tintColor = self.textColor;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self initialize];
    }

    return self;
}


- (void)initialize {
    self->_selectionBar = [UIView new];
    self->_selectionBar.backgroundColor = self.tintColor;
    [self addSubview:self->_selectionBar];

    self->_topSeparator = [UIView new];
    self->_topSeparator.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self->_topSeparator];

    self->_bottomSeparator = [UIView new];
    self->_bottomSeparator.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self->_bottomSeparator];

    NSDictionary *subviews = NSDictionaryOfVariableBindings(_topSeparator, _bottomSeparator);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_topSeparator]-0-|" options:0 metrics:nil views:subviews]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_topSeparator(1)]" options:0 metrics:nil views:subviews]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_bottomSeparator]-0-|" options:0 metrics:nil views:subviews]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomSeparator(1)]-0-|" options:0 metrics:nil views:subviews]];


    self.textColor = [UIColor whiteColor];
    self.borderColor = [UIColor lightGrayColor];
    self.normalFont = [UIFont systemFontOfSize:12];
    self.selectedFont = [UIFont boldSystemFontOfSize:12];

    self.tabTitle1 = @"Button1";
    self.tabTitle2 = @"Button2";
    self.tabTitle3 = @"Button3";
    self.tabTitle4 = @"Button4";
}


- (void)layoutSubviews {
    [super layoutSubviews];

    [self->_button1 sizeToFit];
    [self->_button2 sizeToFit];
    [self->_button3 sizeToFit];
    [self->_button4 sizeToFit];

    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat y = (self.frame.size.height - self->_button1.frame.size.height) / 2.0;
    CGFloat space = width;
    space -= CGRectGetWidth(self->_button1.frame) + 4;
    space -= CGRectGetWidth(self->_button2.frame) + 4;
    space -= CGRectGetWidth(self->_button3.frame) + 4;
    space -= CGRectGetWidth(self->_button4.frame) + 4;
    space /= 4.0;

    self->_button1.frame = CGRectMake(0.5 * space, y, CGRectGetWidth(self->_button1.frame) + 4, CGRectGetHeight(self->_button1.frame));
    self->_button2.frame = CGRectMake(CGRectGetMaxX(self->_button1.frame) + space, y, CGRectGetWidth(self->_button2.frame) + 4, CGRectGetHeight(self->_button2.frame));
    self->_button3.frame = CGRectMake(CGRectGetMaxX(self->_button2.frame) + space, y, CGRectGetWidth(self->_button3.frame) + 4, CGRectGetHeight(self->_button3.frame));
    self->_button4.frame = CGRectMake(CGRectGetMaxX(self->_button3.frame) + space, y, CGRectGetWidth(self->_button4.frame) + 4, CGRectGetHeight(self->_button4.frame));


    self->_selectionBar.frame = CGRectMake(self->_selectedButton.frame.origin.x, height - 3, self->_selectedButton.frame.size.width, 2);
}


- (void)onButtonTap:(UIButton *)sender {
    self->_selectedButton = sender;

    self->_button1.titleLabel.font = self.normalFont;
    self->_button2.titleLabel.font = self.normalFont;
    self->_button3.titleLabel.font = self.normalFont;
    self->_button4.titleLabel.font = self.normalFont;
    self->_selectedButton.titleLabel.font = self.selectedFont;

    [UIView animateWithDuration:0.2 animations:^{
        BOOL forward = CGRectGetMinX(self->_selectedButton.frame) > CGRectGetMinX(self->_selectionBar.frame);

        CGFloat y = CGRectGetMinY(self->_selectionBar.frame);
        CGFloat x = forward ? CGRectGetMinX(self->_selectionBar.frame) : CGRectGetMinX(self->_selectedButton.frame);
        CGFloat width = forward ? CGRectGetMaxX(self->_selectedButton.frame) - x : CGRectGetMaxX(self->_selectionBar.frame) - x;
        self->_selectionBar.frame = CGRectMake(x, y, width, 2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            CGFloat x = CGRectGetMinX(self->_selectedButton.frame);
            CGFloat y = CGRectGetMinY(self->_selectionBar.frame);
            CGFloat width = CGRectGetMaxX(self->_selectedButton.frame) - x;
            self->_selectionBar.frame = CGRectMake(x, y, width, 2);
        }];
    }];
}

@end
