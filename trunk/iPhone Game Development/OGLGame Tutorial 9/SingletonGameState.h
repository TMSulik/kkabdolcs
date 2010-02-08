//
//  SingletonGameState.h
//  OGLGame
//
//  Created by Michael Daley on 15/05/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>


@interface SingletonGameState : NSObject {

	//Currently bound texture
	GLuint currentlyBoundTexture;
}

@property (nonatomic, assign) GLuint currentlyBoundTexture;

+ (SingletonGameState*)sharedGameStateInstance;

@end
