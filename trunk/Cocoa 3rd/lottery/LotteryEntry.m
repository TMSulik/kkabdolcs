//
//  LotteryEntry.m
//  lottery
//
//  Created by Seonghyeon Choe on 1/1/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import "LotteryEntry.h"


@implementation LotteryEntry
- (id)init
{
	return [self initWithEntryDate:[NSCalendarDate calendarDate]];
}

- (id)initWithEntryDate:(NSCalendarDate *)theDate
{
	if (![super init])
		return nil;
	
	NSAssert(theDate != nil, @"Argument must be non-nil");
	entryDate = [theDate retain];
	firstNumber = random() % 100 + 1;
	secondNumber = random() % 100 + 1;
	return self;
}

- (void)setEntryDate:(NSCalendarDate *)date
{
	[date retain];
	[entryDate release];
	entryDate = date;
}

- (NSCalendarDate *)entryDate
{
	return entryDate;
}

- (int)firstNumber
{
	return firstNumber;
}

- (int)secondNumber
{
	return secondNumber;
}

- (NSString *)description
{
	/*
	NSString *result;
	result = [[NSString alloc] initWithFormat:@"%@ = %3d and %3d",
			  [entryDate descriptionWithCalendarFormat:@"%b %d %Y"],
			  firstNumber, secondNumber];
	[result autorelease];
	return result;*/
	
	return [NSString stringWithFormat:@"%@ = %3d and %3d",
			[entryDate descriptionWithCalendarFormat:@"%b %d %Y"],
			firstNumber, secondNumber];
}

- (void)dealloc
{
	NSLog(@"deallocing %@", self);
	[entryDate release];
	[super dealloc];
}

@end
