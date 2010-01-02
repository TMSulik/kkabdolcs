//
//  Foo.m
//  Random
//
//  Created by Seonghyeon Choe on 12/31/09.
//  Copyright 2009 kkabdol. All rights reserved.
//

#import "Foo.h"


@implementation Foo

- (IBAction)seed:(id)sender
{
	// Generate a number between 1 and 100 inclusive
	int generated;
	generated = (random() % 100) + 1;
	
	NSLog(@"generated = %d", generated);
	
	// Ask the text field to change what it is displaying
	[textField setIntValue:generated];
}

- (IBAction)generate:(id)sender
{
	// Seed the random number generator with the time
	srandom(time(NULL));
	[textField setStringValue:@"Generator seeded"];
}

- (void)awakeFromNib
{
	NSCalendarDate *now;
	now = [NSCalendarDate calendarDate];
	[textField setObjectValue:now];
}

@end
