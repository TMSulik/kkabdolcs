//
//  CountCharactersAppDelegate.m
//  CountCharacters
//
//  Created by Seonghyeon Choe on 1/6/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import "CountCharactersAppDelegate.h"

@implementation CountCharactersAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
}

- (IBAction)countCharacters:(id)sender
{
	NSString *string = [textField stringValue];
	
	if([string length] == 0) {
		[resultCount setStringValue:@"???"];
	}
	else {
		[resultCount setStringValue:
		 [NSString stringWithFormat:@"%@ has %d characters.",
		  string, [string length]]];
	}
	
}
@end
