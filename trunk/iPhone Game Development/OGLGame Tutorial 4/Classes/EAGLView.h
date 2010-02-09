//
//  EAGLView.h
//  Tutorial1
//
//  Created by Michael Daley on 25/02/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "Texture2D.h"
#import "Image.h"
#import "SpriteSheet.h"
#import "AngelCodeFont.h"

/*
 This class wraps the CAEAGLLayer from CoreAnimation into a convenient UIView subclass.
 The view content is basically an EAGL surface you render your OpenGL scene into.
 Note that setting the view non-opaque will only work if the EAGL surface has an alpha channel.
 */
@interface EAGLView : UIView {
    
@private
    /* The pixel dimensions of the backbuffer */
    GLint backingWidth;
    GLint backingHeight;
    
    EAGLContext *context;
    
    /* OpenGL names for the renderbuffer and framebuffers used to render to this view */
    GLuint viewRenderbuffer, viewFramebuffer;
    
    /* OpenGL name for the depth buffer that is attached to viewFramebuffer, if it exists (0 if it does not exist) */
    GLuint depthRenderbuffer;
	
	/* Time since the last frame was rendered */
	CFTimeInterval lastTime;
	
	/* State to define if OGL has been initialised or not */
	BOOL glInitialised;
	
	/* Bounds of the current screen */
	CGRect screenBounds;
	
	// Game specific items
	Image *playerShip;
	Image *playerShip1;
	
	SpriteSheet *ss;
	Image *sprite;
	AngelCodeFont *font1;
	int messageWidth;
	float messageX;
	NSString *message;
	
}

- (void)renderScene;
- (void)mainGameLoop;

@end
