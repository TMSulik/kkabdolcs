//
//  Layer.m
//  iPhoneGame
//
//  Created by Seonghyeon Choe on 2/3/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import "Layer.h"


@implementation Layer

@synthesize layerID;
@synthesize layerName;
@synthesize layerWidth;
@synthesize layerHeight;
@synthesize layerProperties;

- (id)initWithName:(NSString*)name layerID:(int)lid layerWidth:(int)width layerHeight:(int)height {
	if(self != nil) {
		layerName = name;
		layerID = lid;
		layerWidth = width;
		layerHeight = height;
	}
	return self;
}


- (int)getTileIDAtX:(int)x y:(int)y {
	return layerData[x][y][1];
}


- (int)getGlobalTileIDAtX:(int)x y:(int)y {
	return layerData[x][y][2];
}


- (int)getTileSetIDAtX:(int)x y:(int)y {
	return layerData[x][y][0];
}


- (void)addTileAtX:(int)x y:(int)y tileSetID:(int)tileSetID tileID:(int)tileID globalID:(int)globalID {
	layerData[x][y][0] = tileSetID;
	layerData[x][y][1] = tileID;
	layerData[x][y][2] = globalID;
}

@end
