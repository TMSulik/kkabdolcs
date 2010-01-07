//
//  AppController.h
//  KVCFun
//
//  Created by Seonghyeon Choe on 1/7/10.
//  Copyright 2010 University of Seoul. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AppController : NSObject {
	int fido;
}

@property(readwrite, assign) int fido;

- (IBAction)incrementFido:(id)sender;

@end
