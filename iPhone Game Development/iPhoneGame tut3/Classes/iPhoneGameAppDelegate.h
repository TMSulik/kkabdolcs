//
//  iPhoneGameAppDelegate.h
//  iPhoneGame
//
//  Created by Seonghyeon Choe on 1/21/10.
//  Copyright kkabdol 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGLView;

@interface iPhoneGameAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    EAGLView *glView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet EAGLView *glView;

@end

