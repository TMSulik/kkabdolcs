//
//  AppController.h
//  RaiseMan
//
//  Created by Seonghyeon Choe on 1/12/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class PreferenceController;
@class AboutPanel;

@interface AppController : NSObject {
	PreferenceController *preferenceController;
	AboutPanel *aboutPanel;
	
}
- (IBAction)showPreferencePanel:(id)sender;
- (IBAction)showAboutPanel:(id)sender;

@end
