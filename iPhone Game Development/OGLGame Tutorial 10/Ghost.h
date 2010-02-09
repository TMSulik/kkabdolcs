//
//  Monk.h
//  Tutorial1
//
//  Created by Michael Daley on 22/06/2009.
//  Copyright 2009 Michael Daley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractEntity.h"

@class GameScene;

@interface Ghost : AbstractEntity {
    Director *_sharedDirector;
    SpriteSheet *_spriteSheet;
    Animation *_animation;
    float _speed;
    float _angle;
    GameScene *_scene;
    int _tileWidth, _tileHeight;
}

// Designated initializer which allows this actor to be placed on the tilemap using
// tilemap grid locations.
- (id)initWithTileLocation:(Vector2f)aLocation;

@end
