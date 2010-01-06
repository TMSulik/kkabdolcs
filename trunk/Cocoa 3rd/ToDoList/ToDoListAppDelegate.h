//
//  ToDoListAppDelegate.h
//  ToDoList
//
//  Created by Seonghyeon Choe on 1/6/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ToDoListAppDelegate 
: NSObject <NSApplicationDelegate, NSTabViewDelegate> {
    NSWindow *window;
	IBOutlet NSTextField *textField;
	IBOutlet NSTableView *tableView;
	IBOutlet NSButton *button;
	
	NSMutableArray *mutableArray;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)addToDo:(id)sender;

@end
