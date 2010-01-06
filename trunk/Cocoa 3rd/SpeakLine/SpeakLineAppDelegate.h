//
//  SpeakLineAppDelegate.h
//  SpeakLine
//
//  Created by Seonghyeon Choe on 1/6/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SpeakLineAppDelegate : NSObject <NSApplicationDelegate, NSSpeechSynthesizerDelegate> 
{
    NSWindow *window;
	
	IBOutlet NSTextField *textField;
	NSSpeechSynthesizer *speechSynth;
	
	IBOutlet NSButton *stopButton;
	IBOutlet NSButton *speakButton;
	
	IBOutlet NSTableView *tableView;
	NSArray *voiceList;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)sayIt:(id)sender;
- (IBAction)stopIt:(id)sender;
@end
