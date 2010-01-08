//
//  Person.h
//  OldRaiseMan
//
//  Created by Seonghyeon Choe on 1/8/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Person : NSObject {
	NSString *personName;
	float expectedRaise;
}
@property (readwrite, copy) NSString *personName;
@property (readwrite) float expectedRaise;
@end
