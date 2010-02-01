//
//  MyDocument.h
//  RaiseMan
//
//  Created by Seonghyeon Choe on 1/7/10.
//  Copyright 2010 University of Seoul. All rights reserved.
//


#import <Cocoa/Cocoa.h>

#import "Person.h"

@interface MyDocument : NSDocument
{
	NSMutableArray *employees;
	IBOutlet NSTableView *tableView;
	IBOutlet NSArrayController *employeeController;
}
- (IBAction)createEmployee:(id)sender;
- (IBAction)removeEmployee:(id)sender;

- (void)setEmployees:(NSMutableArray *)a;

// NSArrayController uses by insert:, remove: messages
- (void)insertObject:(Person *)p inEmployeesAtIndex:(int)index;
- (void)removeObjectFromEmployeesAtIndex:(int)index;

- (void)startObservingPerson:(Person *)person;
- (void)stopObservingPerson:(Person *)person;

- (void)windowDidResize:(NSNotification *)aNotification;
@end
