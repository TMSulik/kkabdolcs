//
//  MyDocument.h
//  OldRaiseMan
//
//  Created by Seonghyeon Choe on 1/8/10.
//  Copyright 2010 kkabdol. All rights reserved.
//


#import <Cocoa/Cocoa.h>
@class Person;

@interface MyDocument : NSDocument
{
	NSMutableArray *employees;
	IBOutlet NSTableView *tableView;
}
- (IBAction)createEmployee:(id)sender;
- (IBAction)deleteSelectedEmployees:(id)sender;
@end
