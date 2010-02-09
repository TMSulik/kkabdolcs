//
//  MenuState.m
//  OGLGame
//
//  Created by Michael Daley on 31/05/2009.
//  Copyright 2009 Michael Daley. All rights reserved.
//

#import "MenuScene.h"

@interface MenuScene (Private)
- (void)initMenuItems;
@end

@implementation MenuScene


- (id)init {
	
	if(self = [super init]) {
		_sharedDirector = [Director sharedDirector];
		_sharedResourceManager = [ResourceManager sharedResourceManager];
		_sharedSoundManager = [SoundManager sharedSoundManager];
        
        _sceneFadeSpeed = 1.0f;
        sceneAlpha = 0.0f;
        _origin = CGPointMake(0, 0);
        [_sharedDirector setGlobalAlpha:sceneAlpha];
			
		menuEntities = [[NSMutableArray alloc] init];
		menuBackground = [[Image alloc] initWithImage:@"background.png"];
		[self setSceneState:kSceneState_TransitionIn];
		nextSceneKey = nil;
		[self initMenuItems];
	}
	return self;
}


- (void)initMenuItems {
	MenuControl *menuEntity = [[MenuControl alloc] initWithImageNamed:@"newgame.png" location:Vector2fMake(160, 350) centerOfImage:YES type:kControlType_NewGame];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"settings.png" location:Vector2fMake(160, 300) centerOfImage:YES type:kControlType_Settings];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"highscores.png" location:Vector2fMake(160, 250) centerOfImage:YES type:kControlType_HighScores];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
	
	menuEntity = [[MenuControl alloc] initWithImageNamed:@"quitgame.png" location:Vector2fMake(160, 200) centerOfImage:YES type:kControlType_QuitGame];
	[menuEntities addObject:menuEntity];
	[menuEntity release];
}

- (void)updateWithDelta:(GLfloat)aDelta {
	
	switch (sceneState) {
		case kSceneState_Running:
			[menuEntities makeObjectsPerformSelector:@selector(updateWithDelta:) withObject:[NSNumber numberWithFloat:aDelta]];
			
			for (MenuControl *control in menuEntities) {
				if([control state] == kControl_Selected) {
					[control setState:kControl_Idle];
					sceneState = kSceneState_TransitionOut;
					switch ([control type]) {
						case kControlType_NewGame:
							nextSceneKey = @"game";
							break;
                        case kControlType_Settings:
                            nextSceneKey = @"settings";
                            break;
						default:
							break;
					}
				}
			}
			break;
			
		case kSceneState_TransitionOut:
			sceneAlpha -= _sceneFadeSpeed * aDelta;
            [_sharedDirector setGlobalAlpha:sceneAlpha];
			if(sceneAlpha < 0)
                // If the scene being transitioned to does not exist then transition
                // this scene back in
				if(![_sharedDirector setCurrentSceneToSceneWithKey:nextSceneKey])
                    sceneState = kSceneState_TransitionIn;
			break;
			
		case kSceneState_TransitionIn:

			// I'm not using the delta value here as the large map being loaded causes
            // the first delta to be passed in to be very big which takes the alpha
            // to over 1.0 immediately, so I've got a fixed delta for the fade in.
            sceneAlpha += _sceneFadeSpeed * 0.02f;
            [_sharedDirector setGlobalAlpha:sceneAlpha];
			if(sceneAlpha >= 1.0f) {
				sceneState = kSceneState_Running;
			}
			break;
		default:
			break;
	}

}


- (void)setSceneState:(uint)theState {
	sceneState = theState;
	if(sceneState == kSceneState_TransitionOut)
		sceneAlpha = 1.0f;
	if(sceneState == kSceneState_TransitionIn)
		sceneAlpha = 0.0f;
}

- (void)updateWithTouchLocationBegan:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView {
    UITouch *touch = [[event touchesForView:aView] anyObject];
	CGPoint location;
	location = [touch locationInView:aView];
    
	// Flip the y location ready to check it against OpenGL coordinates
	location.y = 480-location.y;
	[menuEntities makeObjectsPerformSelector:@selector(updateWithLocation:) withObject:NSStringFromCGPoint(location)];
}


- (void)updateWithMovedLocation:(NSSet*)touches withEvent:(UIEvent*)event view:(UIView*)aView {
    UITouch *touch = [[event touchesForView:aView] anyObject];
	CGPoint location;
	location = [touch locationInView:aView];
    
	// Flip the y location ready to check it against OpenGL coordinates
	location.y = 480-location.y;
	[menuEntities makeObjectsPerformSelector:@selector(updateWithLocation:) withObject:NSStringFromCGPoint(location)];	
}


- (void)transitionToSceneWithKey:(NSString*)theKey {
	sceneState = kSceneState_TransitionOut;
	sceneAlpha = 1.0f;
}


- (void)render {
	[menuBackground renderAtPoint:CGPointMake(160, 240) centerOfImage:YES];
	[menuEntities makeObjectsPerformSelector:@selector(render)];
}


@end
