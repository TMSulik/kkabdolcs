//
//  SingletonGameState.m
//  iPhoneGame
//
//  Created by Seonghyeon Choe on 2/3/10.
//  Copyright 2010 kkabdol. All rights reserved.
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
