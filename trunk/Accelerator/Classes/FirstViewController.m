//
//  FirstViewController.m
//  Accelerator
//
//  Created by Seonghyeon Choe on 4/8/10.
//  Copyright kkabdol 2010. All rights reserved.
//

#import "FirstViewController.h"


@implementation FirstViewController
@synthesize dateLabel;
@synthesize timeLabel;
@synthesize startStopButton;
@synthesize resetButton;

- (void)updateClock
{
	NSDate *now = [NSDate date];
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	// Update Time (Hour, Minute, Second)
	NSUInteger calendarUnits = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents *nowComp = [calendar components:calendarUnits fromDate:now];
	NSString *string = [[NSString alloc] initWithFormat:@"%2d:%2d:%2d", [nowComp hour], [nowComp minute], [nowComp second]];
	timeLabel.text = string;
	[string release];
	
	// Update Date (Day, Month, Year)
	calendarUnits = NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
	nowComp = [calendar components:calendarUnits fromDate:now];
	string = [[NSString alloc] initWithFormat:@"%d %d %d", [nowComp day], [nowComp month], [nowComp year]];
	dateLabel.text = string;
	
	[string release];
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self updateClock];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
