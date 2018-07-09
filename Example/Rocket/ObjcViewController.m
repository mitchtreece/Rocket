//
//  ObjcViewController.m
//  Rocket
//
//  Created by Mitch Treece on 8/16/17.
//  Copyright © 2017 Mitch Treece. All rights reserved.
//

#import "ObjcViewController.h"
@import Rocket;

@interface ObjcViewController ()
@end

@implementation ObjcViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Objective-C";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didTapDoneItem:)];
    self.navigationItem.rightBarButtonItem = doneItem;
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    [self.view addGestureRecognizer:recognizer];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    UIColor *color = [[UIColor alloc] initWithRed:0.9921568627 green:0.5294117647 blue:0.2078431373 alpha:1];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
}

- (void)didTapDoneItem:(UIBarButtonItem *)sender {
    
    if (self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)didTap:(UITapGestureRecognizer *)recognizer {
    RKTError(@"This is an Objective-C error");
}

@end
