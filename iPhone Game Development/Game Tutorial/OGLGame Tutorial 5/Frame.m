//
//  Frame.m
//  OGLGame
//
//  Created by Michael Daley on 19/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
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
