//
//  WindowSizeAppDelegate.m
//  WindowSize
//
//  Created by Seonghyeon Choe on 1/6/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import "WindowSizeAppDelegate.h"

@implementation WindowSizeAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
}

- (NSSize)windowWillResize:(NSWindow *)sender
					toSize:(NSSize)frameSize;
{
	NSSize mySize;
	mySize.height = frameSize.height;
	mySize.width = frameSize.height*2;
	return mySize;
}
@end
