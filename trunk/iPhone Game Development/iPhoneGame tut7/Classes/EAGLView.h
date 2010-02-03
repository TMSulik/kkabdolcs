//
//  EAGLView.h
//  iPhoneGame
//
//  Created by Seonghyeon Choe on 1/21/10.
//  Copyright kkabdol 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "ESRenderer.h"

// This class wraps the CAEAGLLayer from CoreAnimation into a convenient UIView subclass.
// The view content is basically an EAGL surface you render your OpenGL scene into.
// Note that setting the view non-opaque will only work if the EAGL surface has an alpha channel.
@interface EAGLView : UIView
{    
@private
	id <ESRenderer> renderer;
	
	BOOL animating;	// will be removed
	BOOL displayLinkSupported;
	NSInteger animationFrameInterval;	// will be removed
	// Use of the CADisplayLink class is the preferred method for controlling your animation timing.
	// CADisplayLink will link to the main display and fire every vsync when added to a given run-loop.
	// The NSTimer class is used only as fallback when running on a pre 3.1 device where CADisplayLink
	// isn't available.
	id displayLink;
    NSTimer *animationTimer;	// will be removed
	
	CFTimeInterval lastTime;
}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;// will be removed
@property (nonatomic) NSInteger animationFrameInterval;// will be removed

- (void) startAnimation;
- (void) stopAnimation;

- (void) drawView:(id)sender;
@end
