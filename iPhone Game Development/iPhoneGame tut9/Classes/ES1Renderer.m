//
//  ES1Renderer.m
//  iPhoneGame
//
//  Created by Seonghyeon Choe on 1/21/10.
//  Copyright kkabdol 2010. All rights reserved.
//

#import "ES1Renderer.h"

@interface ES1Renderer ()
- (void) initGame;
- (void) initOpenGL;
@end

@implementation ES1Renderer

// Create an ES 1.1 context
- (id) init
{
	if (self = [super init])
	{
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        
        if (!context || ![EAGLContext setCurrentContext:context])
		{
            [self release];
            return nil;
        }
		
		// Create default framebuffer object. The backing will be allocated for the current layer in -resizeFromLayer
		glGenFramebuffersOES(1, &defaultFramebuffer);
		glGenRenderbuffersOES(1, &colorRenderbuffer);
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, colorRenderbuffer);
		
		[self initGame];
	}
	
	return self;
}

- (void) initGame
{
	// Game stat
	sharedGameState = [SingletonGameState sharedGameStateInstance];
	
	playerShip = [[Image alloc] initWithImage:[UIImage imageNamed:@"player.png"] 
									   filter:GL_LINEAR];
	[playerShip setRotation:45];
	[playerShip setScale:2.0f];
	[playerShip setColourFilterRed:1.0f green:0.0f blue:0.0f alpha:0.3f];
	
	anotherShip = [playerShip getSubImageAtPoint:CGPointMake(0, 0)
								   subImageWidth:[playerShip imageWidth] 
								  subImageHeight:[playerShip imageHeight] 
										   scale:2.0f];
	[anotherShip setColourFilterRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
	
	ss = [[SpriteSheet alloc] initWithImageNamed:@"spritesheet16.gif" spriteWidth:16 spriteHeight:16 spacing:0 imageScale:1.0f];
	sprite = [ss getSpriteAtX:1 y:0];
	
	font1 = [[AngelCodeFont alloc] initWithFontImageNamed:@"kkabfont.png" controlFile:@"kkabfont" scale:1.0f filter:GL_NEAREST];
	message = @"Hello World!!!";
	messageX = 100;
	messageWidth = [font1 getWidthForString:message];
	
	anim = [[Animation alloc] init];
	for(int index=0; index<6; index++) {
		[anim addFrameWithImage:[ss getSpriteAtX:index y:2] delay:80];
	}
	[anim setRepeat:YES];
	[anim setRunning:YES];
	//[anim setPingPong:YES];
	
	// Init tilemap
	tileMap = [[TiledMap alloc] initWithTiledFile:@"hello" fileExtension:@"tmx"];
	tileMapX = -8;
	mapPoint.x = 0;
	mapPoint.y = 430;
	
	NSLog(@"Map Property value = '%@'", [tileMap getMapPropertyForKey:@"MyMapProp" defaultValue:@"default"]);
	
	// Init particle emitter
	pe = [[ParticleEmitter alloc] initParticleEmitterWithImageNamed:@"texture1.png"
														   position:Vector2fMake(160, 240)
 	 										 sourcePositionVariance:Vector2fMake(5, 5)
															  speed:1.0f
													  speedVariance:0.5f
												   particleLifeSpan:1.5f	
										   particleLifespanVariance:1.0f
															  angle:0.0f
													  angleVariance:360
															gravity:Vector2fMake(0.0f, -0.00f)
														 startColor:Color4fMake(1.0f, 0.5f, 0.0f, 1.0f)
												 startColorVariance:Color4fMake(0.0f, 0.0f, 0.0f, 0.5f)
														finishColor:Color4fMake(0.2f, 0.0f, 0.0f, 0.0f)    
												finishColorVariance:Color4fMake(1.0f, 1.0f, 1.0f, 0.0f)
													   maxParticles:300
													   particleSize:20
											   particleSizeVariance:30
														   duration:0.126
													  blendAdditive:NO];
	
	// Set the initial value for lastTime
	lastTime = CFAbsoluteTimeGetCurrent();
	
	// Init sound
	sharedSoundManager = [SingletonSoundManager sharedSoundManager];
	[sharedSoundManager loadSoundWithKey:@"photon" fileName:@"photon" fileExt:@"caf" frequency:22050];
	[sharedSoundManager loadBackgroundMusicWithKey:@"music" fileName:@"music" fileExt:@"mp3"];
	[sharedSoundManager playMusicWithKey:@"music" timesToRepeat:-1];
}

- (void) mainGameLoop {
	
	CFTimeInterval	time;
	float			delta;
	
	// Create an autorelease pool which can be used within this tight loop.  This is a memory
	// leak when using NSString stringWithFormat in the renderScene method.  Adding a specific
	// autorelease pool stops the memory leak
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	// I found this trick on iDevGames.com.  The command below pumps events which take place
	// such as screen touches etc so they are handled and then runs our code.  This means
	// that we are always in sync with VBL rather than an NSTimer and VBL being out of sync
	while(CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.002, TRUE) == kCFRunLoopRunHandledSource);
	
	// Get the current time and calculate the delta between the lasttime and now
	// We multiply the delta by 1000 to give us milliseconds		
	time = CFAbsoluteTimeGetCurrent();
	delta = (time - lastTime);
	
	// Go and update the game logic and then render the scene
	[self updateScene:delta];
	[self render];
	
	// Set the lasttime to the current time ready for the next pass
	lastTime = time;
	
	// Release the autorelease pool so that it is drained
	[pool release];
}
					 

- (void)updateScene:(float)delta
{
	// Update Game Logic
	messageX -= 120 * delta;
	if(messageX < -messageWidth)
		messageX = 100;
	
	mapPoint.x -= 60 * delta;
	if(mapPoint.x < (int)-[tileMap tileWidth]) {
		mapPoint.x = 0;
		tileMapX += 1;
	}
	if (tileMapX > (int)[tileMap mapWidth]) {
		tileMapX = -8;
	}
				
	[anim update:delta];
	[pe update:delta];
}

- (void) render
{
    if(!glInitialised) {
		[self initOpenGL];
	}
	
	// This application only creates a single context which is already set current at this point.
	// This call is redundant, but needed if dealing with multiple contexts.
    [EAGLContext setCurrentContext:context];
    
	// This application only creates a single default framebuffer which is already bound at this point.
	// This call is redundant, but needed if dealing with multiple framebuffers.
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
    glViewport(0, 0, backingWidth, backingHeight);
    
    // draw game scene
	glClear(GL_COLOR_BUFFER_BIT);
	
	// Get the bounds of the main screen
	CGRect rect = [[UIScreen mainScreen] bounds];
	
//	[tileMap renderAtPoint:mapPoint mapX:tileMapX mapY:0 width:8 height:6 layer:0];
//	[tileMap renderAtPoint:mapPoint mapX:tileMapX mapY:0 width:8 height:6 layer:1];
//
//	[anotherShip renderAtPoint:CGPointMake(rect.size.width/2.0, rect.size.height/2.0) centerOfImage:YES];
//	[playerShip renderAtPoint:CGPointMake(rect.size.width/2.0, rect.size.height/2.0) centerOfImage:YES];
//	[sprite renderAtPoint:CGPointMake(50, 50) centerOfImage:YES];
//	[font1 drawStringAt:CGPointMake(messageX, 450) text:message];
//	[anim renderAtPoint:CGPointMake(160, 200)];
	[pe renderParticles];
	
	// This application only creates a single color renderbuffer which is already bound at this point.
	// This call is redundant, but needed if dealing with multiple renderbuffers.
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

- (void) initOpenGL
{
	
	// Get the bounds of the main screen
	CGRect rect = [[UIScreen mainScreen] bounds];
	
	// Set up OpenGL projection matrix
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrthof(0, rect.size.width, 0, rect.size.height, -1, 1);
	glMatrixMode(GL_MODELVIEW);
	glViewport(0, 0, rect.size.width, rect.size.height);
	
	// Initialize OpenGL states
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glDisable(GL_DEPTH_TEST);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_BLEND_SRC);
	glEnableClientState(GL_VERTEX_ARRAY);
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	
	// Set glInitialised
	glInitialised = YES;
}


- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer
{	
	// Allocate color buffer backing based on the current layer size
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:layer];
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
    if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
	{
		NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
    
    return YES;
}

- (void) dealloc
{
	// Tear down GL
	if (defaultFramebuffer)
	{
		glDeleteFramebuffersOES(1, &defaultFramebuffer);
		defaultFramebuffer = 0;
	}

	if (colorRenderbuffer)
	{
		glDeleteRenderbuffersOES(1, &colorRenderbuffer);
		colorRenderbuffer = 0;
	}
	
	// Tear down context
	if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	
	[context release];
	context = nil;
	
	// release
	[playerShip release];
	[anotherShip release];
	[ss release];
	
	[super dealloc];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	if([pe active] == YES)
		[pe setActive:NO];
	else {
		[pe setActive:YES];
	}
	[sharedSoundManager playSoundWithKey:@"photon" gain:1.0f pitch:1.0f location:Vector2fZero shouldLoop:NO];
}
@end
