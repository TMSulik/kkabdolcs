//
//  AppController.m
//  RaiseMan
//
//  Created by Seonghyeon Choe on 1/12/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import "AppController.h"
#import "PreferenceController.h"
#import "AboutPanel.h"

@implementation AppController

- (IBAction)showPreferencePanel:(id)sender
{
	if (!preferenceController) {
		preferenceController = [[PreferenceController alloc] init];
	}
	NSLog(@"showing %@", preferenceController);
	[preferenceController showWindow:self];
}

- (IBAction)showAboutPanel:(id)sender
{
	if (!aboutPanel) {
		aboutPanel = [[AboutPanel alloc] init];
	}
	
	NSLog(@"showing %@", aboutPanel);
	[aboutPanel showWindow:self];
}

- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
	NSLog(@"applicationShouldOpenUntitledFile:");
	NSLog(@"%d", [[NSUserDefaults standardUserDefaults]
				  boolForKey:KkabEmptyDocKey]);
	return [[NSUserDefaults standardUserDefaults]
			boolForKey:KkabEmptyDocKey];
}

@end
