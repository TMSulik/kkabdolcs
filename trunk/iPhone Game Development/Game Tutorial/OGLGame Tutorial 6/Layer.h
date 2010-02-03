//
//  Layer.h
//  Tutorial1
//
//  Created by Michael Daley on 05/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAX_MAP_WIDTH 500
#define MAX_MAP_HEIGHT 500

@interface Layer : NSObject {
	// The layers index
	int layerID;
	// The layers name
	NSString *layerName;
	// Tile data where the 3rd dimension is index 0 = tileset, index 1 = tile id, index 2 = global id
	// Currently hardcoded to a max of 1024x1024
	int layerData[MAX_MAP_WIDTH][MAX_MAP_HEIGHT][3];
	// The width of the layer
	int layerWidth;
	// The height of layer layer
	int layerHeight;
	// Layer properties
	NSMutableDictionary *layerProperties;
}

@property(nonatomic, readonly) int layerID;
@property(nonatomic, readonly) NSString *layerName;
@property(nonatomic, readonly) int layerWidth;
@property(nonatomic, readonly) int layerHeight;
@property(nonatomic, retain) NSMutableDictionary *layerProperties;

- (id)initWithName:(NSString*)name layerID:(int)lid layerWidth:(int)width layerHeight:(int)height;
- (void)addTileAtX:(int)x y:(int)y tileSetID:(int)tileSetID tileID:(int)tileID globalID:(int)globalID;
- (int)getTileSetIDAtX:(int)x y:(int)y;
- (int)getGlobalTileIDAtX:(int)x y:(int)y;
- (int)getTileIDAtX:(int)x y:(int)y;

@end
