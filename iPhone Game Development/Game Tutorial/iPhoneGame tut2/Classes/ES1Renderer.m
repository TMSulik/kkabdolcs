//
//  ES1Renderer.m
//  iPhoneGame
//
//  Created by Seonghyeon Choe on 1/21/10.
//  Copyright kkabdol 2010. All rights reserved.
//

#import "ES1Renderer.h"

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
		
		// OpenGL Init Code
		
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

		// Init images
		playerShip = [[Image alloc] initWithImage:[UIImage imageNamed:@"player.png"] 
										   filter:GL_LINEAR];
		[playerShip setRotation:45];
		[playerShip setScale:2.0f];
		[playerShip setColourFilterRed:1.0f green:0.0f blue:0.0f alpha:0.3f];
		
		anotherShip = [playerShip getSubImageAtPoint:CGPointMake(0, 0)
									   subImageWidth:[playerShip imageWidth] 
									  subImageHeight:[playerShip imageHeight] 
											   scale:2.0f];
		[anotherShip setColourFilterRed:1.0f green:1.0f blue:1.0f alpha:0.7f];

	}
	
	return self;
}

- (void) render
{
    
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
	[playerShip renderAtPoint:CGPointMake(rect.size.width/2.0, rect.size.height/2.0) centerOfImage:YES];
	[anotherShip renderAtPoint:CGPointMake(rect.size.width/2.0, rect.size.height/2.0) centerOfImage:YES];

	// This application only creates a single color renderbuffer which is already bound at this point.
	// This call is redundant, but needed if dealing with multiple renderbuffers.
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
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
	
	// Images
	[playerShip release];
	
	[super dealloc];
}

@end
