//
//  ViewController.m
//  Demo
//
//  Created by Krzysztof Czarnota on 20.05.2017.
//  Copyright © 2017 czarny. All rights reserved.
//

#import "ViewController.h"

@import KCTextTabs;



@interface ViewController () <KCTextTabsViewDelegate>

@property(weak) IBOutlet KCTextTabsView *tabs;
@property(weak) IBOutlet UILabel *textLabel;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabs.delegate = self;
    [self.tabs addButton:@"Test1"];
    [self.tabs addButton:@"Test2"];
    [self.tabs addButton:@"Test3"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textTabsView:(KCTextTabsView *)view didSelectTabAtIndex:(NSInteger)index {
    self.textLabel.text = [NSString stringWithFormat:@"%zd", index];
}

@end
