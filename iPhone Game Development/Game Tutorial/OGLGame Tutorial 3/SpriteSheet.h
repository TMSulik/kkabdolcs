//
//  SpriteSheet.h
//  Tutorial1
//
//  Created by Michael Daley on 06/03/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Image.h"

@interface SpriteSheet : NSObject {
	
	// Image to be used within this sprite sheet
	Image *image;
	// Sprite width
	GLuint spriteWidth;
	// Sprite height
	GLuint spriteHeight;
	// Spacing between each sprite
	GLuint spacing;
	
}

@property(nonatomic, readonly)Image *image;
@property(nonatomic, readonly)GLuint spriteWidth;
@property(nonatomic, readonly)GLuint spriteHeight;
@property(nonatomic, readonly)GLuint spacing;

- (id)initWithImage:(Image*)spriteSheet spriteWidth:(GLuint)width spriteHeight:(GLuint)height spacing:(GLuint)space;
- (id)initWithImageNamed:(NSString*)spriteSheetName spriteWidth:(GLuint)width spriteHeight:(GLuint)height spacing:(GLuint)space imageScale:(float)scale;
- (Image*)getSpriteAtX:(GLuint)x y:(GLuint)y;

@end
