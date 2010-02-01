//
//  PreferenceController.m
//  RaiseMan
//
//  Created by Seonghyeon Choe on 1/12/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import "PreferenceController.h"

NSString * const KkabTableBgColorKey = @"TableBackgroundColor";
NSString * const KkabEmptyDocKey = @"EmptyDocumnetFlag";
NSString * const KkabColorChangedNotification = @"KkabColorChanged";

@implementation PreferenceController

- (id)init
{
	if (![super initWithWindowNibName:@"Preferences"])
		return nil;
	return self;
}

- (NSColor *)tableBgColor
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSData *colorAsData = [defaults objectForKey:KkabTableBgColorKey];
	return [NSKeyedUnarchiver unarchiveObjectWithData:colorAsData];
}

- (BOOL)emptyDoc
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey:KkabEmptyDocKey];
}

- (void)windowDidLoad
{
	[colorWell setColor:[self tableBgColor]];
	[checkbox setState:[self emptyDoc]];
}

- (IBAction)changeBackgroundColor:(id)sender
{
	NSColor *color = [colorWell color];
	NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:color];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:colorAsData forKey:KkabTableBgColorKey];
	
	// Posting
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	NSLog(@"Sending notification");
	//[nc postNotificationName:KkabColorChangedNotification object:self];
	NSDictionary *d  = [NSDictionary dictionaryWithObject:color forKey:@"color"];
	[nc postNotificationName:KkabColorChangedNotification 
					  object:self
					userInfo:d];
}

- (IBAction)changeNewEmptyDoc:(id)sender
{
	int state = [checkbox state];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:state forKey:KkabEmptyDocKey];
	//NSLog(@"%@", [defaults boolForKey:KkabEmptyDocKey]);
}

+ (void)initialize
{
	NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
	
	NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:[NSColor yellowColor]];
	
	[defaultValues setObject:colorAsData forKey:KkabTableBgColorKey];
	[defaultValues setObject:[NSNumber numberWithBool:YES]
					  forKey:KkabEmptyDocKey];
	
	[[NSUserDefaults standardUserDefaults]
	 registerDefaults:defaultValues];
	NSLog(@"registerd defaults: %@", defaultValues);
}

- (IBAction)resetPreference:(id)sender
{
	NSColor *color = [NSColor yellowColor];
	NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:color];
	BOOL state = YES;
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:colorAsData forKey:KkabTableBgColorKey];
	[defaults setBool:state forKey:KkabEmptyDocKey];
	
	[colorWell setColor:color];
	[checkbox setState:state];
}

@end
