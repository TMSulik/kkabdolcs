//
//  CellsAppDelegate.m
//  Cells
//
//  Created by Seonghyeon Choe on 3/11/10.
//  Copyright kkabdol 2010. All rights reserved.
//

#import "CellsAppDelegate.h"
#import "CellsViewController.h"

@implementation CellsAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
