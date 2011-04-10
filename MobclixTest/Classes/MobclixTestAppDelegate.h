//
//  MobclixTestAppDelegate.h
//  MobclixTest
//
//  Created by Seonghyeon Choe on 4/10/11.
//  Copyright 2011 Kkabdol. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MobclixTestViewController;

@interface MobclixTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MobclixTestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MobclixTestViewController *viewController;

@end

