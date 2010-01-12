//
//  CarArrayController.m
//  CarLot
//
//  Created by Seonghyeon Choe on 1/12/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import "CarArrayController.h"


@implementation CarArrayController

- (id)newObject
{
	id newObj = [super newObject];
	NSDate *now = [NSDate date];
	[newObj setValue:now forKey:@"datePurchased"];
	NSData *car = [NSData dataWithContentsOfFile:@"/Users/kkabdol/Desktop/Study/CarLot/car.jpg"];
	[newObj setValue:car forKey:@"photo"];
	return newObj;
}

@end
