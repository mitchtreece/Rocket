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
    self.view.backgroundColor = [UIColor whiteColor];
    
    // RKTLog(@"Hello, ObjC!");
    // [Rocket logWithRocket:[Rocket shared] message:@"Hello" prefix:nil level:kRocketLogLevelDebug file:@"" function:@"" line:0];
    
}

@end
