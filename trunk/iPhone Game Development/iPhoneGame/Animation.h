//
//  Animation.h
//  iPhoneGame
//
//  Created by Seonghyeon Choe on 2/1/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Animation : NSObject {
	// Frames to be used within this animation
	NSMutableArray *frames;
	// Accumulates the time while a frame is displayed
	float frameTimer;
	// Holds the animation running state
	BOOL running;
	// Repeat the animation
	BOOL repeat;
	// Should the animation ping pong backwards and forwards
	BOOL pingPong;
	// Direction in which the animation is running
	int direction;
	// The current frame of animation
	int currentFrame;
}

@property(nonatomic)BOOL repeat;
@property(nonatomic)BOOL pingPong;
@property(nonatomic)BOOL running;
@property(nonatomic)int currentFrame;
@property(nonatomic)int direction;

- (void)addFrameWithImage:(Image*)image delay:(float)delay;
- (void)update:(float)delta;
- (void)renderAtPoint:(CGPoint)point;
- (Image*)getCurrentFrameImage;
- (GLuint)getAnimationFrameCount;
- (GLuint)getCurrentFrameNumber;
- (Frame*)getFrame:(GLuint)frameNumber;

@end
