//
//  PreferenceController.h
//  RaiseMan
//
//  Created by Seonghyeon Choe on 1/12/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const KkabTableBgColorKey;
extern NSString * const KkabEmptyDocKey;

@interface PreferenceController : NSWindowController {
	IBOutlet NSColorWell *colorWell;
	IBOutlet NSButton *checkbox;
}
- (IBAction)changeBackgroundColor:(id)sender;
- (IBAction)changeNewEmptyDoc:(id)sender;
- (IBAction)resetPreference:(id)sender;

- (NSColor *)tableBgColor;
- (BOOL)emptyDoc;
@end
