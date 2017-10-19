//
//  ObjcViewController.m
//  Rocket_Example
//
//  Created by Mitch Treece on 8/16/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

#import "ObjcViewController.h"
@import Rocket;

@interface ObjcViewController ()
@end

@implementation ObjcViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    RKTLog(@"Hello, ObjC!");
    
//    [Rocket log:[Rocket shared]
//        message:@"ObjC"
//         prefix:nil
//          level:kRocketLogLevelDebug
//           file:[NSString stringWithFormat:@"%s", __FILE__]
//       function:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]
//           line:__LINE__];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
