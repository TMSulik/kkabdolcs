//
//  MobclixTestViewController.m
//  MobclixTest
//
//  Created by Seonghyeon Choe on 4/10/11.
//  Copyright 2011 Kkabdol. All rights reserved.
//

#import "MobclixTestViewController.h"

@implementation MobclixTestViewController
@synthesize adView;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[self.adView cancelAd];
	self.adView.delegate = nil;
	self.adView = nil;
}


- (void)dealloc {
	[self.adView cancelAd];
	self.adView.delegate = nil;
	self.adView = nil;
	
	[super dealloc];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.adView resumeAdAutoRefresh];
	NSLog(@"Mobclix resumeAdAutoRefresh");
}

- (void)viewWillDisappear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	[self.adView pauseAdAutoRefresh];
	NSLog(@"Mobclix pauseAdAutoRefresh");
}


#pragma mark -
#pragma mark MobclixAdView Delegate Methods
- (void)adViewDidFinishLoad:(MobclixAdView*)adView{
	NSLog(@"Mobclix adViewDidFinishLoad");
}
- (void)adView:(MobclixAdView*)adView didFailLoadWithError:(NSError*)error{
	NSLog(@"Mobclix didFailLoadWithError %@", [error localizedDescription]);

}
- (BOOL)adView:(MobclixAdView*)adView shouldHandleSuballocationRequest:(MCAdsSuballocationType)suballocationType{
	
	BOOL retValue = NO;
	
	switch (suballocationType) {
		case kMCAdsSuballocationOpen:
			NSLog(@"Mobclix shouldHandleSuballocationRequest kMCAdsSuballocationOpen");
			break;
		case kMCAdsSuballocationIAd:
			NSLog(@"Mobclix shouldHandleSuballocationRequest kMCAdsSuballocationIAd");
			break;
		case kMCAdsSuballocationAdMob:
			NSLog(@"Mobclix shouldHandleSuballocationRequest kMCAdsSuballocationAdMob");
			retValue = YES;
			break;
		case kMCAdsSuballocationGoogle:
			NSLog(@"Mobclix shouldHandleSuballocationRequest kMCAdsSuballocationGoogle");
			break;
		default:
			NSLog(@"Mobclix shouldHandleSuballocationRequest unknown");
			break;
	}
	return retValue;
}
- (void)adView:(MobclixAdView*)adView didReceiveSuballocationRequest:(MCAdsSuballocationType)suballocationType{
	NSLog(@"Mobclix didReceiveSuballocationRequest");
	
}
- (NSString*)adView:(MobclixAdView*)adView publisherKeyForSuballocationRequest:(MCAdsSuballocationType)suballocationType{
	
	NSString *retString = nil;
	
	switch (suballocationType) {
		case kMCAdsSuballocationOpen:
			NSLog(@"Mobclix publisherKeyForSuballocationRequest kMCAdsSuballocationOpen");
			break;
		case kMCAdsSuballocationIAd:
			NSLog(@"Mobclix publisherKeyForSuballocationRequest kMCAdsSuballocationIAd");
			break;
		case kMCAdsSuballocationAdMob:
			NSLog(@"Mobclix publisherKeyForSuballocationRequest kMCAdsSuballocationAdMob");
			retString = @"a14d9952e6ce34f";
			break;
		case kMCAdsSuballocationGoogle:
			NSLog(@"Mobclix publisherKeyForSuballocationRequest kMCAdsSuballocationGoogle");
			break;
		default:
			NSLog(@"Mobclix publisherKeyForSuballocationRequest unknown");
			break;
	}
	
	return retString;
}

- (void)adViewWillTouchThrough:(MobclixAdView*)adView{
	NSLog(@"Mobclix adViewDidFinishLoad");
	
}
- (void)adViewDidFinishTouchThrough:(MobclixAdView*)adView{
	NSLog(@"Mobclix adViewDidFinishLoad");
	
}
- (void)adView:(MobclixAdView*)adView didTouchCustomAdWithString:(NSString*)string{
	NSLog(@"Mobclix didTouchCustomAdWithString %@", string);
	
}
@end
