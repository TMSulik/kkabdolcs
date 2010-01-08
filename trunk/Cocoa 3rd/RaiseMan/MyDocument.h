//
//  MyDocument.h
//  RaiseMan
//
//  Created by Seonghyeon Choe on 1/7/10.
//  Copyright 2010 University of Seoul. All rights reserved.
//


#import <Cocoa/Cocoa.h>

@interface MyDocument : NSDocument
{
	NSMutableArray *employees;
}
- (void)setEmployees:(NSMutableArray *)a;
@end
