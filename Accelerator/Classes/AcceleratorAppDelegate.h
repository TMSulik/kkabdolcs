//
//  AcceleratorAppDelegate.h
//  Accelerator
//
//  Created by Seonghyeon Choe on 4/8/10.
//  Copyright kkabdol 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TabBarController;

@interface AcceleratorAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    TabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TabBarController *tabBarController;

@end
