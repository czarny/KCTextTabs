//
//  KCTextTabsView.m
//  KCTextTabs
//
//  Created by Krzysztof Czarnota on 20.05.2017.
//  Copyright © 2017 czarny. All rights reserved.
//

#import "KCTextTabsView.h"



@interface KCTextTabsView () {
    UIScrollView *_scrollView;
    UIView *_selectionBar;
    NSMutableArray *_buttons;
    UIButton *_selectedButton;
}

@end



@implementation KCTextTabsView


- (void)setSelectedIndex:(NSInteger)selectedIndex {
    NSInteger selected = [self->_buttons indexOfObject:self->_selectedButton];
    if(selected != selectedIndex) {
        self->_selectedIndex = selectedIndex;
        UIButton *b = self->_buttons[selectedIndex];
        [self onButtonTap:b];
    }
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self initialize];
    }

    return self;
}


- (void)initialize {
    self->_buttons = [NSMutableArray new];

    self->_scrollView = [UIScrollView new];
    self->_scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self->_scrollView];

    [self->_scrollView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self->_scrollView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [self->_scrollView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self->_scrollView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;

    self->_selectionBar = [UIView new];
    self->_selectionBar.backgroundColor = self.tintColor;
    self->_selectionBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self->_scrollView addSubview:self->_selectionBar];

    self.textColor = [UIColor whiteColor];
    self.normalFont = [UIFont systemFontOfSize:12];
    self.selectedFont = [UIFont boldSystemFontOfSize:12];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self->_buttons makeObjectsPerformSelector:@selector(sizeToFit)];

    CGFloat height = self.frame.size.height;
    CGFloat space = 12.0;
    CGFloat x = 0.5 * space;
    CGFloat y = (height - CGRectGetHeight([[self->_buttons firstObject] frame])) / 2.0;

    for(UIButton *b in self->_buttons) {
        b.frame = CGRectMake(x, y, CGRectGetWidth(b.frame) + 6, CGRectGetHeight(b.frame));
        x += CGRectGetWidth(b.frame) + space;
    }

    self->_scrollView.contentSize = CGSizeMake(x, height);
    self->_selectionBar.frame = CGRectMake(self->_selectedButton.frame.origin.x, height - 2, self->_selectedButton.frame.size.width, 2);
}


- (void)onButtonTap:(UIButton *)sender {
    [self selectButton:sender];

    if([self->_delegate respondsToSelector:@selector(textTabsView:didSelectTabAtIndex:)]) {
        NSInteger index = [self->_buttons indexOfObject:self->_selectedButton];
        [self->_delegate textTabsView:self didSelectTabAtIndex:index];
    }
}


- (void)selectButton:(UIButton *)button {
    self->_selectedButton = button;
    for(UIButton *b in self->_buttons) {
        b.titleLabel.font = self.normalFont;
    }
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


- (void)addButton:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.titleLabel.font = self.normalFont;
    button.titleLabel.textColor = self.textColor;
    button.tintColor = self.textColor;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self->_scrollView addSubview:button];
    [self->_buttons addObject:button];

    if(!self->_selectedButton) {
        self->_selectedButton = button;
    }
}

@end
