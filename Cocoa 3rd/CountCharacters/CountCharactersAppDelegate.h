//
//  CountCharactersAppDelegate.h
//  CountCharacters
//
//  Created by Seonghyeon Choe on 1/6/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CountCharactersAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	
	IBOutlet NSTextField *textField;
	IBOutlet NSTextField *resultCount;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)countCharacters:(id)sender;
@end
