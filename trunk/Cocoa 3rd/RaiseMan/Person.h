//
//  Person.h
//  RaiseMan
//
//  Created by Seonghyeon Choe on 1/7/10.
//  Copyright 2010 University of Seoul. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject <NSCoding> {
	NSString *personName;
	float expectedRaise;	// Cannot be nil
}
@property (readwrite, copy) NSString *personName;
@property (readwrite) float expectedRaise;

@end
