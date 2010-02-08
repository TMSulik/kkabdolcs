//
//  SingletonGameState.h
//  iPhoneGame
//
//  Created by Seonghyeon Choe on 2/3/10.
//  Copyright 2010 kkabdol. All rights reserved.
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
