//
//  ToDoListAppDelegate.m
//  ToDoList
//
//  Created by Seonghyeon Choe on 1/6/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import "ToDoListAppDelegate.h"

@implementation ToDoListAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	mutableArray = [[NSMutableArray alloc] init];
}

- (IBAction)addToDo:(id)sender
{
	NSString *string = [textField stringValue];

	if ([string length] == 0) {
		NSLog(@"Nothing to add");
		return;
	}
	
	if([tableView selectedRow] == -1)
		[mutableArray addObject:string];
	else
		[mutableArray replaceObjectAtIndex:[tableView selectedRow] withObject:string];
	
	[tableView reloadData];
	[textField setStringValue:@""];
}

// Data source methods of NSTableView

- (int)numberOfRowsInTableView:(NSTableView *)tv
{
	return [mutableArray count];
}

- (id)tableView:(NSTableView *)tv 
objectValueForTableColumn:(NSTableColumn *)tableColumn
			row:(int)row
{
	NSString *v = [mutableArray objectAtIndex:row];
	return v;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
	if ([tableView selectedRow] == -1) {
		[button setTitle:@"Add"];
		NSLog(@"%@", [button title]);
	} 
	else if ([[textField stringValue] length] != 0) {
		[button setTitle:@"Replace"];
		NSLog(@"%@", [button title]);
	}
}

@end
