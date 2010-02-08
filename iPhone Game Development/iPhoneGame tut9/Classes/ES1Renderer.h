//
//  ES1Renderer.h
//  iPhoneGame
//
//  Created by Seonghyeon Choe on 1/21/10.
//  Copyright kkabdol 2010. All rights reserved.
//
#import "ESRenderer.h"
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#import "SingletonGameState.h"
#import "Image.h"
#import "SpriteSheet.h"
#import "AngelCodeFont.h"
#import "Animation.h"
#import "TiledMap.h"
#import "ParticleEmitter.h"
#import "SingletonSoundManager.h"

@interface ES1Renderer : NSObject <ESRenderer>
{
@private
	EAGLContext *context;
	
	// The pixel dimensions of the CAEAGLLayer
	GLint backingWidth;
	GLint backingHeight;
	
	// The OpenGL names for the framebuffer and renderbuffer used to render to this view
	GLuint defaultFramebuffer, colorRenderbuffer;
	
	BOOL glInitialised;
	
	CFTimeInterval lastTime;
	
	// Game State
	SingletonGameState *sharedGameState;
	
	// Sound Manager
	SingletonSoundManager *sharedSoundManager;
	
	Image *playerShip;
	Image *anotherShip;
	
	SpriteSheet *ss;
	Image* sprite;
	AngelCodeFont *font1;
	int messageWidth;
	float messageX;
	NSString *message;
	
	Animation *anim;
	TiledMap *tileMap;
	CGPoint mapPoint;
	int tileMapX;
	
	ParticleEmitter *pe;
}

- (void) render;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;

- (void)mainGameLoop;
- (void)updateScene:(float)delta;
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event;
@end
