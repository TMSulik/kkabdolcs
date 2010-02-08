//
//  SingletonGameState.m
//  OGLGame
//
//  Created by Michael Daley on 15/05/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SingletonGameState.h"


@implementation SingletonGameState

@synthesize currentlyBoundTexture;

+ (SingletonGameState*)sharedGameStateInstance {
	
	static SingletonGameState *sharedGameStateInstance;
	
	@synchronized(self) {
		if(!sharedGameStateInstance) {
			sharedGameStateInstance = [[SingletonGameState alloc] init];
		}
	}
	
	return sharedGameStateInstance;
}

- (void) dealloc {
	[super dealloc];
}

@end
