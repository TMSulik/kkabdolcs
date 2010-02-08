//
//  OGLGameAppDelegate.m
//  OGLGame
//
//  Created by Michael Daley on 14/03/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "OGLGameAppDelegate.h"
#import "EAGLView.h"

@implementation OGLGameAppDelegate

@synthesize window;
@synthesize glView;
@synthesize currentTexture;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];
	[glView performSelectorOnMainThread:@selector(startAnimation) withObject:nil waitUntilDone:NO];
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)dealloc {
	[window release];
	[glView release];
	[super dealloc];
}

@end
