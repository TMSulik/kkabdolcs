//
//  Frame.m
//  iPhoneGame
//
//  Created by Seonghyeon Choe on 2/3/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import "Frame.h"


@implementation Frame

@synthesize frameDelay;
@synthesize frameImage;

- (id)initWithImage:(Image*)image delay:(float)delay {
	self = [super init];
	if(self != nil) {
		frameImage = image;
		frameDelay = delay;
	}
	return self;
}

- (void)dealloc {
	[super dealloc];
}

@end
