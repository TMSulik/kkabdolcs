//
//  Foo.h
//  Random
//
//  Created by Seonghyeon Choe on 12/31/09.
//  Copyright 2009 kkabdol. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Foo : NSObject {
	IBOutlet NSTextField *textField;
}
- (IBAction)seed:(id)sender;
- (IBAction)generate:(id)sender;
@end
