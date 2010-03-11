//
//  CellsAppDelegate.h
//  Cells
//
//  Created by Seonghyeon Choe on 3/11/10.
//  Copyright kkabdol 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CellsViewController;

@interface CellsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CellsViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CellsViewController *viewController;

@end

