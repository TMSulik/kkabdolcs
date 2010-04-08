//
//  FirstViewController.h
//  Accelerator
//
//  Created by Seonghyeon Choe on 4/8/10.
//  Copyright kkabdol 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController {
	UILabel *dateLabel;
	UILabel *timeLabel;
	UIButton *startStopButton;
	UIButton *resetButton;
}

@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UIButton *startStopButton;
@property (nonatomic, retain) IBOutlet UIButton *resetButton;

- (void)updateClock;
@end
