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

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Objective-C";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didTapDoneItem:)];
    self.navigationItem.rightBarButtonItem = doneItem;
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    [self.view addGestureRecognizer:recognizer];
    
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
    RKTLog(@"Hello, Objective-C!");
}

@end
