//
//  EAGLView.m
//  Tutorial1
//
//  Created by Michael Daley on 25/02/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//



#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>
#import <mach/mach.h>
#import <mach/mach_time.h>
#import "EAGLView.h"

#define USE_DEPTH_BUFFER 0

// A class extension to declare private methods
@interface EAGLView ()

@property (nonatomic, retain) EAGLContext *context;

- (BOOL) createFramebuffer;
- (void) destroyFramebuffer;
- (void) updateScene:(float)delta;
- (void) renderScene;
- (void) initGame;
- (void) initOpenGL;

@end


@implementation EAGLView

@synthesize context;

// You must implement this method
+ (Class)layerClass {
    return [CAEAGLLayer class];
}


//The GL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:
- (id)initWithCoder:(NSCoder*)coder {
    
    if ((self = [super initWithCoder:coder])) {
        // Get the layer
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = YES;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
        
        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        
        if (!context || ![EAGLContext setCurrentContext:context]) {
            [self release];
            return nil;
        }
		
		// Get the bounds of the main screen
		screenBounds = [[UIScreen mainScreen] bounds];
		
		// Go and initialise the game entities and graphics etc
		[self initGame];
    }
    return self;
}


- (void)initGame {
	
	// Game stat
	sharedGameState = [SingletonGameState sharedGameStateInstance];
	
	glInitialised = NO;
	
	// init images
	playerShip = [[Image alloc] initWithImage:[UIImage imageNamed:@"player.png"] filter:GL_LINEAR];
	[playerShip setRotation:45];
	[playerShip setScale:1.0f];
	[playerShip setFlipVertically:YES];
	
	// 07/02/10: Added retain as it was needed once the memory leak in Image.m was fixed
	playerShip1 = [[playerShip getSubImageAtPoint:CGPointMake(0, 0) subImageWidth:48 subImageHeight:71 scale:1.0f] retain];
	[playerShip1 setRotation:123];
	[playerShip1 setFlipHorizontally:YES];
	
	ss = [[SpriteSheet alloc] initWithImageNamed:@"spritesheet16.gif" spriteWidth:16 spriteHeight:16 spacing:0 imageScale:2.0f];
	sprite = [ss getSpriteAtX:4 y:2];
	
	font1 = [[AngelCodeFont alloc] initWithFontImageNamed:@"kerning.png" controlFile:@"kerning" scale:1.0f filter:GL_NEAREST];
	//[font1 setColourFilterRed:1.0f green:0.0f blue:0.0f alpha:1.0f];
	message = @"This is a longer message to see if this is going to work....";
	messageX = 320;
	messageWidth = [font1 getWidthForString:message];
	
	anim = [[Animation alloc] init];
	for(int index=0; index<6; index++) {
		[anim addFrameWithImage:[ss getSpriteAtX:index y:2] delay:0.08];
	}
	[anim setRunning:YES];
	[anim setRepeat:YES];
	
	// Init tilemap
	tileMap = [[TiledMap alloc] initWithTiledFile:@"testmap" fileExtension:@"tmx"];
	tileMapX = -8;
	mapPoint.x = 0;
	mapPoint.y = 430;
	
	NSLog(@"Map Property value = '%@'", [tileMap getMapPropertyForKey:@"MyMapProp" defaultValue:@"default"]);
	
	// Init particle emitter
	pe = [[ParticleEmitter alloc] initParticleEmitterWithImageNamed:@"texture.png"
														   position:Vector2fMake(160, 240)
 	 										 sourcePositionVariance:Vector2fMake(5, 5)
															  speed:8.5f
													  speedVariance:0.5f
												   particleLifeSpan:1.5f	
										   particleLifespanVariance:0.5f
															  angle:90.0f
													  angleVariance:15
															gravity:Vector2fMake(0.0f, -0.2f)
														 startColor:Color4fMake(0.0f, 0.0f, 0.0f, 1.0f)
												 startColorVariance:Color4fMake(1.0f, 1.0f, 1.0f, 0.5f)
														finishColor:Color4fMake(0.0f, 0.0f, 0.0f, 0.0f)  
												finishColorVariance:Color4fMake(1.0f, 1.0f, 1.0f, 0.0f)
													   maxParticles:500
													   particleSize:25
											   particleSizeVariance:25
														   duration:-1
													  blendAdditive:YES];
	

//	pe = [[ParticleEmitter alloc] initParticleEmitterWithImageNamed:@"texture.png"
//														   position:Vector2fMake(160, 240)
// 	 										 sourcePositionVariance:Vector2fMake(5, 5)
//															  speed:2.5
//													  speedVariance:0.5f
//												   particleLifeSpan:0.5f	
//										   particleLifespanVariance:0.5f
//															  angle:90
//													  angleVariance:10
//															gravity:Vector2fMake(0.0f, 0.0f)
//														 startColor:Color4fMake(1.0f, 0.5f, 0.5, 1.0f)
//												 startColorVariance:Color4fMake(0.0f, 0.0f, 0.0f, 0.5f)
//														finishColor:Color4fMake(0.0f, 0.0f, 1.0f, 0.0f)  
//												finishColorVariance:Color4fMake(0.0f, 0.0f, 0.0f, 0.0f)
//													   maxParticles:150
//													   particleSize:64
//											   particleSizeVariance:0
//														   duration:-1
//													  blendAdditive:NO];
	
	// Set the initial value for lastTime
	lastTime = CACurrentMediaTime();
	
	// Init sound
	sharedSoundManager = [SingletonSoundManager sharedSoundManager];
	[sharedSoundManager loadSoundWithKey:@"photon" fileName:@"photon" fileExt:@"caf" frequency:22050];
	[sharedSoundManager loadSoundWithKey:@"laser" fileName:@"laser" fileExt:@"caf" frequency:22050];
	[sharedSoundManager loadBackgroundMusicWithKey:@"music" fileName:@"music" fileExt:@"mp3"];
	[sharedSoundManager playMusicWithKey:@"music" timesToRepeat:-1];
}

- (void)mainGameLoop {
	
	// Create variables to hold the current time and calculated delta
	CFTimeInterval		time;
	float				delta;
	
	// This is the heart of the game loop and will keep on looping until it is told otherwise
//	while(true) {
		
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
		time = CACurrentMediaTime();
		delta = (time - lastTime);
		
		// Go and update the game logic and then render the scene
		[self updateScene:delta];
		[self renderScene];
		
		// Set the lasttime to the current time ready for the next pass
		lastTime = time;
		
		// Release the autorelease pool so that it is drained
		[pool release];
//	}	
}


- (void)updateScene:(float)delta {
	// Update Game Logic
	messageX -= 120 * delta;
	if(messageX < -messageWidth)
		messageX = 320;
	
	mapPoint.x -= 60 * delta;
	if(mapPoint.x < (int)-[tileMap tileWidth]) {
		mapPoint.x += (int)[tileMap tileWidth];
		tileMapX += 1;
	}
	if(tileMapX > (int)[tileMap mapWidth]) {
		tileMapX = -8;
	}
	
	[anim update:delta];
	[pe update:delta];
}


- (void)renderScene {
    
	// If OpenGL has not yet been initialised then go and initialise it
	if(!glInitialised) {
		[self initOpenGL];
	}
    
	// Set the current EAGLContext and bind to the framebuffer.  This will direct all OGL commands to the
	// framebuffer and the associated renderbuffer attachment which is where our scene will be rendered
	[EAGLContext setCurrentContext:context];
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    
	// Define the viewport.  Changing the settings for the viewport can allow you to scale the viewport
	// as well as the dimensions etc and so I'm setting it for each frame in case we want to change it
	glViewport(0, 0, screenBounds.size.width , screenBounds.size.height);
	
	// Clear the screen.  If we are going to draw a background image then this clear is not necessary
	// as drawing the background image will destroy the previous image
	glClear(GL_COLOR_BUFFER_BIT);
	
	// Setup how the images are to be blended when rendered.  This could be changed at different points during your
	// render process if you wanted to apply different effects
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	
	//Render the game Scene	
	//[playerShip1 renderAtPoint:CGPointMake(140, 240) centerOfImage:YES];
	
//	[tileMap renderAtPoint:mapPoint mapX:tileMapX mapY:0 width:8 height:10 layer:0];
//	[tileMap renderAtPoint:mapPoint mapX:tileMapX mapY:0 width:8 height:10 layer:1];
//	
//	[playerShip renderAtPoint:CGPointMake(140, 240) centerOfImage:YES];
//	[sprite renderAtPoint:CGPointMake(160, 50) centerOfImage:YES];
//	[font1 drawStringAt:CGPointMake(messageX, 450) text:message];
//	[anim renderAtPoint:CGPointMake(160, 200)];
	[pe renderParticles];
	
	// Bind to the renderbuffer and then present this image to the current context
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}


- (void)initOpenGL {
	// Switch to GL_PROJECTION matrix mode and reset the current matrix with the identity matrix
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	
	// Setup Ortho for the current matrix mode.  This describes a transformation that is applied to
	// the projection.  For our needs we are defining the fact that 1 pixel on the screen is equal to
	// one OGL unit by defining the horizontal and vertical clipping planes to be from 0 to the views
	// dimensions.  The far clipping plane is set to -1 and the near to 1
	glOrthof(0, screenBounds.size.width, 0, screenBounds.size.height, -1, 1);
	
	// Switch to GL_MODELVIEW so we can now draw our objects
	glMatrixMode(GL_MODELVIEW);
	
	// Setup how textures should be rendered i.e. how a texture with alpha should be rendered ontop of
	// another texture.  We are setting this to GL_BLEND_SRC by default and not changing it during the
	// game
	glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_BLEND_SRC);
	
	// We are going to be using GL_VERTEX_ARRAY to do all drawing within our game so it can be enabled once
	// If this was not the case then this would be set for each frame as necessary
	glEnableClientState(GL_VERTEX_ARRAY);
	
	// We are not using the depth buffer in our 2D game so depth testing can be disabled.  If depth
	// testing was required then a depth buffer would need to be created as well as enabling the depth
	// test
	glDisable(GL_DEPTH_TEST);
	
	// Set the colour to use when clearing the screen with glClear
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	
	// Mark OGL as initialised
	glInitialised = YES;
}

- (void)layoutSubviews {
    [EAGLContext setCurrentContext:context];
    [self destroyFramebuffer];
    [self createFramebuffer];
    [self renderScene];
}


- (BOOL)createFramebuffer {
    
    glGenFramebuffersOES(1, &viewFramebuffer);
    glGenRenderbuffersOES(1, &viewRenderbuffer);
    
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer*)self.layer];
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderbuffer);
    
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
    
    if (USE_DEPTH_BUFFER) {
        glGenRenderbuffersOES(1, &depthRenderbuffer);
        glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
        glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);
    }
    
    if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) {
        NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
    
    return YES;
}


- (void)startAnimation {
     gameLoopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60 target:self selector:@selector(mainGameLoop) userInfo:nil repeats:YES];
}


- (void)destroyFramebuffer {
    
    glDeleteFramebuffersOES(1, &viewFramebuffer);
    viewFramebuffer = 0;
    glDeleteRenderbuffersOES(1, &viewRenderbuffer);
    viewRenderbuffer = 0;
    
    if(depthRenderbuffer) {
        glDeleteRenderbuffersOES(1, &depthRenderbuffer);
        depthRenderbuffer = 0;
    }
}


- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	[pe setActive:YES];
	[pe setDuration:0.125f];
	//[sharedSoundManager playSoundWithKey:@"laser" gain:0.25f pitch:1.0f location:Vector2fZero shouldLoop:NO];
	[sharedSoundManager playSoundWithKey:@"photon" gain:1.0f pitch:1.0f location:Vector2fZero shouldLoop:NO];
}

- (void)dealloc {

	// 07/02/10: Added release as they were missing
	[playerShip release];
	[playerShip1 release];
	[ss release];
	[font1 release];
	[anim release];
	[tileMap release];
	[pe release];
	
    if ([EAGLContext currentContext] == context) {
        [EAGLContext setCurrentContext:nil];
    }
    
    [context release];  
    [super dealloc];
}

@end
