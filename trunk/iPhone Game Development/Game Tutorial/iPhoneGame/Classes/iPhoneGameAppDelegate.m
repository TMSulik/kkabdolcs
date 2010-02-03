//
//  iPhoneGameAppDelegate.m
//  iPhoneGame
//
//  Created by Seonghyeon Choe on 1/21/10.
//  Copyright kkabdol 2010. All rights reserved.
//

#import "iPhoneGameAppDelegate.h"
#import "EAGLView.h"

@implementation iPhoneGameAppDelegate

@synthesize window;
@synthesize glView;

- (void) applicationDidFinishLaunching:(UIApplication *)application
{
	[[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];
	[glView startAnimation];
}

- (void) applicationWillResignActive:(UIApplication *)application
{
	[glView stopAnimation];
}

- (void) applicationDidBecomeActive:(UIApplication *)application
{
	[glView startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[glView stopAnimation];
}

- (void) dealloc
{
	[window release];
	[glView release];
	
	[super dealloc];
}

@end
