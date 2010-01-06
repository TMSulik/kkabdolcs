//
//  ToDoListAppDelegate.h
//  ToDoList
//
//  Created by Seonghyeon Choe on 1/6/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ToDoListAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
