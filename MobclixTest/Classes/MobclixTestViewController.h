//
//  MobclixTestViewController.h
//  MobclixTest
//
//  Created by Seonghyeon Choe on 4/10/11.
//  Copyright 2011 Kkabdol. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MobclixAdView.h"

@interface MobclixTestViewController : UIViewController <MobclixAdViewDelegate> {
	
@private
	MobclixAdView* adView;
}

@property (nonatomic, retain) IBOutlet MobclixAdView* adView;

@end

