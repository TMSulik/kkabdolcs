//
//  LotteryEntry.h
//  lottery
//
//  Created by Seonghyeon Choe on 1/1/10.
//  Copyright 2010 kkabdol. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LotteryEntry : NSObject {
	NSCalendarDate *entryDate;
	int firstNumber;
	int secondNumber;
}
- (id)initWithEntryDate:(NSCalendarDate *)theDate;
- (void)setEntryDate:(NSCalendarDate *)date;
- (NSCalendarDate *)entryDate;
- (int)firstNumber;
- (int)secondNumber;
@end
